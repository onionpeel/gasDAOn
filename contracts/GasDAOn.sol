// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract GasDAOn {
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
    uint256 indexed proposalTime
  );

  function participate(GreenhouseGasUsage _usage) external {
    emit ParticipantRegistered(
      msg.sender,
      uint256(_usage)
    );
  }

  function propose(string memory _proposal) event {

  }
}
