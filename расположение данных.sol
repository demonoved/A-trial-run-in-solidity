// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
//storage - переменная состояния, храниться в блокчейне
//memory - переменная гаходится в памяти и существует во время вызова функции
//calldata - специальное расположение данных, содержащее аргументы функции
contract DataLocation{
    uint[] public arr;
    mapping(uint => address) map;
    struct MyStruct {
        uint foo;
    }
    mapping(uint => MyStruct) myStructs;
    function f() public {
        //вызов f с переменными состояния
        _f(arr, map, myStructs[1]);
        //получение структуры из сопоставления
        MyStruct memory myMemStruct = MyStruct(0);
    }
    function _f(
        uint[] storage _arr,
        mapping (uint => address) storage _map,
        MyStruct storage _myStuct
    ) internal {
        //что сделать с переменными хранилища
    }
    //можно возвращать переменные памяти
    function g(uint[] memory _arr) public returns (uint[] memory){
        // сделать что то с массивом памяти
    }
    function h(uint[] calldata _arr) external {
        //сделать что то с массивом callData
    }
}