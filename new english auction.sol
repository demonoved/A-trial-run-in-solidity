// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract EnglishAuction is ReentrancyGuard {
    using SafeMath for uint256;

    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address winner, uint amount);

    IERC721 public nft;
    uint public nftId;
    address payable public seller;
    uint public endAt;
    bool public started;
    bool public ended;
    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    // Modifiers
    modifier auctionNotStarted() {
        require(!started, "Auction already started");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Can only be called by the seller");
        _;
    }

    modifier auctionStarted() {
        require(started, "Auction not started");
        _;
    }

    modifier auctionNotEnded() {
        require(block.timestamp < endAt, "Auction already ended");
        _;
    }

    modifier auctionEnded() {
        require(block.timestamp >= endAt, "Auction not yet ended");
        require(!ended, "Auction end already called");
        _;
    }

    constructor(address _nft, uint _nftId, uint _startingBid) {
        require(_startingBid > 0, "Starting bid must be greater than 0");
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external onlySeller auctionNotStarted {
        nft.transferFrom(msg.sender, address(this), nftId);
        started = true;
        endAt = block.timestamp.add(7 days);
        emit Start();
    }

    function bid() external payable auctionStarted auctionNotEnded nonReentrant {
        require(msg.value > highestBid, "Bid must be higher than current highest");

        if (highestBidder != address(0)) {
            payable(highestBidder).transfer(highestBid);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit Bid(msg.sender, msg.value);
    }

    function withdraw() external nonReentrant {
        uint bal = bids[msg.sender];
        require(bal > 0, "No funds to withdraw");

        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    function end() external auctionStarted auctionEnded nonReentrant {
        ended = true;
        if (highestBidder != address(0)) {
            nft.safeTransferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
            nft.safeTransferFrom(address(this), seller, nftId);
        }
        emit End(highestBidder, highestBid);
    }
}