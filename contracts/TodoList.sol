// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <=0.7.0;

contract TodoList {
    
    event addedItems(string message);
    event deletedItems(string message);
    event status(string message);

    //struct Item holds an information about a particular todos
    struct Item {
        bytes32 itemname;
        uint itemindex;
    }
    
    //items mapping stores the information about a particualr item list on the basis of its index
    mapping(uint => Item) items;
    uint[] indexes; //indexes array store the index of the mapping 
    
     address public admin;

    /*
	 *This is a special type of func called modifier which is used to restrict the execution of certain transaction, where the admin only have the rights to do so
	 *
	 */
    modifier onlyAdmin() {
        require(msg.sender == admin);
        _; 
    }
    
    /*
	 *only admin can change the ownership of the contract
	 * @param {address} newAdmin
	 * address of the admin 
	 *
	 */
   
    
    constructor() {
        admin = msg.sender; 
    }
    /*
	 *This function is used to add todo item list to the blockchain
	 *@return {bool} success
	 * true if succeed otherwise false
	 */
    function addItem(bytes32 itemname) public returns (bool success){
        if(findItem(itemname) == false) {
            items[indexes.length].itemname = itemname;
            items[indexes.length].itemindex = (indexes.length);
             emit addedItems("new item added");
            indexes.push(indexes.length); 
        }
         emit status("item already exist"); 
        return false;
    }
    
    /*
	 *This function is used to delete todo item list from the blockchain
	 *@return {bool} success
	 * true if succeed otherwise false
	 */
    function deleteItem(uint index) public returns (bool success) {
        if ( findItembyIndex(index) == true ) {
            delete items[index];
             emit deletedItems("selected item deleted successfully");
            return true; 
        }
         emit status("item could not deleted");
        return false;
    }
    /*
	 *This function checks if item already exist by its index
	 * @param {uint} index
	 * index of the item  in uint
	 *@return {bool}
	 *a boolean value
	 */
    function findItembyIndex(uint index) public  returns (bool) {
        for(uint i=0; i<indexes.length; i++) {
            if(items[i].itemindex == index) {
                emit  status("item found");
                return true; 
            }
        }
         emit status("item not found");
        return false; 
    }
    /*
	 *This function checks if item already exist by its name
	 * @param {bytes32} name
	 * name of the item  in uint
	 *@return {bool}
	 *a boolean value
	 */
    function findItem(bytes32 name) public returns (bool) {
        for (uint i=0; i<indexes.length; i++) {
            if(items[i].itemname == name) {
                emit  status("item found");
                return true; 
            }
        }
         emit status("item not found");
        return false; 
    }
    /*
	 *This function retrieves the name of the todo list , provided the index of a item and is converted to string
	 *@param {uint} index
	 *index of the item
	 *@return {string} itemname
	 * name of the item
	 */
    function getItem(uint index)  public returns (string memory itemname) {
        if(findItembyIndex(index) == true) {
            return bytes32ToString(items[index].itemname); 
        }
         emit status("item not in the list");
    }
    
    /*
	 *This function returns a number of todos added to the blockchain
	 *@return {uint256} length
	 *the number of items added to the blockchain
	 */
    function getTotalItems() public view returns (uint) {
        return indexes.length;
        
    }

    /*
	 *This is a helper function which is used to convert the given bytes32 to string which is later required when we want to retrieve the output as a string 
	 *@param {bytes32} x
	 * any bytes32 character
	 *@return {string}
	 */
	function bytes32ToString(bytes32 x) public pure returns(string memory) {
		bytes memory bytesString = new bytes(32);
		uint charCount = 0;
		for (uint j = 0; j < 32; j++) {
			byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
			if (char != 0) {
				bytesString[charCount] = char;
				charCount++;
			}
		}
		bytes memory bytesStringTrimmed = new bytes(charCount);
		for (uint j = 0; j < charCount; j++) {
			bytesStringTrimmed[j] = bytesString[j];
		}
		return string(bytesStringTrimmed);
	}

    /*
	 *This is a helper function which converts string to bytes32
	 *@param {string memory} source
	 *string data type 
	 *@return {bytes32} result
	 *result in bytes32
	 */
	
	/*
	 *  This is a fallback function, which rejects any ether sent to it.It is good Ballotpractise to include such a function for every contract
	 * in order not to loose Ether.  
	 *@return {}
	 */

	/*
	 *  This is a fallback function, which rejects any ether sent to it.It is good practise to include such a function for every contract
	 * in order not to loose Ether.  
	 *@return {}
	 */
    
}
