//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./1_SimpleStorage.sol";
//También podríamos heredar la clase de SimpleStorage, tendremos todas las funciones del contrato.
// Sería: contract StorageFactory is SimpleStorage{}
contract StorageFactory{
    
    
    SimpleStorage[] public simpleStorageArray;
    
    function createSimpleStorageContract() public{

        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    
    }

    function sfStore (uint256 _simpleStorageIndex, uint256 _simpleStorageNumber )public{
     /*    Para interactuar con un contrato necesitaremos siempre 2 cosas:
        Address: Dirección en la cual fue desplegado.
        ABI: Traduce nuestras instrucciones a codigo máquina para la EVM. */
       
       
 /*        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber); */
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    
    }

    function sfView(uint256 _simpleStorageIndex) public view returns(uint256){
       /*  SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorage.retrieve(); */
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }

}