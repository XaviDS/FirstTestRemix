//SPDX-License-Identifier: MIT

pragma solidity >0.6.0 <0.9.0;


contract SimpleStorage{
    //Primera "Lección". ------------------------------------------2:27:30
    uint256 public fNumber;
    /* uint256 fNumber=7;
    int256 fnegNum=-7;
    bool fbool=true;
    string fString= "Hello World";
    address fAddress=0x72b1043d9F782AD3698105B71F6E0dc2e8DFaCf7;
    bytes32 fByte="Hello";
     */
/* 
     States de diferentes Functions:
     external: La función debe ser usada por otro contrato externo.
     public: Libre Acceso.
     internal: La función sólo puede ser usada dentro de este contrato.
     private: La función y variables no pueden ser vistas por otros contratos. */

    struct People{
        uint256 fNumber;
        string name;
    }

    //El mapping() relaciona 2 tipos de datos/variables diferentes.
    mapping(string => uint256) public name_favNumberMap;
   
    People[] public people;
 People public Person = People({fNumber:7, name:"Xavi"});

    function store(uint256 _fNumber) public{
        fNumber= _fNumber;
        

    }

    //view: Obtener un valor almacenado en la blockchain.
    function retrieve() public view returns(uint256){
        return fNumber;
    }

    //pure: Hacer calculos
    function pureFunction(uint256 _number) public pure{
        _number + _number;

    }
    /* String: Tipo de caracter especial en solidity. (Realmente es un tipo byte que combina un array de caracteres: Hola= H O L A)
    Dos tipos.
    Memory: Variable local y durante la función.
    Storage: Variable que se guarda a largo plazo. */
    function addPerson(string memory _name, uint256 _fNumber)public{
        people.push(People(_fNumber,_name));
         name_favNumberMap[_name]= _fNumber;
    }

    
}