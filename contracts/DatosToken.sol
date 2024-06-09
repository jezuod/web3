// SPDX-License-Identifier: MIT
// Import necessary libraries and interfaces
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Datos is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}
}