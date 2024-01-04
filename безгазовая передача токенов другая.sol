// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.0;

interface ERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract TokenTransfer {
    address private _tokenAddress;
    mapping (address => uint256) private _nonces;

    constructor(address tokenAddress) {
        _tokenAddress = tokenAddress;
    }

    function transferWithSignature(
        address sender,
        address recipient,
        uint256 amount,
        uint256 nonce,
        bytes memory signature
    ) external {
        // Verify the signature is valid
        require(verifySignature(sender, recipient, amount, nonce, signature), "Invalid signature");
        
        // Verify the nonce is correct
        require(_nonces[sender] == nonce, "Invalid nonce");
        
        // Transfer tokens
        ERC20 token = ERC20(_tokenAddress);
        require(token.transferFrom(sender, recipient, amount), "Token transfer failed");
        
        // Increment the nonce
        _nonces[sender]++;
    }

    function verifySignature(
        address sender,
        address recipient,
        uint256 amount,
        uint256 nonce,
        bytes memory signature
    ) private pure returns (bool) {
        bytes32 messageHash = getMessageHash(sender, recipient, amount, nonce);
        address recoveredAddress = recoverSigner(messageHash, signature);
        return recoveredAddress == sender;
    }

    function getMessageHash(
        address sender,
        address recipient,
        uint256 amount,
        uint256 nonce
    ) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(sender, recipient, amount, nonce));
    }

    function recoverSigner(bytes32 messageHash, bytes memory signature) private pure returns (address) {
        require(signature.length == 65, "Invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := and(mload(add(signature, 0x41)), 0xff)
        }
        if (v < 27) {
            v += 27;
        }
        require(v == 27 || v == 28, "Invalid signature recovery");
        return ecrecover(messageHash, v, r, s);
    }
}