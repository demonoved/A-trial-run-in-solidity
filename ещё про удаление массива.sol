// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// удалить элемент массива, скопировав последний жллемент в место для удаления
contract ArrayReplaceFromEnd{
    uint[] public arr;
    //при удаление элемента создается разрыв в массиве, что бы сделать массив компактнее можно перенести последний элемент в место разрыва
    function remove(uint index) public{
        //перемешаем последний элемент в место удаления
        arr[index] = arr[arr.length - 1];
        //удаляем последний элемент
        arr.pop();
    }
    function test() public {
        arr = [1,2,3,4];

        remove(1);
        //[1,4,3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        //[1,4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);

    }
}