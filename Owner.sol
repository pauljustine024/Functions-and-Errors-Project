// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Paul {
    uint256 public myNumber;
    address public owner;

    event NumberSet(uint256 newNumber);
    event NumberIncremented(uint256 incrementedBy, uint256 newNumber);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    modifier validNumber(uint256 _num) {
        require(_num != 0, "Number cannot be zero");
        require(_num <= 100, "Number is too large");
        _;
    }

    function setNumber(uint256 _num) external onlyOwner validNumber(_num) {
        require(myNumber + _num > myNumber, "Overflow detected");

        myNumber = _num;
        emit NumberSet(_num);
    }

    function incrementNumber(uint256 _num) external onlyOwner validNumber(_num) {
        require(myNumber + _num > myNumber, "Overflow detected");

        myNumber += _num;
        emit NumberIncremented(_num, myNumber);
    }
}
