// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// можно сделать свой собственный тип создав struct. Полезно для группировки связанных данных, могут быть обьявлены вне контракта и импортированы в другой контракт
contract Todos {
    struct Todo{
        string text;
        bool completed;
    }
    //массив структуры todo
    Todo[] public  todos;
    function create(string calldata _text) public {
        //три способа инициализации структуры
        // вызов как функция
        todos.push(Todo(_text, false));

        //сопоставление ключей
        todos.push(Todo({text: _text, completed: false}));

        //инициализируйте пустую структуру, а затем обновить
        Todo memory todo;
        todo.text = _text;
        // todo.comleted инициализируется в false
        todos.push(todo);
    }
    // солидити автоматически создаст геттер для todos. следовательно следующая функция не нужна
    function get(uint _index) public view returns (string memory text, bool completed){
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }
    //обновление текста
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text;
    }
    //завершаем обновление
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}