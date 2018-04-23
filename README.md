# todolist_dapp

How to use

1. Install truffle, Angular CLI and an Ethereum client as follows using npm: 

npm install -g truffle
npm install -g @angular/cli
npm install -g ethereumjs-testrpc

2. git clone https://github.com/yubi00/todolist_dapp.git
  cd todolist_dapp
  npm install (to install the necessary dependencies)
  
  3. truffle compile ( to compile your contracts)
    truffle migrate( to deploy those contracts to the testrpc network)
    
    Note: make sure, testrpc is running on different terminal before compiling and deploying your contracts 
    
  4. ng serve
  
  5. Finally, Navigate to http://localhost:4200/
