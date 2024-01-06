// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;

contract Counter {
    uint public count;
    // функция для счетчика
    function get () public view returns (uint){
        return count;
    }
    // функция увеличения счетчика +1
    function inc() public {
        count += 1;
    }
    // функция уменьшения счетчика -1
    function dec() public {
        //будет ошибка если count=0
        count -= 1;
    }
}
           

