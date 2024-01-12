// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// модификаторы - это код который может быть запущен до и\или после вызова функции
//можно использовать для ограничения доступа, проверка входных данных, защита от взлома повторного входа
contract FunctionModifier {
    // воспользуемся данными переменными, для примера как использовать модификаторы
    address public owner;
    uint public x = 10;
    bool public locked;
    constructor (){
        // назначаем отправителя транзакции владельцем контракта
        owner = msg.sender;
    }
    // модификатор для проверки того что вызывающий обьект является владельцем контракта
    modifier onlyOwner(){
        require(msg.sender == owner, "Not owner");
        // "_" специальный символ использующийся только внутри модификатора, используется для выполнения остальной части кода
        _;
    }
    // модификаторы могут принять входные данные , этот пример проверяет что переданный адресс не является нулевым адресом
    modifier validAddress(address _addr){
        require(_addr != address(0), "Not valid address");
        _;
    }
    function changerOwner(address _newOwner) public onlyOwner validAddress(_newOwner){
        owner = _newOwner;
    }
    // модификаторы могут быть вызваны до и\или после функции, данный модификатор предотвращает вызов функции пока выполняется модификатор
    modifier noReentrancy(){
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }
    function decrement(uint i) public noReentrancy {
        x -= i;

        if (i > 1){
            decrement(i - 1);
        }
    }
}