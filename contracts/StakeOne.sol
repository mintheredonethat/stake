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
  mapping (address => bool) public isMember;

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
    uint numConfirm;
  }

  Withdrawal[] public withdrawals;

  // Fallback function
  function() payable {
    /*if (msg.value > 0) */
  }

  // Modifiers
  modifier onlyMember(address _addr) {
    if (isMember[_addr]) {
      _;
    }
    else {
      throw;
    }
  }

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
    /*registerMember(_name, msg.sender);*/
    required = 0;
    currentState = WithdrawalState.noWithdrawal;
  }

  function registerMember(bytes32 _name, address _addr) {
    // only members should be able to register other members
    Member memory newMember;

    newMember.name = _name;
    newMember.addr = _addr;

    members.push(newMember);
    isMember[_addr] = true;
    required += 1;
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

  function changeRequirement(uint _required)
    onlyMember(msg.sender)
  {
    // only members can change requirement
  }

  function depositStake()
    payable
    onlyMember(msg.sender)
    returns(bool)
  {
    if (msg.value > 0) {
      return true;
    }
    else {
      return false;
    }
  }

  function getBalance()
    constant
    returns(uint)
  {
    return this.balance;
  }

  function getCurrentWithdrawal()
    onlyState(WithdrawalState.withdrawalProposed)
    onlyMember(msg.sender)
    public
    constant
    returns(uint, address, uint, uint)
  {
    var withdrawalID = withdrawals.length - 1;
    return(
      withdrawals[withdrawalID].id,
      /*withdrawals[withdrawalID].source,*/
      withdrawals[withdrawalID].destination,
      withdrawals[withdrawalID].amount
      withdrawals[withdrawalID].numConfirm
    );
  }

  function makeWithdrawal(address _to, uint _amount)
    onlyState(WithdrawalState.noWithdrawal)
    onlyMember(msg.sender)
    returns(bool)
  {
    if (_amount > this.balance) {
      throw;
    }

    Withdrawal memory newWithdrawal;
    newWithdrawal.id = withdrawals.length;
    /*newWithdrawal.source = msg.sender;*/
    newWithdrawal.destination = _to;
    newWithdrawal.amount = _amount;
    newWithdrawal.numConfirm = 0;

    withdrawals.push(newWithdrawal);
    currentState = WithdrawalState.withdrawalProposed;

    return true;
  }

  function confirmTransaction()
    onlyState(WithdrawalState.withdrawalProposed)
    onlyMember(msg.sender)
    returns (bool)
  {
    // Get current withdrawal
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
