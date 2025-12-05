// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * 🍌 MyCrypto_Banana 🍌
 * * Official Token for the Hungry.
 * * Dictionary for Humans:
 * - Token       = Banana
 * - Transfer    = Send Banana to Eat
 * - Approve     = Let Friend Eat
 * - Balance     = Bananas Ready to Eat
 */

contract MyCrypto_Banana {
    
    // --- IDENTITY ---
    string public name = "MyCrypto_Banana";
    string public symbol = "BANANA";
    uint8 public decimals = 18;

    // Total Bananas in existence
    uint256 public totalSupply;

    // --- LEDGERS ---
    // Who has bananas to eat? (Address => Count)
    mapping(address => uint256) public balances;

    // Who is allowed to eat from my stash? (Owner => Spender => Amount)
    mapping(address => mapping(address => uint256)) public allowance;

    // --- EVENTS ---
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // --- CONSTRUCTOR ---
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        
        // You get all the bananas to eat first
        balances[msg.sender] = _initialSupply;
    }

    // --- STANDARD FUNCTIONS ---

    // Check how many bananas they can eat
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    // Send a banana for someone else to eat
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "Cannot send to the void");
        require(balances[msg.sender] >= _value, "You don't have enough bananas to give!");

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Allow a friend (or shop) to eat your bananas later
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != address(0), "Invalid eater address");
        
        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // The friend actually eats (takes) the bananas you approved
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "Invalid address");
        require(balances[_from] >= _value, "They don't have enough bananas");
        require(allowance[_from][msg.sender] >= _value, "You are not allowed to eat that many!");

        balances[_from] -= _value;
        balances[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }
}