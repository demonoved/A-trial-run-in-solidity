// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.20;
// переменные состояния не могут быть переопределены путем их повторного обьявления в дочернем договоре
contract A {
    string public name = "Contract A";
    function getName() public view returns(string memory){
        return name;
    }
}
contract C is A{
    //правильный способ унаследования переменных состояния
    constructor() {
        name = "Contract C";
    }
}

