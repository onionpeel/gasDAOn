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
  mapping (uint256 => bool) proposals; // proposalId

  uint256 public constant votingPeriod = 604800;

  /* weighting
    1 / (Number of tons to be reduced + 1.4)
    1.4 is added to the reduction because that is the amount by which the lowest emitting 50% of the population can increase their greenhouse gas emissions while still being within their fair share.
    The voting power for undisclosed participants was set arbitrarily.
  **/
  uint256 public planetaryArsonist = 13;
  uint256 public charburger = 45;
  uint256 public lowSimmer = 250;
  uint256 public fairShare = 1000;
  uint256 public undisclosed = 20;

  /*
  To estimate one's annual greenhouse gas emissions, use the data provided in:
  https://www.vox.com/22291568/climate-change-carbon-footprint-greta-thunberg-un-emissions-gap-report
  https://wedocs.unep.org/xmlui/bitstream/handle/20.500.11822/34432/EGR20ch6.pdf?sequence=3
  **/
  enum GreenhouseGasUsage {
    PlanetaryArsonist, // annual income greater than 109,000 USD
    Charburger, // annual income between 38,000 and 109.000 USD
    LowSimmer, // annual income between 6,000 and 38,000 USD
    FairShare, // annual income less than 6,000
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

  /*
    @notice Join gasDAOn as a participant
    @dev To change greenhouse gas usage, call this function with new usage.  Clients will use the latest usage as authoritative.
  **/
  function participate(GreenhouseGasUsage _usage) external {
    emit ParticipantRegistered(
      msg.sender,
      uint256(_usage)
    );
  }

  /**
    @notice Only proposals made by participants are valid
    @dev The proposal should be in the form of a question with numeric options.
    Binary voting:
    "Should this DAO approve the findings of the IPCC Sixth Assessment Report, which was finalized on 4 April 2022?  No: 0, Yes: 1"
    Non-binary voting:
    "How many miles of new train/subway should Los Angeles build by 2030? Zero: 0, Five: 1, Ten: 2, Twenty-five: 3, Fifty: 4"
  */
  function propose(string memory _proposal) external {
    proposalId.increment();
    proposals[proposalId.current()] = true;

    emit Proposal(
      msg.sender,
      _proposal,
      proposalId.current(),
      block.timestamp
    );
  }

  /*
    @notice Participants vote on proposals
    @dev In order for a vote to be counted, an address must first register as a participant.
    @dev The outcome will be determined offchain by tabulating the number of votes for each _vote and then weighting those by multiplying each _vote by the specified weight for each address in terms of their GreenhouseGasUsage.
    Ex, proposalID #3 has 2 votes from the charburger group:
    2 * 45 = 90
    @param _vote Must match one of the options declared in the proposal, otherwise it is thrown out.
    @dev The voting period limit will be enforced offchain.  The block.timestamp for a vote must be a value less than the proposal's block.timestamp + votingPeriod.
  **/
  function vote(uint256 _proposalId, uint256 _vote) external {
    require(proposals[_proposalId] == true, "GasDAOn: proposalID does not exist");

    emit Vote(
      _proposalId,
      _vote
    );
  }
}
