// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Mytoken is ERC20, Ownable {
    constructor() ERC20("Theodore", "THD") Ownable(msg.sender) {}

    // Function to mint tokens as rewards (restricted to the contract owner)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to allow users to burn tokens when redeeming points
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    // Explicitly overriding the transfer function
    function transfer(address to, uint256 amount) public override returns (bool) {
        require(to != address(0), "Transfer to the zero address is not allowed");
        require(amount > 0, "Transfer amount must be greater than zero");

        // Call the parent contract's transfer function
        return super.transfer(to, amount);
    }
}
