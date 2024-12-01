pragma solidity ^0.8.17;

import "../src/GarageManager.sol";

contract GarageManagerScript {
    function deploy() public returns (GarageManager) {
        GarageManager garageManager = new GarageManager();
        return garageManager;
    }
}
