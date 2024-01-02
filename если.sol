// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract IfElse {
    function foo(uint x) public  pure returns (uint){
        if (x < 10){
            return 0;
        } else if (x < 20){
            return 1;
        } else {
            return 2;
        }
    }
    function ternary(uint _x) public pure returns (uint){
        // if (_x < 10){
            // return 1;
            // }
            //return 2;
            //сокращеное написание if/else
            // ? троичный оператор
            return _x < 10 ? 1 : 2;
    
    }
}