pragma solidity ^0.4.7;

contract StakeOne {

  address public owner;

  struct Member {
    bytes32 name;
    address addr;
  }

  Member[] public members;
  /*mapping (Member => uint) public memberIndex;*/
  /*mapping (address => Member) public memberAddresses;*/

  uint public required;

  enum WithdrawalState {
    noWithdrawal,
    withdrawalProposed,
    withdrawalConfirmed
  }

  WithdrawalState public currentState;

  struct Withdrawal {
    uint id;
    /*address source;*/
    address destination;
    uint amount;
    // in Wei
  }

  Withdrawal[] public withdrawals;

  // Fallback function
  function() payable {
    /*if (msg.value > 0) */
  }

  // Modifiers
  /*modifier isMember() {

  }*/

  modifier onlyState(WithdrawalState expectedState) {
    if (expectedState == currentState) {
      _;
    }
    else {
      throw;
    }
  }

  function StakeOne() {
    owner = msg.sender;
    required++;
    currentState = WithdrawalState.noWithdrawal;
  }

  function registerMember(bytes32 _name, address _addr) {
    // only members should be able to register other members
    Member memory newMember;

    newMember.name = _name;
    newMember.addr = _addr;

    members.push(newMember);
  }


  function getMembers()
    constant
    returns(bytes32[], address[])
  {
    uint length = members.length;

    bytes32[] memory names = new bytes32[](length);
    address[] memory addresses = new address[](length);

    for (uint i = 0; i < length; i++) {
      Member memory currentMember;
      currentMember = members[i];

      names[i] = currentMember.name;
      addresses[i] = currentMember.addr;
    }

    return (names, addresses);
  }

  function changeRequirement(uint _required) {
    // only members can change requirement
  }

  function depositStake()
    payable
    returns(bool)
  {
    if (msg.value > 0) {
      return true;
    }
    else {
      return false;
    }
  }

  function getBalance() constant returns (uint) {
    return this.balance;
  }

  function getCurrentWithdrawal()
    onlyState(WithdrawalState.withdrawalProposed)
    public
    constant
    returns(uint, address, uint)
  {
    var withdrawalID = withdrawals.length - 1;
    return(
      withdrawals[withdrawalID].id,
      /*withdrawals[withdrawalID].source,*/
      withdrawals[withdrawalID].destination,
      withdrawals[withdrawalID].amount
    );
  }

  function makeWithdrawal(address _to, uint _amount)
    onlyState(WithdrawalState.noWithdrawal)
    returns(bool)
  {
    // Check if member
    // Check if withdrawal is bigger than balance
    if (_amount > this.balance) {
      throw;
    }

    Withdrawal memory newWithdrawal;
    newWithdrawal.id = withdrawals.length;
    /*newWithdrawal.source = msg.sender;*/
    newWithdrawal.destination = _to;
    newWithdrawal.amount = _amount;

    withdrawals.push(newWithdrawal);
    currentState = WithdrawalState.withdrawalProposed;

    return true;
  }

  function confirmTransaction()
    onlyState(WithdrawalState.withdrawalProposed)
    returns (bool)
  {
    // Check if member
    // Check if member has already confirmed, if so, don't count
    // Check if required met, if so, change state
  }

  function kill() {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

}
