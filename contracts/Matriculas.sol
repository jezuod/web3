// SPDX-License-Identifier: MIT
// Import necessary libraries and interfaces
pragma solidity ^0.8.4;

import "./Alumnos.sol";
import "./Asignaturas.sol";

contract Matriculas {
    Alumnos private alumnosContrato;
    Asignaturas private asignaturasContrato;
    address private owner;
    uint public COSTO_ASIGNATURA = 1 ether;

    constructor(address _alumnosContrato, address _asignaturasContrato) {
        alumnosContrato = Alumnos(_alumnosContrato);
        asignaturasContrato = Asignaturas(_asignaturasContrato);
        owner = msg.sender;
    }

    struct Matricula {
        uint niu;
        uint[] id_asignaturas;
    }

    mapping(uint => Matricula) public matriculas;

    event AlumnoMatriculado(uint indexed niu, uint[] id_asignaturas);

    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el propietario puede realizar esta accion");
        _;
    }

    function matricularAlumno(uint _niu, uint[] memory _idAsignaturas) external payable returns (bool) {
        require(alumnosContrato.checkAlumno(_niu), "Alumno no encontrado");
        uint cantidadAsignaturas = _idAsignaturas.length;
        require(msg.value >= cantidadAsignaturas * COSTO_ASIGNATURA, "Fondos insuficientes");

        for (uint i = 0; i < cantidadAsignaturas; i++) {
            require(asignaturasContrato.checkAsignatura(_idAsignaturas[i]), "Asignatura no encontrada");
        }

        Matricula storage matricula = matriculas[_niu];
        matricula.niu = _niu;
        for (uint i = 0; i < cantidadAsignaturas; i++) {
            matricula.id_asignaturas.push(_idAsignaturas[i]);
        }

        emit AlumnoMatriculado(_niu, _idAsignaturas);

        // Reembolso de exceso de pago
        uint exceso = msg.value - (cantidadAsignaturas * COSTO_ASIGNATURA);
        if (exceso > 0) {
            payable(msg.sender).transfer(exceso);
        }

        return true;
    }

    function retirarFondos() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function obtenerAsignaturasMatriculadas(uint _niu) external view returns (uint[] memory) {
        return matriculas[_niu].id_asignaturas;
    }

    function cambiarPrecioAsignaturas(uint _precio) external onlyOwner returns (uint)  {
        COSTO_ASIGNATURA=_precio;
        return COSTO_ASIGNATURA;
    } 
}

