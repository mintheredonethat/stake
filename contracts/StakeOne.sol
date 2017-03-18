pragma solidity ^0.4.7;
import "./Mortal.sol";

contract StakeOne is Mortal {

  // Confirmations required for functions
  uint public required;

  // Member
  mapping (address => bool) public isMember;

  Member[] public members;

  struct Member {
    bytes32 name;
    address addr;
  }

  // WithdrawalState finite state machine
  WithdrawalState public currentState;

  enum WithdrawalState {
    noProposal,
    proposed,
    confirmed
  }

  // Withdrawal
  Withdrawal[] public withdrawals;

  struct Withdrawal {
    uint id;
    address destination;
    uint amount; // in Wei
    uint numConfirm;
    mapping (address => bool) confirmations;
  }

  // Events for EVM Logging Purposes (UI, testing)
  event Registered(bytes32 indexed name, address indexed addr);
  event RequirementChanged(uint indexed required);
  event Deposited(address indexed sender, uint indexed value);
  event Proposed(uint indexed id);
  event Confirmed(address indexed confirmer);
  event StateChanged(bytes32 indexed state);
  event Executed(address indexed recipient, uint indexed value);

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

  modifier memberOrOwner(address _addr) {
    if (_addr == owner) {
      _;
    }
    else if (isMember[_addr]) {
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
    required = 0;

    currentState = WithdrawalState.noProposal;
    StateChanged("no proposal");
  }

  // Registers/adds a member struct to the members array
  // Member struct consists of name & address
  // Sets mapping of address to true, describes if member is member
  // Increments the required confirmations
  function registerMember(bytes32 _name, address _addr)
  memberOrOwner(msg.sender) {
    // only members should be able to register other members
    Member memory newMember;

    newMember.name = _name;
    newMember.addr = _addr;

    members.push(newMember);
    isMember[_addr] = true;
    required += 1;

    Registered(_name, _addr);
    RequirementChanged(required);
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
    RequirementChanged(_required);
  }

  // Allows members to send tokens to this contract's balance
  function depositStake() payable onlyMember(msg.sender) {
    if (msg.value > 0) {
      Deposited(msg.sender, msg.value);
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
    constant
    returns(uint, address, uint, uint)
  {
    var withdrawalID = withdrawals.length - 1;
    return(
      withdrawals[withdrawalID].id,
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
  function proposeWithdrawal(address _to, uint _amount)
    onlyState(WithdrawalState.noProposal)
    onlyMember(msg.sender)
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

    Proposed(newWithdrawal.id);
    StateChanged("proposed");
  }

  // Allows members to confirm a proposal if withdrawal state is proposed
  // Checks if member has already confirmed; rejects confirmation if true
  // Later, checks if requirement is met; change state to confirmed if true
  function confirmWithdrawal()
    onlyState(WithdrawalState.proposed)
    onlyMember(msg.sender)
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
      StateChanged("confirmed");
    }

    Confirmed(msg.sender);
  }

  // Allows members to execute the withdrawal if
  // WithdrawalState.confirmed (received required number of confirmations)
  // Changes state to noProposal
  function executeWithdrawal()
    onlyState(WithdrawalState.confirmed)
    onlyMember(msg.sender)
  {
    var w = withdrawals[withdrawals.length - 1];

    // Is this safe? DAO Hack
    if (!w.destination.send(w.amount)) {
      throw;
    }
    currentState = WithdrawalState.noProposal;

    Executed(w.destination, w.amount);
    StateChanged("No proposal");
  }

}
