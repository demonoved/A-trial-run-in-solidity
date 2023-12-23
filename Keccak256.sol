// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
//keccak256 вычисляет хеш входных данных
// варианты использования : создание детерменированного уникального индефикатора из входных данных
// схема Commit-Reveal
// компактная криптографическая подпись ( путем подписи хэша вместо большого входного параметра
contract HashFunction {
    function hash(
        string memory _text,
        uint _num,
        address _addr
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }
    //пример хеш коллизии
    // хеш коллизия может возникать при  передаче нескольких динамических типов данных
    function collision (
        string memory _text,
        string memory _anotherText
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text, _anotherText));
    }
}
contract GuessTheMagicWord {
    bytes32 public answer = 0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;
    function guess(string memory _word) public view returns (bool){
        return keccak256(abi.encodePacked(_word)) == answer;
    }
}