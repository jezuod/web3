// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Alumnos {
    // Definimos la estructura para los alumnos
    struct Alumno {
        uint niu; // Número de Identificación Universitaria (NIU)
        string nombre;
        uint anioNacimiento;
        string sexo;
        string primerApellido;
        string segundoApellido;
    }

    // Mapeo para almacenar direcciones autorizadas
    mapping(address => bool) public direccionesAutorizadas;

    // El propietario del contrato
    address public owner;

    // Mapeo para guardar los alumnos usando el NIU como clave
    mapping(uint => Alumno) public alumnos;

    // Constructor para establecer el propietario del contrato
    constructor() {
        owner = msg.sender;
        direccionesAutorizadas[owner] = true;
        agregarAlumno(12, "John", 2000, "Masculino", "Connor", "Contreras");
    }

    // Modificador para verificar si la llamada es una de las direcciones autorizadas
    modifier soloAutorizados() {
        require(direccionesAutorizadas[msg.sender], "Direccion no autorizada");
        _;
    }

    // Función para agregar direcciones autorizadas, solo el propietario puede agregar direcciones
    function agregarDireccionAutorizada(address _direccion) public {
        require(msg.sender == owner, "Solo el propietario puede agregar direcciones autorizadas");
        direccionesAutorizadas[_direccion] = true;
    }
    
    // Función para eliminar direcciones autorizadas ,solo el propietario puede eliminarlas
    function eliminarDireccionAutorizada(address _direccion) public {
        require(msg.sender == owner, "Solo el propietario puede eliminar direcciones autorizadas");
        direccionesAutorizadas[_direccion] = false;
    }

    // Función para agregar un nuevo alumno
    function agregarAlumno(
        uint _niu,
        string memory _nombre, 
        uint _anioNacimiento, 
        string memory _sexo, 
        string memory _primerApellido, 
        string memory _segundoApellido
    ) public {
        // Verificación de que los campos no sean nulos (cadenas vacías) y que el NIU no exista ya
        require(_niu != 0, "El NIU no puede ser nulo");
        require(alumnos[_niu].niu == 0, "Ya existe un alumno con este NIU");
        require(bytes(_nombre).length > 0, "El nombre no puede ser nulo");
        require(_anioNacimiento > 0, "El ano de nacimiento no puede ser nulo");
        require(bytes(_sexo).length > 0, "El sexo no puede ser nulo");
        require(bytes(_primerApellido).length > 0, "El primer apellido no puede ser nulo");

        // Añadir el nuevo alumno al mapping
        alumnos[_niu] = Alumno(
            _niu, 
            _nombre, 
            _anioNacimiento, 
            _sexo, 
            _primerApellido, 
            _segundoApellido
        );
    }
    function checkAlumno(uint _niu) external view returns (bool) {
        require(_niu != 0, "NIU no valido");
        if (alumnos[_niu].niu != 0) {
            return true;
        }
        return(false); 
    }

    // Función para obtener el nombre de un alumno por su NIU
    function obtenerNombre(uint _niu) public view returns (string memory) {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        return alumnos[_niu].nombre;
    }

    // Función para obtener el año de nacimiento de un alumno por su NIU
    function obtenerAnioNacimiento(uint _niu) public view returns (uint) {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        return alumnos[_niu].anioNacimiento;
    }

    // Función para obtener el sexo de un alumno por su NIU
    function obtenerSexo(uint _niu) public view returns (string memory) {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        return alumnos[_niu].sexo;
    }

    // Función para obtener el primer apellido de un alumno por su NIU
    function obtenerPrimerApellido(uint _niu) public view returns (string memory) {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        return alumnos[_niu].primerApellido;
    }

    // Función para obtener el segundo apellido de un alumno por su NIU
    function obtenerSegundoApellido(uint _niu) public view returns (string memory) {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        return alumnos[_niu].segundoApellido;
    }
    // Función para obtener los datos de un alumno por su NIU
    function obtenerAlumno(uint _niu) public view returns (
        uint niu, 
        string memory nombre, 
        uint anioNacimiento, 
        string memory sexo, 
        string memory primerApellido, 
        string memory segundoApellido
    ) {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        Alumno memory alumno = alumnos[_niu];
        return (
            alumno.niu, 
            alumno.nombre, 
            alumno.anioNacimiento, 
            alumno.sexo, 
            alumno.primerApellido, 
            alumno.segundoApellido
        );
    }


    // Función para modificar el nombre de un alumno
    function modificarNombre(uint _niu, string memory _nombre) public soloAutorizados {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        require(bytes(_nombre).length > 0, "El nombre no puede ser nulo");
        alumnos[_niu].nombre = _nombre;
    }

    // Función para modificar el año de nacimiento de un alumno
    function modificarAnioNacimiento(uint _niu, uint _anioNacimiento) public soloAutorizados {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        require(_anioNacimiento > 0, "El anio de nacimiento no puede ser nulo");
        alumnos[_niu].anioNacimiento = _anioNacimiento;
    }

    // Función para modificar el sexo de un alumno
    function modificarSexo(uint _niu, string memory _sexo) public soloAutorizados {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        require(bytes(_sexo).length > 0, "El sexo no puede ser nulo");
        alumnos[_niu].sexo = _sexo;
    }

    // Función para modificar el primer apellido de un alumno
    function modificarPrimerApellido(uint _niu, string memory _primerApellido) public soloAutorizados {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        require(bytes(_primerApellido).length > 0, "El primer apellido no puede ser nulo");
        alumnos[_niu].primerApellido = _primerApellido;
    }

    // Función para modificar el segundo apellido de un alumno
    function modificarSegundoApellido(uint _niu, string memory _segundoApellido) public soloAutorizados {
        require(_niu != 0, "NIU no valido");
        require(alumnos[_niu].niu != 0, "Alumno no encontrado");
        alumnos[_niu].segundoApellido = _segundoApellido;
    }

}
