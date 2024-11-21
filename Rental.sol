// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./verifier.sol";

contract Rent {
    Verifier private verifier;

    uint256 constant private BicycleCost = 6000000000000;
    uint256 constant private CarCost = 60000000000000;

    mapping (address => uint) bicycleRents;
    mapping (address => uint) carRents;

    uint256 private numBicycles = 10;
    uint256 private numCars = 10;

    // Dirección del contrato verificador (debes especificarlo al desplegar)
    constructor(address _verifier) {
        verifier = Verifier(_verifier);
    }

    function BicycleRent() external payable {
        require(numBicycles > 0, "Not enough bicycles");
        require(msg.value >= BicycleCost, "Not enough Gwei for the bicycle: 6 000");

        numBicycles--;
        bicycleRents[msg.sender]++;
    }

    function CarRent(
        Verifier.Proof memory proof,   // Prueba zk-SNARK
        uint[2] memory input   // Input
    ) external payable {
        require(numCars > 0, "Not enough cars");
        require(input[1] == 1 && input[0] >= 18, "You must be at least 18 years old");
        // Llama al verificador zk-SNARK
        require(verifier.verifyTx(proof, input), "Not a correct proof");
        require(msg.value >= CarCost, "Not enough Gwei for the car: 60 000");

        numCars--;
        carRents[msg.sender]++;
    }

    function ReturnBicycle() public {
        require(bicycleRents[msg.sender] > 0, "You didn't rent any bicycle");

        bicycleRents[msg.sender]--;
        numBicycles++;
    }

    function ReturnCar() public {
        require(carRents[msg.sender] > 0, "You didn't rent any car");

        carRents[msg.sender]--;
        numCars++;
    }
}
