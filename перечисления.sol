// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
//перечисления полезны для выбора модели и отслеживания состояния, перечисления могут быть обьявлены вне контракта
contract Enum { 
    // перечисление предоставляет статус отгрузки
    enum Status {
        Pending, //ожидание
        Shipped, // отправленный
        Accepted, // принятый
        Rejected, // отклоненный
        Canceled // отменненый
    }
    // значением по умолчанию является первый элемент в статусе в данном случае ожидание
    Status public status;
    //возвращаем uint
    //Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns (Status){
        return status;
    }
    //обновление статуса путем передачи uint во входные данные
    function set(Status _status) public {
        status = _status;
    }
    //можно обновиться до определенного перечисления следующим образом
    function cancel() public {
        status = Status.Canceled;
    }
    // delete сбрасывает перечисление до первого значения 0
    function reset() public {
        delete status;
    }
}