// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// библиотеки похожи на контракты, но вы не можете обьявить какую-либо переменную состояния и вы не можете отправить эфир
// библиотека встраивается в контракт, если все библиотечные функции являются внутренними
// в противном случае библиотека должна быть развернута, а затем скомпонована перед развертыванием контракта
library Math {
    function sqrt(uint y) internal pure returns (uint z){
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z){
                z = x;
                x = (y / x + x) / 2;
            }
        } else if ( y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }
}
contract TestMath {
    function testSquareRoot (uint x) public  pure returns (uint) {
        return Math.sqrt(x);
    }
}
//функция массива для удаления элемента по индексу и реорганизации массива
// чтобы между элементами не было зазоров
library Array {
    function remove(uint[] storage arr, uint index) public {
        // переместите последний элемент в место для удаления
        require(arr.length > 0, "Can't remove from empty array");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}
contract TestArray {
    using Array for uint[];
    uint[] public  arr;
    function tastArrayRemove() public {
        for (uint i = 0; i < 3; i++){
            arr.push(i);
        }
        arr.remove(1);

        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
    }
}