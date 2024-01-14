// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {TokenSale} from "../src/TokenSale.sol";

contract TokenSaleTest is Test {
   TokenSale public tokensale;

    function setUp() public {
        tokensale = new TokenSale();
    }

    function testOwner() public{
        address expectedOwner = address(this); 
        address contractOwner = tokensale.owner();
        assertEq(expectedOwner, contractOwner);
    }

    function testPresale() public{
        uint contributionAmount = 5 ether;
        uint beforebalance = tokensale.balanceOf(address(this));
        tokensale.presale{value: contributionAmount}();
        

        uint expectedBalance = beforebalance + 5 ether;
        uint userBalance = tokensale.balanceOf(address(this));

        assertEq(expectedBalance, userBalance);
    }

    function test_endPreSale() public{
        tokensale.endPreSale();

        bool isPublicSale = tokensale.isPublicSale();
        assertTrue(isPublicSale) ;
    }

     function test_pubSale() public{


        uint contributionAmount = 10 ether;
        uint beforebalance = tokensale.balanceOf(address(this));
         tokensale.endPreSale();
        tokensale.pubSale{value: contributionAmount}();

        uint expectedBalance = beforebalance + 10 ether;
        uint userBalance = tokensale.balanceOf(address(this));

        assertEq(expectedBalance, userBalance);
    }


     function testFail_pubSale(uint contributionAmount) public{


        // uint contributionAmount = 10 ether;
        uint beforebalance = tokensale.balanceOf(address(this));
         tokensale.endPreSale();
        tokensale.pubSale{value: contributionAmount}();

        uint expectedBalance = beforebalance + 10 ether;
        uint userBalance = tokensale.balanceOf(address(this));

        assertEq(expectedBalance, userBalance);
    }

    function test_sendToken() public{
        uint beforebal = tokensale.balanceOf(address(0x1));

        tokensale.sendtoken(address(0x1), 10 );

        uint afterbal = tokensale.balanceOf(address(0x1));
        uint expectedbal = beforebal+10;

        assertEq(expectedbal, afterbal);
    }

     function testFuzz_sendToken(address add,uint  amount) public{
        uint beforebal = tokensale.balanceOf(add);

        tokensale.sendtoken(add, amount );

        uint afterbal = tokensale.balanceOf(add);
        uint expectedbal = beforebal+amount;

        assertEq(expectedbal, afterbal);
    }






   
}
