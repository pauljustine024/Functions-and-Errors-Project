// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract AdvancedToken {
    string public constant name = "AdvancedToken";
    string public constant symbol = "ATK";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public admins;
    bool public paused = false;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event AdminAdded(address indexed admin);
    event AdminRemoved(address indexed admin);
    event Paused();
    event Unpaused();

    constructor(uint256 _initialSupply) {
        owner = msg.sender;
        admins[owner] = true;
        _mint(owner, _initialSupply);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "Not an admin");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    function _mint(address _to, uint256 _value) internal {
        require(_to != address(0), "Mint to zero address");
        totalSupply += _value;
        balanceOf[_to] += _value;
        emit Mint(_to, _value);
        emit Transfer(address(0), _to, _value);
    }

    function mint(address _to, uint256 _value) external onlyAdmin whenNotPaused {
        _mint(_to, _value);
    }

    function burn(uint256 _value) external whenNotPaused {
        require(balanceOf[msg.sender] >= _value, "Burn amount exceeds balance");
        totalSupply -= _value;
        balanceOf[msg.sender] -= _value;
        emit Burn(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }

    function transfer(address _to, uint256 _value) external whenNotPaused returns (bool) {
        require(_to != address(0), "Transfer to zero address");
        require(balanceOf[msg.sender] >= _value, "Transfer amount exceeds balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) external whenNotPaused returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external whenNotPaused returns (bool) {
        require(_from != address(0), "Transfer from zero address");
        require(_to != address(0), "Transfer to zero address");
        require(balanceOf[_from] >= _value, "Transfer amount exceeds balance");
        require(allowance[_from][msg.sender] >= _value, "Transfer amount exceeds allowance");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function addAdmin(address _admin) external onlyOwner {
        admins[_admin] = true;
        emit AdminAdded(_admin);
    }

    function removeAdmin(address _admin) external onlyOwner {
        admins[_admin] = false;
        emit AdminRemoved(_admin);
    }

    function pause() external onlyOwner {
        paused = true;
        emit Paused();
    }

    function unpause() external onlyOwner {
        paused = false;
        emit Unpaused();
    }
}
