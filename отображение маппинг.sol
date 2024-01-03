// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract Mapping {
    // сопоставление адреса с uint
    mapping (address => uint) public myMap;
    function get(address _addr) public view returns (uint){
        //если значение не задано, будет возвращено по умолчанию
        //mapping всегда возвращает значение
        return myMap[_addr];
    }
    function set(address _addr, uint _i) public {
        //обновление значение по адрессу
        myMap[_addr] = _i;
    }
    function remove(address _addr) public {
        //возвращает значение до значения по умолчанию
        delete myMap[_addr];
    }
}
contract NestedMapping {
    //вложенное сопоставление, сопоставление из адреса в другое сопоставление
    mapping (address => mapping(uint => bool)) public nested;

    function get (address _addr1, uint _i) public view returns (bool){
        //значения можно получить из вложенного сопоставления
        //даже если он не инициализирован
        return nested[_addr1][_i];
    }
    function set(address _addr1, uint _i, bool _boo) public {
        nested [_addr1][_i] = _boo;
    }
    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}