// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// view функция обьявляет что никакое состояние не будет изменено
// pure функция обьявляет что ни одна переменная состояния не будет изменена или прочитана
contract ViewAndPure {
    uint public x = 1;
    // не изменять состояние
    function addToX(uint y) public view returns (uint){
        return x + y;
    }
    // не изменять и не считывать из состояния
    function add(uint i, uint j) public pure returns (uint){
        return i + j;
    }
}