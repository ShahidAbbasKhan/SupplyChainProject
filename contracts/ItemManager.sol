// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;
import "./Ownable.sol";
import "./Items.sol";
contract ItemManager is Ownable{
     
    uint itemIndex;
    address owner;
    constructor() {
        owner=msg.sender;
    }
    
    enum supplyStatus {
     Created, Paid , Delivered
    }
    struct supply_Item {
        Item item; // from Item Contract
        string itemIdentity;
        uint itemPrice;
        supplyStatus statusIs;
    }
    mapping (uint => supply_Item) public items;
    
    event itemStatusStep(uint _itemNumber, uint _step,address _address);

    function createItem(string memory _itemIdentifier,uint _itemPrice) public onlyOwner{
        Item  _item=new Item (this,_itemPrice,itemIndex); //updating
        items[itemIndex].item=_item;
        items[itemIndex].itemIdentity= _itemIdentifier;
        items[itemIndex].itemPrice= _itemPrice;
        items[itemIndex].statusIs= supplyStatus.Created;
        emit  itemStatusStep (itemIndex,uint(items[itemIndex].statusIs),address(_item));
        itemIndex++;
    }
    function triggerPayment(uint _itemIndex) public payable {
        Item item=items[_itemIndex].item;
        require(msg.sender==address(item),"Only item can update it");
        require(item.amount()==msg.value,"Pay Full amount");
        require(items[_itemIndex].itemPrice >= msg.value,"pay Full payment");
        require( items[_itemIndex].statusIs==supplyStatus.Created,"item should be created");
        items[_itemIndex].statusIs= supplyStatus.Paid;
        emit  itemStatusStep (_itemIndex,uint(items[_itemIndex].statusIs),address(item));

    }
    function triggerdelivery(uint _itemIndex) public onlyOwner {
        Item item=items[_itemIndex].item;
        require( items[_itemIndex].statusIs==supplyStatus.Paid,"item payment should be paid first");
        items[_itemIndex].statusIs= supplyStatus.Delivered;
        emit  itemStatusStep (_itemIndex,uint(items[_itemIndex].statusIs),address(item));
    }



}