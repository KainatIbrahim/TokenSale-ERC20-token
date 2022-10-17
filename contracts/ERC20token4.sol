/**
 *Submitted for verification at Etherscan.io on 2022-09-30
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;


contract ERC20token4{

////////////// State variables ////////////

    string public token4Name; 
    string public token4Symbol; 
    uint256 public token4TotalSupply;
    uint256 public tokenSupply;
    uint256 public  token4decimals; 
    address internal owner;

//////////////Events///////////////////
event Approval(address from,address to, uint tokens);
event Transfer(address from, address to, uint tokens);

////////////// Mappings ////////////////

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allownce;

    constructor(){
        token4Name = "Token4";
        token4Symbol = "TK4";
        token4decimals = 18;
        tokenSupply = 200;
        token4TotalSupply =tokenSupply*(10**uint256(token4decimals));
        balances[msg.sender] += token4TotalSupply;
        owner = msg.sender;
    }

////////////// Modifier ////////////////

     modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this method");
        _;
    }

////////////// Readable Functions //////////////// 

    function totalsupply() public view returns(uint256){
        return token4TotalSupply;
    }
    function balanceOf(address tokenOwner)  public view returns(uint256) { 
        return balances[tokenOwner];
        }

////////////// Main Functions ////////////////

    function mint(address to, uint _tokens) public onlyOwner returns(bool) {
        token4TotalSupply += _tokens;
        balances[to] += _tokens;
        return true;
    }
    function transfer(address to, uint token)  public  returns(bool){
        require(balances[msg.sender] >= token, "you should have some tokens");
        balances[msg.sender] -= token;
        balances[to] += token;
        emit Transfer(msg.sender,to,token);
        return true;
    }
    function approve(address spender, uint tokens)  public returns(bool success) {
        require(balances[msg.sender]>= tokens,"YOU HAVE NO SUFFICIENT TOKEN");
        allownce[msg.sender][spender] += tokens;
        emit Approval(msg.sender, spender,tokens);
        return true;

    }
    function allowance(address _owner, address spender)  public view returns(uint){
        return allownce[_owner][spender];
    }
    function burn(uint _tokens) public onlyOwner returns(bool) {
     token4TotalSupply -= _tokens;
     balances[msg.sender] -= _tokens;
     return true;
    }
}