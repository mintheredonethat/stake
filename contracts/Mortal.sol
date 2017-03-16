pragma solidity ^0.4.7;

contract Mortal {

  address public owner;

  function Mortal() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    if (msg.sender == owner) {
      _;
    }
    else {
      throw;
    }
  }

  function kill() onlyOwner() {
    // sends ether balance of contract back to owner address
    selfdestruct(owner);
  }

}
