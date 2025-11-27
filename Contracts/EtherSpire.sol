// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherSpire {
    struct Milestone {
        address user;
        uint256 timestamp;
        string description; // Description of the milestone
        uint256 level;      // Optional: level or score
    }

    // Mapping milestone ID to milestone details
    mapping(uint256 => Milestone) private milestones;
    uint256 private nextMilestoneId = 1;

    // Event emitted when a new milestone is added
    event MilestoneAdded(uint256 indexed milestoneId, address indexed user, uint256 timestamp, string description, uint256 level);

    // Add a milestone
    function addMilestone(string memory description, uint256 level) external {
        milestones[nextMilestoneId] = Milestone({
            user: msg.sender,
            timestamp: block.timestamp,
            description: description,
            level: level
        });

        emit MilestoneAdded(nextMilestoneId, msg.sender, block.timestamp, description, level);
        nextMilestoneId++;
    }

    // View milestone by ID
    function viewMilestone(uint256 milestoneId) external view returns (address user, uint256 timestamp, string memory description, uint256 level) {
        Milestone memory m = milestones[milestoneId];
        require(m.timestamp != 0, "Milestone does not exist");
        return (m.user, m.timestamp, m.description, m.level);
    }

    // Total milestones added
    function totalMilestones() external view returns (uint256) {
        return nextMilestoneId - 1;
    }
}
