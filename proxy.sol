// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// если есть контракт который будет развертываться несколько раз, можно использовать минимальный прокси контракт для дешевого развертывания
// ориг https://github.com/optionality/clone-factory/blob/master/contracts/CloneFactory.sol
contract MinimalProxy {
    function clone(address target) external returns (address result) {
        // преобразование адреса в 20 быйт
        bytes20 targetBytes = bytes20(target);
        // актуальный код : 3d602d80600a3d3981f3363d3d373d3d3d363d73bebebebebebebebebebebebebebebebebebebebe5af43d82803e903d91602b57fd5bf3
        // код создания 
        // скопировать код среды выполнения в память и вернуть его 
        //3d602d80600a3d3981f3
        // код времени выполнения 
        // код дл delegatecall по адресу 
        //363d3d373d3d3d363d73 address 5af43d82803e903d91602b57fd5bf3
        assembly {
            /* 
            считывает 32 байта памяти
            начиная с указателя, хранящегося в 0х40
            в solidity слот 0х40 в памяти особенный 
            он содержит указатель свободной памяти 
            который указывает на конец выделенной в данный момент памяти
            */
            let clone := mload(0x40)
            //сохранение 32 байт в памяти, начиная с  clone
            mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
            /*
              |              20 bytes                |
            0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000
                                                      ^
                                                      pointer
            */
            // 32 байта в памяти, начиная с clone + 20 байт
            // 0x14 = 20
            mstore(add(clone, 0x14), targetBytes)
            /*
              |               20 bytes               |                 20 bytes              |
            0x3d602d80600a3d3981f3363d3d373d3d3d363d73bebebebebebebebebebebebebebebebebebebebe
                                                                                              ^
                                                                                              pointer
            */
            //32 байта в памяти, начиная с clone + 40 байт
            // 0x28 = 40
            mstore(add(clone,0x28), 0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000)
            /*
              |               20 bytes               |                 20 bytes              |           15 bytes          |
            0x3d602d80600a3d3981f3363d3d373d3d3d363d73bebebebebebebebebebebebebebebebebebebebe5af43d82803e903d91602b57fd5bf3
            */
            //создаем новый контракт
            // отправляем 0 эфира
            // код начинается с указателя хранящегося в clone
            // размер кода 0х37 ( 55 байт)
            result := create(0, clone, 0x37)
        }
    }
}