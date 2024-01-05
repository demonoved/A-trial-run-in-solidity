// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
//развернем любой контракт вызвав proxy.deploy
//можно получить байт код контракта вызвав getBytecode
contract Proxy {
    event Deploy(address);
    receive() external payable {}
    function deploy(bytes memory _code) external payable returns (address addr){
        assembly {
            //cоздаем (v,p,n)
            // v = количество ETH для отправки
            // p = указатель в памяти на начало кода
            // n = размер кода
            addr := create(callvalue(), add(_code, 0x20),mload(_code))
        }
        // обратный адрес 0 при ошибке
        require(addr != address(0), "deploy failed"); // сбой развертывания
        emit Deploy(addr);
    }
    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}
contract TestContract1 {
    address public owner = msg.sender;
    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}
contract TestContract2 {
    address public  owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;
    
    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}
contract Helper {
    function getBytecode1() external pure returns (bytes memory){
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }
    function getBytecode2(uint _x, uint _y) external pure returns (bytes memory){
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }
    function getCalldata(address _owner) external pure returns (bytes memory){
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}