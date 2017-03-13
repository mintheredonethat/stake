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
    noProposal,
    proposed,
    confirmed
  }

  WithdrawalState public currentState;

  struct Withdrawal {
    uint id;
    /*address source;*/
    address destination;
    uint amount;
    // in Wei

    uint numConfirm;
    mapping (address => bool) confirmations;
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

  // Sets owner of contract
  // Sets required number of confirmations for a withdrawal to be executed
  // Sets currentState of withdrawal as noProposal
  function StakeOne() {
    owner = msg.sender;
    /*registerMember(_name, msg.sender);*/
    required = 0;
    currentState = WithdrawalState.noProposal;
  }

  // Registers/adds a member struct to the members array
  // Member struct consists of name & address
  // Sets mapping of address to true, describes if member is member
  // Increments the required confirmations
  function registerMember(bytes32 _name, address _addr) {
    // only members should be able to register other members
    Member memory newMember;

    newMember.name = _name;
    newMember.addr = _addr;

    members.push(newMember);
    isMember[_addr] = true;
    required += 1;
  }

  // Returns an array of: member names array & member addresses array
  // Iterates through all members
  // Stores name of member in names, address of member in addresses
  function getMembers() constant returns(bytes32[], address[]) {
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

  // Allows only members to change the confirmation requirement
  function changeRequirement(uint _required) onlyMember(msg.sender) {
    required = _required;
  }

  // Allows members to send tokens to this contract's balance
  function depositStake() payable onlyMember(msg.sender) returns(bool) {
    if (msg.value > 0) {
      return true;
    }
    else {
      return false;
    }
  }

  // Returns the balance of this contract
  function getBalance() constant returns(uint) {
    return this.balance;
  }

  // Returns an array containing the current withdrawal proposal's
    // id, destination, amount, numConfirm
  // Only members can call this when the withdrawal state is proposed
  function getCurrentWithdrawal()
    onlyState(WithdrawalState.proposed)
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
      /*withdrawals[withdrawalID].confirmations*/
    );
  }

  // Allows members to make a withdrawal proposal if noProposal state
  // Creates a newWithdrawal struct within memory, then
  // Adds newWithdrawal to withdrawals array
  // Changes withdrawal state to proposed
  // returns true upon successful proposition
  // HOW TO UTILISE NORMAL payable TX FORMATION?
  function makeWithdrawal(address _to, uint _amount)
    onlyState(WithdrawalState.noProposal)
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
    /*newWithdrawal.confirmations[msg.sender] = true;
    newWithdrawal.numConfirm = 1;*/

    withdrawals.push(newWithdrawal);
    currentState = WithdrawalState.proposed;

    return true;
  }

  // Allows members to confirm a proposal if withdrawal state is proposed
  // Checks if member has already confirmed; rejects confirmation if true
  // Later, checks if requirement is met; change state to confirmed if true
  function confirmWithdrawal()
    onlyState(WithdrawalState.proposed)
    onlyMember(msg.sender)
    returns (bool)
  {
    var withdrawal = withdrawals[withdrawals.length - 1];

    if (withdrawal.confirmations[msg.sender] == true) {
      throw;
    }
    else {
      withdrawal.confirmations[msg.sender] = true;
      withdrawal.numConfirm += 1;
    }

    if (withdrawal.numConfirm >= required) {
      currentState = WithdrawalState.confirmed;
    }

    return true;
  }

  function executeWithdrawal()
    onlyState(WithdrawalState.confirmed)
    onlyMember(msg.sender)
  {
    var w = withdrawals[withdrawals.length - 1];

    if (!w.destination.call.gas(200000).value(w.amount)()) {
      throw;
    }
    currentState = WithdrawalState.noProposal;
  }

  function kill() {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

}
