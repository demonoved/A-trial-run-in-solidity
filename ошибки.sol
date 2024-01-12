// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// ошибка отменяет все изменения внесенные в состояние во время транзакции
// можно выдать ошибку вызвав require revert assert 
// require проверка входных данных и условий перед выполнением
// assert проверка кода, который никогда не должен быть ложным, недостающий assertion вероятно означает что есть ошибка
contract Error {
    function testRequire (uint _i) public pure {
        //require следует использовать для проверки входов, условий перед выполнением, возвращать значения из вызовов других функций
        require (_i > 10, "Input must be greater than 10");
    } 
    function testRevert(uint _i) public pure {
        // revert полезен когда проверяемое условие является сложным
        // тот же самый код что в примере выше
        if(_i <= 10) {
            revert("Imput mus be greater than 10");
        }
    }
    uint public num;
    function testAssert() public view {
        // assert следует использовать только для проверки внутренних ошибок
        // тут мы утверждаем что num всегда равен 0, так как невозможно обновить значение num
        assert(num == 0);
    }
    //кастомная ошибка 
    error InsufficientBalance(uint balance, uint withdrawAmount);
    function testCustomError(uint _withdrawAmount) public view{
        uint bal = address(this).balance;
        if (bal < _withdrawAmount){
            revert InsufficientBalance({balance: bal, withdrawAmount: _withdrawAmount});
        }
    }
}