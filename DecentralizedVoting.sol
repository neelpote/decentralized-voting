// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DecentralizedVoting {


    struct Proposal {
         string name;
        uint256 voteCount;
    }

    // An array to store all proposals.
    Proposal[] public proposals;

    // A mapping to track if a voter has already cast their vote.
    mapping(address => bool) public voters;

    // The address of the contract owner.
    address public owner;

    // A modifier to restrict a function to only the contract owner.
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

   
    constructor() {
        owner = msg.sender;
    }

    // Adds a new proposal to the list.
    function addProposal(string memory _proposalName) public onlyOwner {
        proposals.push(Proposal(_proposalName, 0));
    }

    // Allows a user to vote on a proposal.
    function vote(uint256 _proposalIndex) public {
        // Checks if the user has already voted.
        require(!voters[msg.sender]);
        
        // Checks if the proposal exists.
        require(_proposalIndex < proposals.length);
        
        // Marks the user as having voted.
        voters[msg.sender] = true;
        
        // Increments the vote count for the selected proposal.
        proposals[_proposalIndex].voteCount++;
    }

    // Returns the total number of proposals.
    function getProposalsCount() public view returns (uint256) {
        return proposals.length;
    }
}
