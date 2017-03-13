// Unused

pragma solidity ^0.4.7;

contract NameRegistry {

  uint public accountCount;
  address owner;
  mapping (bytes32 => address) public addresses;
  mapping (address => bytes32) public names;

  event AddressRegistered(address indexed account);
  event AddressRemoved(address indexed account);

  // Fallback function
  /*function() payable {
    if (msg.value > 0) {

    }
  }*/

  /*function getAddresses() constant returns (bytes32[]) {
    for (uint i = 0; i < accountCount; i++) {

    }
  }*/


  // Constructor sets EOA owner of contract, registers owner
  // bytes32 param takes input as string, not hex
  function NameRegistry(bytes32 name) {
    owner = msg.sender;
    addresses[name] = msg.sender;
    names[msg.sender] = name;
    accountCount += 1;
  }

  function register(bytes32 name, address addr) {
    if (addresses[name] == 0 && name != "") {
      addresses[name] = addr;
      names[msg.sender] = name;
      accountCount += 1;
    }
    AddressRegistered(msg.sender);
  }

  function remove(bytes32 name) {
    if (addresses[name] != 0 && name != "") {
      var temp = addresses[name];
      names[temp] = "";
      addresses[name] = 0x0;
      accountCount -= 1;
    }
    AddressRemoved(msg.sender);
  }

  function addressOf(bytes32 name) constant returns(address addr) {
    return addresses[name];
  }

  function nameOf(address addr) constant returns(bytes32 name) {
    return names[addr];
  }

  function kill() {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

///////////////////////////////////////////////////////////////// Linked List DS
  // https://forum.ethereum.org/discussion/1995/iterating-mapping-types


////////////////////////////////////////////////////////// Structs into an array
  /*
  Person[] public registry;

  struct Person {
    bytes32 email;
    address addr;
  }


  function NameRegistry(bytes32 _email) {
    owner = msg.sender;

    register(_email, msg.sender);
  }

  function register(bytes32 _email, address _addr) {
    Person memory newPerson;
    newPerson.email = _email;
    newPerson.addr = msg.sender;

    registry.push(newPerson);
  }*/


///////////////////////////////////////////////////////// Rob Hitchens' Approach
  /*struct User {
    bytes32 email;
    uint index;
  }

  address owner;
  mapping (address => User) private users;
  address[] private userIndex;

  function NameRegistry() {
    owner = msg.sender;
  }

  // Make this a modifier?
  function isUser(address addr)
    public constant returns (bool yes)
  {
    if (userIndex.length == 0) return false;

    return (userIndex[users[addr].index] == addr);
  }

  function addUser(address _addr, bytes32 _email)
    public returns (uint index)
  {
    if (isUser(_addr)) throw;

    users[_addr].email = _email;
    users[_addr].index = userIndex.push(_addr) - 1;

    return userIndex.length - 1;
  }

  function getUser(address addr)
    public constant returns (bytes32 email, uint index)
  {
    if (!isUser(addr)) throw;

    return(
      users[addr].email,
      users[addr].index
    );
  }

  function getUserCount()
    public constant returns (uint count)
  {
    return userIndex.length;
  }

  function getUserAtIndex(uint index)
    public constant returns (address addr)
  {
    return userIndex[index];
  }*/

  /*for (var i = 0; i < userIndex.length; i++) {
      var userAddr = getUserAtIndex(i); // returns address
      getUser(userAddr); // returns array of email & index of user
    }*/

  /*function getAllUsers() */
    /*public */

}
