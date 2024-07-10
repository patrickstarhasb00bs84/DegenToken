// SPDX-License-Identifier: MIT

/*
Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
Transferring tokens: Players should be able to transfer their tokens to others.
Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
Checking token balance: Players should be able to check their token balance at any time.
Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/


pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    address public redeemWallet;
    mapping(string => uint256) public itemPrices;
    string[] public storeItems;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        redeemWallet = msg.sender;

        storeItems = ["Official Degen NFT", "Official Degen T-Shirt", "Official Degen Tumbler"];
        itemPrices["Official Degen NFT"] = 50;
        itemPrices["Official Degen T-Shirt"] = 75;
        itemPrices["Official Degen Tumbler"] = 80;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount); // last value is for decimals
    }


    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        burn(_value);
    }

    function showStoreItems() external view returns (string[] memory) {
        string[] memory itemsList = new string[](storeItems.length);

        for (uint256 i = 0; i < storeItems.length; i++) {
                string memory itemName = storeItems[i];
                itemsList[i] = itemName; 
        }
        return itemsList;
    }

    function showItemPrices() external view returns (uint256[] memory) {
        uint256[] memory prices = new uint256[](storeItems.length);

        for (uint256 i = 0; i < storeItems.length; i++) {
            string memory itemName = storeItems[i];
            prices[i] = itemPrices[itemName];
        }
        return prices;
    }

    function setRedeemWallet(address _wallet) external onlyOwner {
        redeemWallet = _wallet; // seperate wallet = Simplifies Audits
    }

    event TokenRedeemed(address indexed redeemer, uint8 choice, uint256 price, string item);

    function redeemTokens(uint8 _itemIndex) external payable returns (bool) {
        require(_itemIndex >= 1 && _itemIndex <= 3, "Invalid choice. Choose between 1 and 3.");

        string memory itemName = storeItems[_itemIndex - 1];
        uint256 itemPrice = itemPrices[itemName];

        require(this.balanceOf(msg.sender) >= itemPrice, "Insufficient Degen Tokens");
        approve(msg.sender, itemPrice);
        transferFrom(msg.sender, redeemWallet, itemPrice);

        emit TokenRedeemed(msg.sender, _itemIndex, itemPrice, itemName);

        return true;
    }
}
