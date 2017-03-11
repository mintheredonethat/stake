pragma solidity ^0.4.7;

contract MultiSig {

  // Constructor signs owner of wallet
  // Owners can register other owners
  // An owner can deposit stake
  // An owner can withdraw stake
    // Initiates withdrawal process
      // required number of Owners to allow for withdrawal/TX from wallet
      // submitTx - can be initiated by any owner
      // confirmTx () - run upon submission by submitter
        // Updates state of TX to confirmable
        // Other owners must confirmTx
      // executeTx
        // only when num required met

  address public owner;

  // For Registry
  address[] public memberIndex;
  mapping (address => Member) public members;

  // For Transactions
  uint public required;
  uint public transactionCount;
  mapping (uint => Transaction) public transactions;
  mapping (uint => mapping (address => bool)) public confirmations;

  /*address[] public owners;*/
  /*mapping (address => bool) public isOwner;*/

  struct Member {
    bytes32 name;
    uint index;
  }

  struct Transaction {
    address destination;
    uint value;
    bool executed;
  }

  function MultiSig(uint _required) public {
    owner = msg.sender;
    required = _required;
  }

/////////////////////////////////// Registry ///////////////////////////////////

  function isMember(address addr) public constant returns (bool correct) {
    if (memberIndex.length == 0) return false;

    return (memberIndex[members[addr].index] == addr);
  }

  function addMember(address _addr, bytes32 _name) public returns (uint index) {
    // Add only new member, not existing
    if (isMember(_addr)) throw;

    // Register new member to members mapping & push to memberIndex array
    members[_addr].name = _name;
    members[_addr].index = memberIndex.push(_addr) - 1;
    required++;

    // Index of new member in memberIndex
    return memberIndex.length - 1;
  }

  function removeMember(address addr) public returns (uint index) {
    // If member isn't registered
    if (!isMember(addr)) throw;

    // Grab index to remove & address that will fill its spot
    uint indexToRemove = members[addr].index;
    address replacingAddress = memberIndex[memberIndex.length - 1];

    memberIndex[indexToRemove] = replacingAddress;
    members[replacingAddress].index = indexToRemove;
    memberIndex.length--;
    required--;

    return indexToRemove;
  }

  function getMember(address addr) public constant returns (bytes32 name, uint index) {
    if (!isMember(addr)) throw;

    return(
      members[addr].name,
      members[addr].index
    );
  }

  function getMemberCount() public constant returns (uint count) {
    return memberIndex.length;
  }

/////////////////////////////////// MultiSig ///////////////////////////////////

  function submitTransaction(address destination, uint value) public returns (uint transactionId) {
    transactionId = transactionCount;
  }

}
