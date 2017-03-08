pragma solidity ^0.4.7;

contract NameRegistry {
  mapping (bytes32 => address) public addresses;
  mapping (address => bytes32) public names;

  event AddressRegistered(address indexed account);
  event AddressRemoved(address indexed account);

  // Fallback function
  function() payable {
    if (msg.value > 0) {

    }
  }

  // Constructor registers EOA caller
  // bytes32 param takes input as string, not hex
  function NameRegistry(bytes32 name) public {
    addresses[name] = msg.sender;
    names[msg.sender] = name;
  }

  function register(bytes32 name) {
    if (addresses[name] == 0 && name != "") {
      addresses[name] = msg.sender;
      names[msg.sender] = name;
    }
    AddressRegistered(msg.sender);
  }

  function remove(bytes32 name) {
    if (addresses[name] != 0 && name != "") {
      addresses[name] = 0x0;
    }
    AddressRemoved(msg.sender);
  }

  function addressOf(bytes32 name) constant returns(address addr) {
    return addresses[name];
  }

  function nameOf(address addr) constant returns(bytes32 name) {
    return names[addr];
  }

}
