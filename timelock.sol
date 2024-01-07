// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
// timeLock - контракт, который публикует транзакцию, которая должна быть исполнена в будущем. После минимального периода ожидания транзакция может быть выполнена
// обычно используется DAO
contract TimeLock{
    error NotOwnerError();
    error AlreadyQueuedError(bytes32 txId);
    error TimestampNotInRangeError(uint blockTimestamp, uint timestamp);
    error NotQueuedError(bytes32 txId);
    error TimestampNotPassedError(uint blockTimestmap, uint timestamp);
    error TimestampExpiredError(uint blockTimestamp, uint expiriesAt);
    error TxFailedError();

    event Queue(
        bytes32 indexed txId,
        address indexed target,
        uint Value,
        string func,
        bytes data,
        uint timestamp
    );
    event Execute(
        bytes32 indexed txId,
        address indexed target,
        uint value,
        string func,
        bytes data,
        uint timestamp
    );
    event Cancel(bytes32 indexed txId);

    uint public constant MIN_DELAY = 10; //sec
    uint public constant MAX_DELAY = 1000; //sec
    uint public constant GRACE_PERIOD = 1000; //sec

    address public owner;
    // txID => queued
    mapping ( bytes32 => bool) public queued;
    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner(){
        if (msg.sender != owner){
            revert NotOwnerError();
        }
        _;
    }
    receive() external payable {}
    function getTxId(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    )public pure returns (bytes32){
        return keccak256(abi.encode(_target, _value, _func, _data, _timestamp));
    }
    /*
    * @param _target Адрес контракта или счета для звонка
    * @param _value Количество ETH для отправки
    * @param _func Сигнатура функции, например "foo(address,uint256)"
    * @param _data отправка данных в кодировке ABI.
    * @param _timestamp Временная метка, после которой транзакция может быть выполнена
    */
    function queue(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) external onlyOwner returns (bytes32 txId){
        txId = getTxId(_target, _value, _func, _data, _timestamp);
        if (queued[txId]){
            revert AlreadyQueuedError(txId);
        }
        // ---|------------|---------------|-------
        //  block    block + min     block + max
        if (
            _timestamp < block.timestamp + MIN_DELAY ||
            _timestamp > block.timestamp + MAX_DELAY
        ){
            revert TimestampNotPassedError(block.timestamp, _timestamp);
        }
        queued[txId] = true;
        emit Queue(txId, _target, _value, _func, _data, _timestamp);
    }
    function execute (
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) external payable onlyOwner returns(bytes memory){
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        if (!queued[txId]) {
            revert NotQueuedError(txId);
        }
        // ----|-------------------|-------
        //  timestamp    timestamp + grace period
        if (block.timestamp < _timestamp){
            revert TimestampNotPassedError(block.timestamp, _timestamp);
        }
        if (block.timestamp > _timestamp + GRACE_PERIOD){
            revert TimestampExpiredError(block.timestamp, _timestamp + GRACE_PERIOD);
        }
        queued[txId] = false;

        //подготовка 
        bytes memory data;
        if(bytes(_func).length > 0){
            //data = func selector + _data
            data = abi.encodePacked(bytes4(keccak256(bytes(_func))), _data);
        } else{
            // резервный вызов с данными
            data = _data;
        }
        // вызов target
        (bool ok, bytes memory res) = _target.call{value: _value}(data);
        if (!ok) {
            revert TxFailedError();
        }
        emit Execute(txId, _target, _value, _func, _data, _timestamp);
        return res;
    }
    function cancel(bytes32 _txId) external onlyOwner {
        if (!queued[_txId]) {
            revert NotQueuedError(_txId);
        }
        queued[_txId] = false;
        emit Cancel(_txId);
    }
}