// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import './Campaign.sol';

contract CrowdFund {

    // Store all campaigns
    Campaign[] private campaigns;

    // New campaign has launched
    event CampaignLaunched(
        address contractAddress,
        address campaignCreator,
        string campaignTitle,
        string campaignDesc,
        uint deadline,
        uint goalAmount
    );

    // Function to create new campaign
    // duration parameter in number of days
    function createCampaign(
        string calldata title,
        string calldata description,
        uint duration,
        uint amount
    ) external {
        uint deadline = block.timestamp + (duration * 1 days);
        Campaign newCampaign = new Campaign(
            payable(msg.sender),
            amount,
            deadline,
            title,
            description
        );
        campaigns.push(newCampaign);
        emit CampaignLaunched(
            address(newCampaign),
            msg.sender,
            title,
            description,
            deadline,
            amount
        );
    }

    // Return all the projects
    function getCampaigns() external view returns(Campaign[] memory){
        return campaigns;
    }
}