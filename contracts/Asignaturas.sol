// SPDX-License-Identifier: MIT
// Import necessary libraries and interfaces
pragma solidity ^0.8.4;

contract Asignaturas {
    struct Asignatura {
        uint id; // id asignatura
        string nombre; // nombre asignatura
        address[] profesores; // array de profesores
    }
    
    // Mapeo para guardar las asignaturas
    mapping(uint => Asignatura) private asignaturas;

    uint public contadorAsignaturas;

    constructor() {
        contadorAsignaturas = 0;
        agregarAsignatura("Ciencias del Deporte",0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    }

    function agregarAsignatura(string memory _nombre, address _profesor) public returns (uint) {
        contadorAsignaturas++;
        address[] memory profesores = new address[](1); // inicializamos el array con longitud 1
        profesores[0] = _profesor;
        asignaturas[contadorAsignaturas] = Asignatura(contadorAsignaturas, _nombre, profesores);
        return contadorAsignaturas;
        }


    function addProfesor(uint _idAsignatura, address _Profesor) external {
        require(asignaturas[_idAsignatura].id != 0, "Asignatura no encontrada");
        asignaturas[_idAsignatura].profesores.push(_Profesor);
    }

    function deleteProfesor(uint _idAsignatura, address _Profesor) external {
        require(asignaturas[_idAsignatura].id != 0, "Asignatura no encontrada");
        for (uint i = 0; i < asignaturas[_idAsignatura].profesores.length; i++) {
            if (asignaturas[_idAsignatura].profesores[i] == _Profesor) {
                delete asignaturas[_idAsignatura].profesores[i];
                break;
            }
        }
    }

    function obtenerAsignatura(uint _idAsignatura) external view returns (uint, string memory, address[] memory) {
        require(asignaturas[_idAsignatura].id != 0, "Asignatura no encontrada");
        return (asignaturas[_idAsignatura].id, asignaturas[_idAsignatura].nombre, asignaturas[_idAsignatura].profesores);
    }

    function checkAsignatura(uint _idAsignatura) external view returns (bool) {
        if(asignaturas[_idAsignatura].id !=0)
        {
            return true;
        }
        else{
            return false;
        }
        
    }
}
