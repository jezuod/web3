// SPDX-License-Identifier: MIT
// Import necessary libraries and interfaces
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./DatosToken.sol";
contract certificadoToken is ERC721URIStorage, Datos {
    constructor(address initialOwner) Datos(initialOwner) ERC721("UCAM Certificate", "UC") {}

    function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner {
        //require(estudiantes[_estudiante].id != address(0), "Estudiante no encontrado"); --> usar gestion de alumnos
        //require(verificadores[_verificador].id != address(0), "Verificador no encontrado"); --> crear contrato con verificadores
        
        // Crea el token ERC721
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, _uri);
        
    }
    //hacer que no sea transferible
    function _beforeTokenTransfer(
        address from, 
        address to, 
        uint256 tokenId,
        uint256 batchSize
    ) internal virtual {
        require(from == address(0), "Error: transferencia del token esta blockeada");   
        _beforeTokenTransfer(from, to, tokenId, batchSize);
    }
}

