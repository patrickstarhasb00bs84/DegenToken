// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    enum Character {Pikachu, Bulbasaur, Charmander}

    uint256 constant private POKEMON_COST = 200; 

    uint256 constant private PIKACHU_CHANCE = 700; 
    uint256 constant private BULBASAUR_CHANCE = 300;   
    uint256 constant private CHARMANDER_CHANCE = 25;   
    mapping(Character => uint256) public inventory;
    constructor() ERC20("Degen", "DGN") {}

    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function pokemon() public payable {
        require(balanceOf(msg.sender) >= POKEMON_COST, "Insufficient balance for pokemon");

        _burn(msg.sender, POKEMON_COST);

        // Using `block.prevrandao` instead of the deprecated `block.difficulty`
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % 1000;

        Character result;

        if (randomNumber < PIKACHU_CHANCE) {
            result = Character.Pikachu;
        } else if (randomNumber < PIKACHU_CHANCE + BULBASAUR_CHANCE) {
            result = Character.Bulbasaur;
        } else if (randomNumber < PIKACHU_CHANCE + BULBASAUR_CHANCE + CHARMANDER_CHANCE) {
            result = Character.Charmander;
        } else {
            revert("Invalid random number generated");
        }
        inventory[result]++;
    }

    function getInventory() public view returns (uint256, uint256, uint256) {
        return (inventory[Character.Pikachu], inventory[Character.Bulbasaur], inventory[Character.Charmander]);
    }
}
