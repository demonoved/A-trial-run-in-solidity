// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// events разрешить вход в блокчейн ефира, применение прослушивание событий и обновление пользовательского интерфейса, дешевая форма хранения
contract Event {
    //обьявление о событии , можно индексировать 3 параметра , они помогут фильтровать по этим параметрам
    event Log(address indexed sender, string massege);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM");
        emit AnotherLog();
    }
}