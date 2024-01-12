// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract Account {
    uint public balance;
    uint public constant MAX_UINT = 2 ** 256 -1;
    function deposit(uint _amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + _amount;
        //баланс + _amount не переполняется, если баланс + _amount >= balance
        require(newBalance >= oldBalance, "Overflow");
        balance = newBalance;
        assert(balance >= oldBalance);
    }
    function withdraw(uint _amount) public {
        uint oldBalance = balance;
        // balance - _amount не переполняются, если balance >= _amount
        require(balance >= _amount, "Underflow");
        if (balance < _amount){
            revert("Underflow");
        }
        balance -= _amount;
        assert(balance <= oldBalance);
    }
}