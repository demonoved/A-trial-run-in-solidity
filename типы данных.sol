// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract Primitives{
    bool public boo = true;
    /* uint означает целое число без остатка, не отрицательные числа
    uint8   до 0 to 2 ** 8 - 1
        uint16  до 0 to 2 ** 16 - 1
        ...
        uint256 до 0 to 2 ** 256 - 1
        */
    uint8 public u8 = 1;
    uint public u256 = 456;
    uint public u = 123; //uint = uint256
    /* int тоже самое что и uint только отрицательное
    int256 до -2 ** 255 to 2 ** 255 - 1
    int128 до -2 ** 127 to 2 ** 127 - 1 */
    int8 public i8 = -1;
    int public i256 = 456;
    int public i = -123;//int = int256
    //минимальный и максимальный int
    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    /* тип данных byte это последовательность байтов 
    фиксированный массив байтов
    динамический массив байтов */
    bytes1 a = 0xb5; //[10110101]
    bytes1 b = 0x56; //[01010110]
    //значения по умолчанию 
    // неназначеным переменным будут присвоены значения по умолчанию 
    bool public defaultboo;  // false
    uint public defaultuint; // 0
    int public defaultint;   // 0 
    address public  defaultaddr; // 0x0000000000000000000000000000000000000000
}