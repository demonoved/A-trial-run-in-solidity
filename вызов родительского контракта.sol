// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.20;
/*    A
    /   \
   B     C
    \   /
      D
*/
contract A{
    //называется событием. можно генерировать из своей функции и они регистрируются в журнале транзакций.
    // в данном случае это полезно для трассировки вызовов функции
    event Log(string massage);
    function foo() public virtual {
        emit Log("A.foo called");
    }
    function bar() public virtual {
        emit Log("A.bar called");
    }
}
contract B is A {
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    }
    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}
contract C is A{
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }
    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}
contract D is B, C {
    function foo() public override (B, C){
        super.foo();
    }
    function bar() public override (B, C){
        super.bar();
    }
}