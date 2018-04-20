pragma solidity ^0.4.21;

contract TodoList {
    
    event addeditems(string message);
    event deleteditems(string message);
    event status(string message);
    
    struct Item {
        bytes32 itemname;
        uint itemindex;
    }
    
    mapping(uint => Item) items;
    uint[] indexes; //indexes array store the index of the mapping 
    
     address public admin;

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _; 
    }
    
    function changeAdmin(address newAdmin)
    onlyAdmin
    {
        require(newAdmin != 0x0);
        admin = newAdmin;
    }
    
    function TodoList() {
        admin = msg.sender; 
    }
    
    function addItem(bytes32 itemname) returns (bool success){
        if(findItem(itemname) == false) {
            items[indexes.length].itemname = itemname;
            items[indexes.length].itemindex = indexes.length;

            emit addeditems("new item added"); 
            indexes.push(indexes.length); 
        }
        emit status("item already exist");
        return false;
    }
    
    function deleteItem(uint index) returns (bool success) {
        if(findItembyIndex(index) == true) {
            Item storage lastiteminthelist = items[indexes.length - 1];
            lastiteminthelist.itemindex = index; 
            items[index] = lastiteminthelist;
            indexes.length--; 
            
            emit deleteditems("selected item deleted successfully");
            return true; 
        }
        emit status("item could not deleted");
        return false;
    }
    
    function findItembyIndex(uint index) returns (bool) {
        for(uint i=0; i<indexes.length; i++) {
            if(items[i].itemindex == index) {
                emit status("item found");
                return true; 
            }
        }
        emit status("item not found");
        return false; 
    }
    
    function findItem(bytes32 name) returns (bool) {
        for (uint i=0; i<indexes.length; i++) {
            if(items[i].itemname == name) {
                emit status("item found");
                return true; 
            }
        }
        emit status("item not found");
        return false; 
    }
    
    function getItem(uint index)  returns (bytes32 itemname) {
        if(findItembyIndex(index) == true) {
            return items[index].itemname; 
        }
        emit status("item not in the list");
    }
    
    function getTotalItems() returns (uint) {
        return indexes.length;
        
    }
    
}
