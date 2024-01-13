// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenSale is ERC20 {
   
   address public owner;
   uint public pre_maxcap;
   uint public pre_mincontri;
   uint public pre_maxcontri;
   uint public pre_totalcap;

   uint public pub_maxcap;
   uint public pub_mincontri;
   uint public pub_maxcontri;
   uint public pub_totalcap;

   bool public isPublicSale;

   mapping(address => uint ) balance;
   

   constructor() ERC20("ALPHA", "ALP"){
        pre_maxcap = 50;
        pre_mincontri =1;
        pre_maxcontri = 10;
        pub_maxcap = 100;
        pub_mincontri = 2;
        pub_maxcontri = 20;

        owner = msg.sender;
    }

   

    function presale() public payable {
        require(!isPublicSale, "Pre sale ended");
        require(balance[msg.sender] + (msg.value/1 ether) <=pre_maxcontri && (msg.value/1 ether)>=pre_mincontri, "You can only contribute between 1 to 10 ethers");
        require(msg.value/1 ether+pre_totalcap<=pre_maxcap, "Max limit reach");

        _mint(msg.sender, msg.value);
        balance[msg.sender] +=msg.value/1 ether;
        pre_totalcap+=msg.value/1 ether;
      
    }

    function endPreSale() public {
        require(msg.sender == owner, "only owner can stop the presale");
        isPublicSale = true;
    }

    function pubSale() public payable{
        require(isPublicSale, "Public Sale has not started yet");
        require(balance[msg.sender] + (msg.value/1 ether )<= pub_maxcontri && (msg.value/1 ether)>=pub_mincontri, "Value must be between 2 to 20");
        require((msg.value/1 ether)+pub_totalcap<= pub_maxcap, "Max limit reached");

        _mint(msg.sender, msg.value);
        balance[msg.sender] +=msg.value/1 ether;
        pub_totalcap+=msg.value/1 ether;
    }

    function sendtoken(address _to, uint _amount) public {
        require(msg.sender==owner, "only owner can send token to address");
        _mint(_to, _amount);
    }

    function refund(uint _amount) public {
        if(isPublicSale){
            require(pub_totalcap < pub_maxcap, "You can not get a refund as max cap is reached");
            require(balance[msg.sender]>  0 , "You do not have balance");
            require( _amount <= balance[msg.sender], "You do less balance than amount");

            balance[msg.sender] -=_amount;
            _burn(msg.sender, _amount*10**18);

            uint amount = _amount*10**18;
            (bool success, ) = msg.sender.call{value: amount}("");
            require(success, "Transaction failed");

        }else{

            require(pre_totalcap < pre_maxcap, "You can not get a refund as max cap is reached");
            require(balance[msg.sender]>  0 , "You do not have balance");
            require( _amount <= balance[msg.sender], "You do less balance than amount");

            balance[msg.sender] -=_amount;
            _burn(msg.sender, _amount*10**18);

           uint amount = _amount*10**18;
            (bool success, ) = owner.call{value: amount}("");
            require(success, "Transaction failed");
            
        }
    }


}

