// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
//примеры передачи аргументов в constructors
// базовый контракт Х
contract X{
    string public name;

    constructor(string memory _name){
        name = _name;
    }
}
// контракт У
contract Y {
    string public text;

    constructor(string memory _text){
        text = _text;
    }
}
//существует 2 способа инициализации родительского контракта параметрами 
// передать параметры в списке наследования
contract B is X("Input to X"), Y("Input to Y"){

}
contract C is X, Y {
    // передать параметры в конструкторе, аналогично модификаторам функции
    constructor(string memory _name, string memory _text) X(_name) Y(_text){}
}
//Родительские конструкторы всегда вызываются в порядке наследования независимо от порядка родительских договоров перечисленных в конструктор дочернего контракта
// порядок конструкторов
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}
// порядок конструкторов
// 1. X 
// 2. Y
// 3. E
contract E is X, Y{
    constructor() Y("Y was called") X("X was called"){}
}