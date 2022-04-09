// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";

/* @notice Built for the EthGlobal 2022 DAOHacks hackathon
  @notice A participation/voting contract without on-chain enforcement. Data about participation, proposals and votes is emitted as events and can be collated using an indexer.  Any disputes about vote tallies can be resolved by referring to the events since they are immutable.  The rules for using this contract are in the comments as opposed to the normal practice, which puts them in the code.  While this approach leaves the contract exposed to leaks (ex, participants can lie about their greenhouse gas emissions or clients can interpret voting rules differently), it offers a lightweight mechanism for those who want to participate but would otherwise be excluded due to gas costs.
  @authoer: onionpeel
  github: https://github.com/onionpeel/gasDAOn
**/

contract GasDAOn {
  using Counters for Counters.Counter;

  Counters.Counter public proposalId;
  mapping (proposalId => bool) proposals;



  enum GreenhouseGasUsage {
    PlanetaryArsonist,
    Charburger,
    LowSimmer,
    FairShare,
    Undisclosed
  }

  event ParticipantRegistered(
    address indexed participant,
    uint256 indexed greenhouseGasUsage
  );

  event Proposal(
    address indexed proposer,
    string proposal,
    uint256 indexed id,
    uint256 indexed time
  );

  event Vote(
    uint256 indexed proposalId,
    uint256 indexed vote
  );

  function participate(GreenhouseGasUsage _usage) external {
    emit ParticipantRegistered(
      msg.sender,
      uint256(_usage)
    );
  }

  function propose(string memory _proposal) event {
    proposalId.increment();

    emit Proposal(
      msg.sender,
      _proposal,
      proposalId.current(),
      block.timestamp
    );
  }

  function vote(uint256 _proposalId, uint256 _vote) external {
    require(_proposalId == true; "GasDAOn: proposalID does not exist");

    emit Vote(
      _proposalId,
      _vote
    );
  }
}
