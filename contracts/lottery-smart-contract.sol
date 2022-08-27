// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Lottery {
    IERC20 public token;
    uint256 public jackPot;

    address public owner;
    address[] public players;

    constructor(address _token, uint256 _jackPot) {
        token = IERC20(_token);
        jackPot = _jackPot;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function lottery() public {
        owner = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encode(block.timestamp, players)));
    }

    function pickWinner() public onlyOwner {
        uint256 index = random() % players.length;
        token.transferFrom(address(this), players[index], jackPot);
        players = new address[](0);
    }
}
