// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract PaulExtreme {
    uint256 public myNumber;
    address public owner;
    uint256 public cap;
    mapping(address => bool) public admins;

    event NumberSet(uint256 newNumber);
    event NumberIncremented(uint256 incrementedBy, uint256 newNumber);
    event NumberDecremented(uint256 decrementedBy, uint256 newNumber);
    event NumberReset();
    event CapSet(uint256 newCap);
    event AdminAdded(address admin);
    event AdminRemoved(address admin);

    constructor(uint256 _initialCap) {
        owner = msg.sender;
        cap = _initialCap;
        admins[owner] = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "Caller is not an admin");
        _;
    }

    modifier validNumber(uint256 _num) {
        require(_num != 0, "Number cannot be zero");
        require(_num <= 100, "Number is too large");
        _;
    }

    modifier underCap(uint256 _num) {
        require(myNumber + _num <= cap, "Exceeds cap");
        _;
    }

    function setNumber(uint256 _num) external onlyAdmin validNumber(_num) underCap(_num) {
        myNumber = _num;
        emit NumberSet(_num);
    }

    function incrementNumber(uint256 _num) external onlyAdmin validNumber(_num) underCap(_num) {
        myNumber += _num;
        emit NumberIncremented(_num, myNumber);
    }

    function decrementNumber(uint256 _num) external onlyAdmin validNumber(_num) {
        require(myNumber >= _num, "Underflow detected");
        myNumber -= _num;
        emit NumberDecremented(_num, myNumber);
    }

    function resetNumber() external onlyAdmin {
        myNumber = 0;
        emit NumberReset();
    }

    function setCap(uint256 _newCap) external onlyOwner {
        require(_newCap >= myNumber, "New cap is too low");
        cap = _newCap;
        emit CapSet(_newCap);
    }

    function addAdmin(address _admin) external onlyOwner {
        admins[_admin] = true;
        emit AdminAdded(_admin);
    }

    function removeAdmin(address _admin) external onlyOwner {
        admins[_admin] = false;
        emit AdminRemoved(_admin);
    }
}
