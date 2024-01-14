// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.20;
// функции и переменные состояния должны обьявлять доступны ли они контрактам
// public любой контракт и счет имеют доступ
// private только внутри контракта определяющего функцию
// internal только внутри контракта с унаследованной функцией internal
// external только другим контрактам и счетам
contract Base{
    // приватная функция может быть вызвана только внутри настоящего контракта, причем контракты которые унаследуют этот контракт не смогут вызвать эту функцию
    function privateFunc() private pure returns (string memory){
        return "private function called";
    }
    function testPrivateFunc() public pure returns (string memory){
        return privateFunc();
    }
    //internal внутренняя функция может быть вызвана внутри настоящего контрактка или внутри контрактов унаследуют этот контракт
    function internalFunc() internal pure returns (string memory){
        return "internal function called";
    }
    function testInternalFunc() public pure virtual returns (string memory){
        return internalFunc();
    }
    //public публичные функции могут быть вызваны внутри настоящего контракта и контрактам которые наследуют этот контракт по другим договорам и счетам
    function publicFunc() public pure returns (string memory){
        return "public function called";
    }
    // external внешние функции могут быть вызваны только по другим контрактам и счетам
    function externalFunc() external pure returns (string memory){
        return "external function called";
    }
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
    // не может быть внешним по этому не компилируется string external externalVar = "my external variable";

}
contract Child is Base {
    // унаследованные контракты не имеют доступа к закрытым функциям
    // function testPrivateFunc() public pure returns (string memory) {
    //     return privateFunc();
    // }
    // вызов внутренней функции вызывается внутри дочерних контрактов
    function testInternalFunc() public pure override returns (string memory){
        return internalFunc();
    }
}