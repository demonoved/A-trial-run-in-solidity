// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
//массив может иметь как фиксированный размер во время компиляции так и динамический размер 
contract Array {
    //способы инициализации массивов
    uint[] public  arr;
    uint[] public arr2 = [1,2,3];
    //массив фиксированного размера, все значения инициализируются значением 0
    uint[10] public myFixedSixeArr;

    function get(uint i) public view  returns (uint){
        return arr[i];
    }
    // солидити может вернуть весь массив
    //но следует избегать этой функции для массивов которые могут бесконечно увеличиваться в длину
    function getArr() public view returns (uint[] memory){
        return arr;
    }
    function push(uint i) public {
        // добавит в массив это увеличит длину массива на 1
        arr.push(i);
    }
    function pop() public {
        //удалить последний элемент из массива это уменьшит длинну массива на 1
        arr.pop();
    }
    function getLength() public view returns (uint){
        return arr.length;
    }
    function remove(uint index) public {
        // не изменяет длину массива, он сбрасывает значение index до значения по умолчанию, в данном случае 0
        delete arr[index];
    }
    function examples() external{
        // создаст массив в памяти, только фиксированный размер
        uint[] memory a = new uint[] (5);
    }
}