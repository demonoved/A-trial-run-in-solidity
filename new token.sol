// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// используя  open zeppelin можно сделать свой собственный токен
import  "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";
contract NewToken is ERC20{
    constructor(string memory name, string memory symbol) ERC20(name, symbol){
        // минтим 100 токенов в msg.sender
        // примерно как 1 доллар = 100 центов
        // 1 token = 1 *(10 ** decimals)
        _mint(msg.sender, 100 * 10 * uint(decimals()));
    }
}