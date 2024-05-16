// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Paul {
    uint256 public myNumber;

    function setNumber(uint256 _num) external {
        
        if (_num == 0) {
            revert("Number cannot be zero");
        }
        
        require(myNumber + _num > myNumber, "Overflow detected");

        if (_num > 100) {
            revert("Number is too large");
        }

        myNumber = _num;
    }
}
