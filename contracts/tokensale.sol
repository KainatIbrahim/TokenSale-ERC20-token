// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "./ERC20token4.sol";

contract Tokensale{
    address owner;
    ERC20token4 public erc20;
    uint256 constant firstphasefee = 0.005 ether;
    uint256 constant secondphasefee = 0.01 ether;
    uint256 constant thirdphasefee = 0.1 ether;
    uint256 public startTime;

    constructor(address _token){
        owner = msg.sender;
        startTime = block.timestamp;
        erc20 = ERC20token4(_token);
    }

    modifier onlyOwner{
        require(msg.sender == owner, "You are not the owner!! ");
        _;
    }

    function buyTokens() payable public {

        //First phase
        if(block.timestamp <= startTime + 30 days){
            require(msg.value >=firstphasefee, "Minimum one token!! ");
            uint256 calculateToken = msg.value/firstphasefee;
            erc20.mint(msg.sender, calculateToken);

        }else if(block.timestamp <= startTime + 60 days){ //second phase
            require(msg.value >= secondphasefee, "Minimum one token!!");
            uint256 calculateToken = msg.value/secondphasefee;
            erc20.mint(msg.sender, calculateToken);

        }else{                      // third phase
            require(msg.value >= thirdphasefee, "minimum 1 token!!");
            uint256 calculateToken = msg.value/thirdphasefee;
            erc20.mint(msg.sender, calculateToken);
        }
    
    }

}
