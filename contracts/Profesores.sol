// SPDX-License-Identifier: MIT
// Import necessary libraries and interfaces
pragma solidity ^0.8.4;

contract Profesores {
    struct Profesor {
        address direccion_cartera; // su direccion
        string nombre;
        uint anioNacimiento;
        string sexo;
        string primerApellido;
        string segundoApellido;
    }

    // El propietario del contrato
    address public owner;

    // Mapeo para guardar los profesores usando su direccion como clave
    mapping(address => Profesor) public profesores;

    // Constructor para establecer el propietario del contrato
    constructor() {
        owner = msg.sender;
    }

    // Modificador para verificar si la llamada es del propietario
    modifier soloOwner() {
        require(msg.sender == owner, "Solo el propietario puede realizar esta accion");
        _;
    }

    // Función para crear un nuevo profesor
    function crearProfesor(
        address _direccion_cartera,
        string memory _nombre, 
        uint _anioNacimiento, 
        string memory _sexo, 
        string memory _primerApellido, 
        string memory _segundoApellido
    ) public soloOwner {
        require(_direccion_cartera != address(0), "Direccion no valida");
        require(profesores[_direccion_cartera].direccion_cartera == address(0), "El profesor ya existe");
        require(bytes(_nombre).length > 0, "El nombre no puede ser nulo");
        require(_anioNacimiento > 0, "El ano de nacimiento no puede ser nulo");
        require(bytes(_sexo).length > 0, "El sexo no puede ser nulo");
        require(bytes(_primerApellido).length > 0, "El primer apellido no puede ser nulo");

        profesores[_direccion_cartera] = Profesor(
            _direccion_cartera,
            _nombre,
            _anioNacimiento,
            _sexo,
            _primerApellido,
            _segundoApellido
        );
    }

    // Función para editar los datos de un profesor
    function editarProfesor(
        address _direccion_cartera,
        string memory _nombre, 
        uint _anioNacimiento, 
        string memory _sexo, 
        string memory _primerApellido, 
        string memory _segundoApellido
    ) public soloOwner {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        require(bytes(_nombre).length > 0, "El nombre no puede ser nulo");
        require(_anioNacimiento > 0, "El ano de nacimiento no puede ser nulo");
        require(bytes(_sexo).length > 0, "El sexo no puede ser nulo");
        require(bytes(_primerApellido).length > 0, "El primer apellido no puede ser nulo");

        profesores[_direccion_cartera] = Profesor(
            _direccion_cartera,
            _nombre,
            _anioNacimiento,
            _sexo,
            _primerApellido,
            _segundoApellido
        );
    }

    // Función para eliminar un profesor
    function eliminarProfesor(address _direccion_cartera) public soloOwner {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        delete profesores[_direccion_cartera];
    }

    // Función para obtener todos los datos de un profesor
    function obtenerProfesor(address _direccion_cartera) public view returns (
        address direccion_cartera, 
        string memory nombre, 
        uint anioNacimiento, 
        string memory sexo, 
        string memory primerApellido, 
        string memory segundoApellido
    ) {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        Profesor memory profesor = profesores[_direccion_cartera];
        return (
            profesor.direccion_cartera,
            profesor.nombre,
            profesor.anioNacimiento,
            profesor.sexo,
            profesor.primerApellido,
            profesor.segundoApellido
        );
    }

    // Funciones para obtener atributos individuales del profesor
    function obtenerNombre(address _direccion_cartera) public view returns (string memory) {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        return profesores[_direccion_cartera].nombre;
    }

    function obtenerAnioNacimiento(address _direccion_cartera) public view returns (uint) {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        return profesores[_direccion_cartera].anioNacimiento;
    }

    function obtenerSexo(address _direccion_cartera) public view returns (string memory) {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        return profesores[_direccion_cartera].sexo;
    }

    function obtenerPrimerApellido(address _direccion_cartera) public view returns (string memory) {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        return profesores[_direccion_cartera].primerApellido;
    }

    function obtenerSegundoApellido(address _direccion_cartera) public view returns (string memory) {
        require(profesores[_direccion_cartera].direccion_cartera != address(0), "Profesor no encontrado");
        return profesores[_direccion_cartera].segundoApellido;
    }
}