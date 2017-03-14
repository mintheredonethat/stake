pragma solidity ^0.4.7;

contract NameReg {

  struct Member {
    address addr;
    bytes32 name;
    uint index;
  }

  uint public required;
  address public owner;

  Member[] public members;

  function NameReg(uint _required) {
    required = _required;
    owner = msg.sender;
  }

  /*function isMember(uint index) public constant returns (bool correct) {
    if (members.length == 0) return false;

    return (members[index] != 0);
  }

  function addMember(address _addr, bytes32 _name)  {
    Member memory newMember;

    newMember.addr = _addr;
    newMember.name = _name;
    newMember.index = members.length;

    members.push(newMember);
  }

  function removeMember(uint index) {
  }*/

}
