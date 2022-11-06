// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;
import "./ItemManager.sol";
contract Item{
    uint public amount;
    uint public paidAmount;
    uint public index;
    ItemManager itemManger;
    constructor(ItemManager _itemManger,uint _index,uint _amount){
        amount= _amount;
        index= _index;
        itemManger=_itemManger;

    }
    receive() external payable{
        require(msg.value==amount,"Not valid amount");
        require(paidAmount==0,"You have paid already for this");
        paidAmount += msg.value;
        (bool success,)=address(itemManger).call{value:amount}("");
        require(success,"Transaction failed");
    }
    fallback() external payable{
        
    }

}