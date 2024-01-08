// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.23;
contract AssemblyBinExp{
    // двоичное возведение в степень для вычисления x**n
    function rpow(uint256 x, uint256 n, uint256 b)
    public 
    pure returns (uint256 z){
        assembly{
            switch x
            // x = 0
            case 0{
                switch n
                // n = 0 --> x ** n = 0 ** 0 --> 1
                case 0 {z := b}
                // n > 0 --> x ** n = 0 ** n --> 0
                default { z := 0}
            }
            default {
            switch mod(n, 2)
            //x > 0 и n четное --> z =1
            case 0 {z := b}
            // x > 0 и n нечетное --> z =x
            default {z := x}
            let half := div(b, 2) // округление
            // n = n/2, в то время как n > 0, n=n/2
            for {n := div(n, 2)} n {n := div(n, 2)}{
                let xx := mul(x, x)
                //check overflow откат если xx/x !=x
                if iszero(eq(div(xx, x), x)) {revert(0, 0)}
                //(xx + half)/b
                let xxRound := add(xx, half)
                //check overflow откат если xxRound < xx
                if lt(xxRound, xx){revert (0, 0)}
                x := div(xxRound, b)
                // if n % 2 == 1
                if mod(n, 2){
                    let zx := mul(z, x)
                    //revert if x != 0 и zx/x != z
                    if and(iszero(iszero(x)), iszero(eq(div(zx, x), z))){
                        revert(0, 0)
                    }
                    // (zx + half) / b
                    let zxRound := add(zx, half)
                    if lt(zxRound, zx) {revert(0, 0)}
                    z := div(zxRound, b)
                }
            }
            }
        }
    }
}