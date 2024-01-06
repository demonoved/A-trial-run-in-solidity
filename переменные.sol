// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// local - внутри функции, не хранится в блокчейне
// state - вне функций, хранится в блокчейне
// global - предоставляет информацию о блокчейне
contract Variables{
    //переменные состояния хранятся в блокчейне 
    string public text = "Hello";
    uint public num = 123;
    function doSomething () public {
        //локальные переменные не сохраняются в блокчейне
        uint i = 456;
        // Некоторые глобальные переменные
        uint timestamp = block.timestamp; // отметка времени текущего блока
        address sender = msg.sender; // адрес входящего
    }
}