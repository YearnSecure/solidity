/*
__/\\\________/\\\_____/\\\\\\\\\\\____/\\\\\\\\\\\\\\\________/\\\\\\\\\_        
 _\///\\\____/\\\/____/\\\/////////\\\_\/\\\///////////______/\\\////////__       
  ___\///\\\/\\\/_____\//\\\______\///__\/\\\_______________/\\\/___________      
   _____\///\\\/________\////\\\_________\/\\\\\\\\\\\______/\\\_____________     
    _______\/\\\____________\////\\\______\/\\\///////______\/\\\_____________    
     _______\/\\\_______________\////\\\___\/\\\_____________\//\\\____________   
      _______\/\\\________/\\\______\//\\\__\/\\\______________\///\\\__________  
       _______\/\\\_______\///\\\\\\\\\\\/___\/\\\\\\\\\\\\\\\____\////\\\\\\\\\_ 
        _______\///__________\///////////_____\///////////////________\/////////__

Let's farm some YSEC!
Visit and follow!

* Website:  https://www.ysec.finance
* Twitter:  https://twitter.com/YearnSecure
* Telegram: https://t.me/YearnSecure
* Medium:   https://medium.com/@yearnsecure

*/

// SPDX-License-Identifier: MIT

import "./TokenFarm.sol";

pragma solidity 0.7.0;

contract YSECToYSECFarm is TokenFarm{   
    using SafeMath for uint;
    using SafeERC20 for IERC20;  

    IERC20 public RewardToken;
    
    constructor(address tokenAddress) TokenFarm(tokenAddress){
        RewardToken = IERC20(tokenAddress);
    }

    function stake(uint256 amount) public override updateRewards(msg.sender){
        super.stake(amount);
    }

    function unStake(uint256 amount) public override updateRewards(msg.sender){
        super.unStake(amount);
    }

    function claimable(address account) public view returns (uint256){
        //returns current claimable (current rewards of user + extra accumalated)
    }

    modifier updateRewards(address account){
        //update rewards of user
        _;
    }

    function claim() external updateRewards(msg.sender){
        uint256 reward = claimable(msg.sender);
        if(reward > 0)
        {
            //update rewards to 0
            RewardToken.safeTransfer(msg.sender, reward);
            //logging?
        }
    }
}