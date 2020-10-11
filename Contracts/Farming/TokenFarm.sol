// SPDX-License-Identifier: MIT

import "../Utilities/SafeMath.sol";
import "../Utilities/Address.sol";
import "../Tokens/IERC20.sol";
import "../Tokens/SafeERC20.sol";

pragma solidity 0.7.0;

//Class for basic token staking (reusable in the future for LP staking)
contract TokenFarm{
    using SafeMath for uint;
    using SafeERC20 for IERC20;
    using Address for address;
    

    IERC20 public StakingToken;

    mapping(address => uint256) private _stakings;
    uint256 private _totalStaked;

    constructor(address tokenAddress)
    {
        StakingToken = IERC20(tokenAddress);
    }

    function totalStaked() public view returns (uint256) {
        return _totalStaked;
    }

    function stakingOf(address account) public view returns (uint256) {
        return _stakings[account];
    }

    function stake(uint256 amount) public virtual{
        require(!address(msg.sender).isContract(), "Manual farming only!");// dissallow staking from another contract address!
        require(tx.origin == msg.sender, "Manual farming only!");//dissalow staking from another source address than the one calling stake!
        require(amount > 0, "Cannot stake 0");
        _totalStaked = _totalStaked.add(amount);
        _stakings[msg.sender] = _stakings[msg.sender].add(amount);
        StakingToken.safeTransferFrom(msg.sender, address(this), amount);
    }

    function unStake(uint256 amount) public virtual{
        require(amount > 0, "Cannot withdraw 0");
        require(amount <= _stakings[msg.sender], "Cannot withdraw more than is staked!");
        _totalStaked = _totalStaked.sub(amount);
        _stakings[msg.sender] = _stakings[msg.sender].sub(amount);
        StakingToken.safeTransfer(msg.sender, amount);
    }
}