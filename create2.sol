// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// адрес контракта может быть предварительно вычислен до развертывания с помощью create
contract Factory {
    // возвращает адрес только что развернутого контракта 
    function deploy(
        address _owner,
        uint _foo,
        bytes32 _salt
    ) public payable returns (address) {
        //данный синтаксис является более новым способом вызова create буз ассемблера, нужно просто передать salt
        //https://docs.soliditylang.org/en/latest/control-structures.html#salted-contract-creations-create2
        return address(new TestContract{salt: _salt}(_owner, _foo));
    }
}
//а это старый способ через ассемблер 
contract FactoryAssembly {
    event Deployed( address addr, uint salt);
    //1 получение байт кода контракта для развертывания
    // примечание _owner, _foo являются аргументами конструктора TestConstructor
    function getBytecode(address _owner, uint _foo) public pure returns (bytes memory){
        bytes memory bytecode = type(TestContract).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
    }
    //2 вычисление адреса контракта для развертывания
    // _salt это случайное число, используемое для создания адреса 
    function getAddress(
        bytes memory bytecode,
        uint _salt
    ) public view returns (address){
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );
        // приведем последние 20байт хеша к адресу
        return address(uint160(uint(hash)));
    }
    //3 развертываем контракт 
    // проверим журнал событий Deployed, который содержит адресс развернутого testcontract
    // этот адрес из журнала должен совпадать с адрессом вычесленным сверху
    function deploy(bytes memory bytecode, uint _salt) public payable {
        address addr;
        /* вызываем create2
        create2(v,p,n,s)
        создаст новый контракт для кода в памяти p to p + n
        и отправка V wei и возвращаем новый адрес
        где новый адресс = первые 20 байт keccak256(0xff + address(this) + s + keccak256(mem[p...(p+n)))
        s = 256битное значение с обратным порядком байтов
        */
        assembly {
            addr := create2(
                callvalue(),//wei отправлен с текущим call, фактически кода запускается после пропуска первых 32 байт
                add(bytecode, 0x20), mload(bytecode), // загрузка размера кода содержащегося в первых 32 байтах
                _salt // salt из аргументов функции
            )
            if iszero(extcodesize(addr)){
                revert(0, 0)
            }
        }
        emit Deployed(addr, _salt);
    } 
}
contract TestContract {
    address public owner;
    uint public foo;
    constructor(address _owner, uint _foo) payable {
        owner = _owner;
        foo = _foo;
    }
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}