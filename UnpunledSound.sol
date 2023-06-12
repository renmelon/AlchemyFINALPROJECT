// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UnpunkedSound is ERC20, Ownable {
    constructor() ERC20("MELONS", "MLN") {
        _mint(msg.sender, 69000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

contract UnpunkedSoundDAO is Ownable {
    UnpunkedSound public token;
    Proposal[] public proposals;

    struct Proposal {
        string question;
        address proposer;
        uint256 forVotes;
        uint256 againstVotes;
        uint256 timestamp;
        bool executed;
    }

    constructor(UnpunkedSound _token) {
        token = _token;
        _transferOwnership(_token.owner());
    }

    function propose(string memory question) public {
        require(token.balanceOf(msg.sender) > 0, "Only token holders can propose");
        proposals.push(Proposal({
            question: question,
            proposer: msg.sender,
            forVotes: 0,
            againstVotes: 0,
            timestamp: block.timestamp,
            executed: false
        }));
    }

    function vote(uint256 proposalId, bool voteFor) public {
        require(token.balanceOf(msg.sender) > 0, "Only token holders can vote");
        Proposal storage proposal = proposals[proposalId];

        if(voteFor) {
            proposal.forVotes += token.balanceOf(msg.sender);
        } else {
            proposal.againstVotes += token.balanceOf(msg.sender);
        }
    }
}
