// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract EtherUints {
    uint public oneWei = 1 wei;
    // 1 wei = 1
    bool public  isOneWei = 1 wei == 1;

    uint public oneEther = 1 ether;
    // 1 ether = 10^18 wei
    bool public isOneEther = 1 ether == 1e18;
}