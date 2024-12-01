// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "lib/forge-std/src/Test.sol";
import "../src/GarageManager.sol";

contract GarageManagerTest is Test {
    GarageManager private garageManager;

    address private user1 = address(0x123);
    address private user2 = address(0x456);

    function setUp() public {
        // Deploy a fresh GarageManager contract before each test
        garageManager = new GarageManager();
    }

    function testAddCarAndRetrieveForTwoUsers() public {
        // Add cars for user1
        vm.startPrank(user1);
        garageManager.addCar("Toyota", "Camry", "Blue", 4);
        garageManager.addCar("Honda", "Civic", "Red", 4);
        vm.stopPrank();

        // Add cars for user2
        vm.startPrank(user2);
        garageManager.addCar("Ford", "Focus", "Black", 4);
        vm.stopPrank();

        // Verify user1's cars
        vm.startPrank(user1);
        GarageManager.Car[] memory user1Cars = garageManager.getMyCars();
        vm.stopPrank();
        assertEq(user1Cars.length, 2, "User1 should have 2 cars");

        // Verify user2's cars
        vm.startPrank(user2);
        GarageManager.Car[] memory user2Cars = garageManager.getMyCars();
        vm.stopPrank();
        assertEq(user2Cars.length, 1, "User2 should have 1 car");
    }

    function testResetGarage() public {
        // Add cars for user1
        vm.startPrank(user1);
        garageManager.addCar("Tesla", "Model S", "White", 4);
        garageManager.addCar("BMW", "X5", "Black", 4);
        vm.stopPrank();

        // Reset user1's garage
        vm.startPrank(user1);
        garageManager.resetMyGarage();
        vm.stopPrank();

        // Verify user1's garage is empty
        vm.startPrank(user1);
        GarageManager.Car[] memory user1Cars = garageManager.getMyCars();
        vm.stopPrank();
        assertEq(user1Cars.length, 0, "User1's garage should be empty");
    }

    function testUpdateCar() public {
        // Add a car for user1
        vm.startPrank(user1);
        garageManager.addCar("Nissan", "Altima", "White", 4);
        vm.stopPrank();

        // Update the car for user1
        vm.startPrank(user1);
        garageManager.updateCar(0, "Nissan", "Sentra", "Silver", 4);
        vm.stopPrank();

        // Verify the car was updated
        vm.startPrank(user1);
        GarageManager.Car[] memory user1Cars = garageManager.getMyCars();
        vm.stopPrank();
        assertEq(user1Cars[0].model, "Sentra", "Car model should be updated to Sentra");
        assertEq(user1Cars[0].color, "Silver", "Car color should be updated to Silver");
    }
}

