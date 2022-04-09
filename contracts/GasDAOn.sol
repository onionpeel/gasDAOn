// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";

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

  function vote() {

  }
}
