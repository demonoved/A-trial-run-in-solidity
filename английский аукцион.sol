// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// 1. продавец NFT разворачивает этот контракт
// 2. аукцион длится 7 дней
// 3. участники могут делать ставки, внося свой ETH на сумму, превышающую текущую самую высокую цену
// 4. все участники могут отозвать свою ставку, если она не является текущей самой высокой ставкой
// 5. тот, кто предложил самую высокую цену, становится новым владельцем NFT
// 6. продавец получает самую высокую ставку ETH
interface IERC721 {
    function safeTransferFrom( address from, address to, uint tokenId) external ;
    function transferFrom(address, address, uint) external;
}
contract EnglishAuction{
    event Start();
    event Bid(address indexed sender, uint amount);
    event WithDraw(address indexed bidder, uint amount);
    event End(address winner, uint amount);

    IERC721 public nft;
    uint public nftId;
    address payable public seller;
    uint public endAt;
    bool public started;
    bool public ended;
    address public  highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    constructor(address _nft, uint _nftId, uint _startingBid){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }
    function start() external {
        require(!started, "started");
        require(msg.sender == seller, "not seller");
        nft.transferFrom(msg.sender, address(this), nftId);
        started = true;
        endAt = block.timestamp + 7 days;
        emit Start();
    }
    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "value < highest");

        if (highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit Bid(msg.sender, msg.value);
    }
    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable (msg.sender).transfer(bal);
        emit WithDraw(msg.sender, bal);
    }
    function end() external {
        require(started, "not started");
        require(block.timestamp >= endAt, "not ended");
        require(!ended, "ended");
        ended = true;
        if (highestBidder != address(0)){
            nft.safeTransferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
            nft.safeTransferFrom(address(this), seller, nftId);
        }
        emit End(highestBidder, highestBid);
    }
}