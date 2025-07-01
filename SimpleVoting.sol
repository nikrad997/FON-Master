// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.16; 
 
contract SimpleVoting { 
    address public owner; 
    string[] public candidates = ["VUCIC", "STUDENTI", "NIKO"]; 
     
    mapping(uint => uint) public votes; 
    mapping(address => bool) public hasVoted; 
 
    event Voted(address indexed voter, string candidate); 
    event NewCandidateAdded(string name); 
 
    modifier onlyOwner() { 
        require(msg.sender == owner, "Samo vlasnik moze da doda kandidate."); 
        _; 
    } 
 
    constructor() { 
        owner = msg.sender; 
    } 
 
    function vote(uint candidateIndex) external { 
        require(candidateIndex < candidates.length, "Nepostojeci kandidat."); 
        require(!hasVoted[msg.sender], "Vec ste glasali."); 
        votes[candidateIndex]++; 
        hasVoted[msg.sender] = true; 
        emit Voted(msg.sender, candidates[candidateIndex]); 
    } 
 
    function getVotes(uint candidateIndex) public view returns (uint) { 
        require(candidateIndex < candidates.length, "Nepostojeci kandidat."); 
        return votes[candidateIndex]; 
    } 
 
    function getCandidate(uint index) public view returns (string memory) { 
        require(index < candidates.length, "Nepostojeci kandidat."); 
        return candidates[index]; 
    } 
 
    function getCandidateCount() public view returns (uint) { 
        return candidates.length; 
    } 
 
    function addCandidate(string memory name) public onlyOwner { 
        candidates.push(name); 
        emit NewCandidateAdded(name); 
    } 
}