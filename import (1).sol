// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// импортируем Foo
import "./Foo.sol"
// import {symbol1 as alias, symbol2} from "filename";
import {Unauthorized, add  func, Point} from "./Foo.sol";
contract Import {
    Foo public  foo = new Foo();
    function getFooName() public view returns (string memory){
        return foo.name();
    }
}
// так же можно импортировать с GitHub просто скопировав url
// https://github.com/owner/repo/blob/branch/path/to/Contract.sol
import "https://github.com/owner/repo/blob/branch/path/to/Contract.sol";

// Example import ECDSA.sol from openzeppelin-contract repo, release-v4.5 branch
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";