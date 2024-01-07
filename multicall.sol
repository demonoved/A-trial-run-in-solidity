// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract MultiCall{
    function multiCall(
        address[] calldata targets,
        bytes[] calldata data
    )external view returns (bytes[] memory){
        require(targets.length == data.length, "target length != data length");
        bytes[] memory results = new bytes[](data.length);
        for (uint i; i < targets.length; i++){
            (bool success, bytes memory result) = targets[i].staticcall(data[i]);
            require(success, "call failed");
            results[i] = result;
        }
        return results;
    }
}