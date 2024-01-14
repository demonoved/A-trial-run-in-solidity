// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// отправить эфир можно : "transfer" - 2300газа, выбросит ошибку, "send" - 2300газа, возвращает bool, "call" - пересылает весь газ или устанавливаем газ, возвращает bool
// получить эфир : "receive() external payable", "fallback() external payable"
contract ReceiveEther{
    /*
    какую функцию выбрать ? 
                отправить эфир
                      |
                 msg.data пуст ?
                 /          \
                да          нет
                /             \
        receive() есть?      fallback()
         /           \
        да           нет
        /              \
    receive()        fallback()
    */
    //функция receive для получения эфира, msg.data должна быть пуста
    receive() external payable { }
    
    // fallback функция вызывается когда msg.data пуста
    fallback() external payable {}
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}
contract SendEther { 
    //данная функция больше не рекомендуется для отправки эфира
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }
    function sendViaSend(address payable _to) public payable {
        //не  рекомендуется для отправки, возвращает логическое значение указывающий успех или неудачу
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }
    function sendViaCall(address payable  _to) public payable {
        //возвращает логическое значение указывающее на успех или неудачу, рекомендуемый метод
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}