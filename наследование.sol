// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// solidity поддерживает множественное наследование. Контракты могут наследовать другие контракты с помощью "is"
// функция которая будет предопределена дочерним контрактом должна быть обьявлена как "virtual"
// функция которая будет переопределять родительскую функцию должна использовать "override"
// важен и порядок наследования
// нужно перечислять родительские контракты в порядке от "базовых" до "производных"
/* график наследования
        A
       / \
      B   C
     / \ /
    F  D,E
*/
contract A{
    function foo() public pure virtual returns ( string memory){
        return "A";
    }
}
// контракты наследуют другие контракты с помощью "is"
contract B is A {
    // переопределение A.foo()
    function foo() public pure virtual  override  returns (string memory){
        return "B";
    }
}
contract C is A {
// переопределение A.foo()
function foo() public pure virtual override returns (string memory){
    return "C";
    }
}
//контракты могут наследоваться от нескольких родительских контрактов, при вызове функции которая определена несколько раз в различных контрактах, родительские контракты ищутся справа налево и вниз
contract D is B, C {
    // D.foo возвращается как "С"
    // так как является самым правильным родительским контрактом функции foo()
    function foo() public pure override (B, C) returns (string memory){
        return super.foo();
    }
}
contract E is C, B {
    //E.foo() возвращается как "B"
    // так как является самым правильным родительским контрактом с функцией foo()
    function foo() public pure override (C, B) returns (string memory){
        return super.foo();
    }
}
//наследование должно идти от базового до производного 
contract F is A, B {
    function foo() public pure override (A, B) returns (string memory){
        return super.foo();
    }
}