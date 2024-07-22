// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    enum PotionType { None, Acceleration, Healing, Intelligence }

    struct Potion {
        string name;
        uint256 cost;
        uint256 quantity;
    }

    mapping(address => uint256) public inventory;
    Potion[] public potions;

    constructor() ERC20("Degen", "DGN") {
        potions.push(Potion("Acceleration Potion", 100, 100));
        potions.push(Potion("Healing Potion", 30, 100));
        potions.push(Potion("Intelligence Potion", 300, 100));
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function getPotionCount() public view returns (uint256) {
        return potions.length;
    }

    function buyPotion(uint256 index) public {
        require(index < potions.length, "Invalid potion index");
        require(balanceOf(msg.sender) >= potions[index].cost, "Not enough tokens to buy potion");
        require(potions[index].quantity > 0, "Potion out of stock");

        inventory[msg.sender] += 1;
        potions[index].quantity -= 1;
        _burn(msg.sender, potions[index].cost);
    }

}
