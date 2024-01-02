// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract SimpeStorage {
    // переменная состояния для хранениня числа
    uint public num;
    //отправляем транзакцию для записи в переменную состояния
    function set(uint _num) public {
        num = _num;
    }
    //считывать данные из переменной состояния можно без транзакций 
    function get () public view returns  (uint) {
        return num;
    }
}