// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// gas - единица вычисления
// gas spent - общая сумма использованого газа в транзакции
// gas prise - то сколько готовы заплатить газа
// gas limit - максимальное количество газа которое вы готовы использовать в транзакции
// block gas limit - максимально количество газа установленое сетью для блока
contract Gas { 
    uint public i = 0;
    // использование всего отправленого газа приведет к сбою транзакции
    // потраченый газ не возвращается
    function forever() public {
        //запускаем цикл пока не потратится весь газ
        // в конце будет неудача из-за потраченного газа
       while (true) {
        i += 1;
       }
    }
}