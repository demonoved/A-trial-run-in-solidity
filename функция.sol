// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract Function {
    //функции могут возвращать несколько значений
    function returnMany() public pure returns (uint, bool, uint){
        return (1, true, 2);
    }
    //можно назвать возвращаемые значения
    function named() public pure returns (uint x, bool b, uint y){
        return (1, true, 2);
    }
    //возвращаемым значениям можно присвоить имена, и тогда нет необходимости в операторе return
    function assigned() public pure returns (uint x, bool b, uint y){
        x = 1;
        b = true;
        y = 2;
    }
    //использование деструктиризующего присваивания при вызове другой функции, которая возвращает несколько значений
    function destructuringAssignments()
    public 
    pure 
    returns (uint, bool, uint, uint, uint)
    {
        (uint i, bool b, uint j) = returnMany();
        //значения могут быть опущены
        (uint x, , uint y) = (4, 5, 6);
        return (i, b, j, x, y);
    }
    //можно использовать массив для ввода 
    function arrayInput(uint[] memory _arr) public {}
    //можно использовать массив для вывода
    uint[] public arr;
    function arrayOutput() public view returns (uint[] memory){
        return arr;
    }

}
//вызов функции с входными данными "ключ-значения"
contract XYZ{
    function someFuncWithManyInputs(
        uint x,
        uint y,
        uint z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint) {}
    function callFunc() external pure returns (uint){
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
    }
    function callFuncWithKeyValue() external pure returns (uint){
        return 
        someFuncWithManyInputs({a: address(0), b: true, c:"c", x: 1, y: 2, z: 3});
    }
}