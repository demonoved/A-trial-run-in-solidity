// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract Loop {
    function loop() public {
        // цикл for
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                //переход к следующей интерации через continue
                continue;
            }
            if (i == 5) {
                //выход из цикла через break
                break;
            }
        }
        //цикл while
        uint j;
        while (j < 10) {
            j++ ;
        }
    }
    
}