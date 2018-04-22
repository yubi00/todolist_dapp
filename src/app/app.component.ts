import {Component} from '@angular/core';
import {canBeNumber} from '../util/validation';
const Web3 = require('web3');
const contract = require('truffle-contract');
const TodoListArtifacts = require('../../build/contracts/TodoList.json');

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

  TodoList = contract(TodoListArtifacts);
    account: any;
    accounts: any;
    web3: any;
    status: string; 
    
  items = ["Angularjs", "Reactjs", "Vuejs"];

  newItem = "";

  constructor() {
    this.checkAndInstantiateWeb3();
    this.onReady();
    this.getItems();
  }

  checkAndInstantiateWeb3() {
    // Checking if Web3 has been injected by the browser (Mist/MetaMask)
    if (typeof this.web3 !== 'undefined') {
      console.warn('Using web3 detected from external source. If you find that your accounts don\'t appear or you have ' +
        '0 TodoList, ensure you\'ve configured that source properly. If using MetaMask, see the following link. Feel ' +
        'free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask');
      // Use Mist/MetaMask's provider
      this.web3 = new Web3(this.web3.currentProvider);
    } else {
      console.warn('No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when ' +
        'you deploy live, as it\'s inherently insecure. Consider switching to Metamask for development. More info ' +
        'here: http://truffleframework.com/tutorials/truffle-and-metamask');
      // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
      this.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
      alert("ethereum client connected to localhost");
    }
  }

  onReady() {
    // Bootstrap the TodoList abstraction for Use.
    this.TodoList.setProvider(this.web3.currentProvider);

    // Get the initial account balance so it can be displayed.
    this.web3.eth.getAccounts((err, accs) => {
      if (err != null) {
        alert('There was an error fetching your accounts.');
        return;
      }

      if (accs.length === 0) {
        alert('Couldn\'t get any accounts! Make sure your Ethereum client is configured correctly.');
        return;
      }
      this.accounts = accs;
      this.account = this.accounts[0];
      console.log(this.account);
    });
  }

  getItems = function() {
  
    this.TodoList.deployed().then(function(contractinstance){
      contractinstance.getTotalItems.call().then(function(res){
        var itemcount = parseInt(res);
        alert("item count: "+itemcount);
        for(var i=0; i<itemcount; i++){
          contractinstance.getItem.call(i).then(function(error, result){ 
            if(!error) {
              console.log("item name: "+result);
              console.log("\n");
            }
            else {
              console.log(error);
            }
          })
        }
      })
    })
  }

  addItem = function() {
    if(this.newItem != "") {
      var newitem = new String(this.newItem);
      this.items.push(newitem);
      this.TodoList.deployed().then(function(contractinstance){
        contractinstance.addItem(newitem).then(function(err, res){
          if(!err) {
            
            alert("new item added successfully");
            
          }
          else {
            console.log(err);
          }
        })
      })
      
    }
    this.newItem = "";

  }

  deleteItem = function(index) {
    this.items.splice(index, 1);
  }
}