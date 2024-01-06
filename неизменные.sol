// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract Immutable {
    //соглашение о кодирование константы в верхнем регистре
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;
    constructor (uint _myUint){
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}