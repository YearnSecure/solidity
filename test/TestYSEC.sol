// SPDX-License-Identifier: MIT
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../Contracts/Tokens/YSEC.sol";

pragma solidity 0.7.0;

contract TestYsec{
    function testInitialBalanceOFYsecUsingDeployedContract() public {   
        YSEC ysec = YSEC(DeployedAddresses.YSEC());

        uint expected = 1000000 * 10**18;

        Assert.equal(ysec.totalSupply(), expected, "Total supply should be 1000000 on init");
    }

    function testInitialBalanceOfYsec() public{
        YSEC ysec = new YSEC();

        uint expected = 1000000 * 10**18;

        Assert.equal(ysec.totalSupply(), expected, "Total supply should be 1000000 on init");       
    }
}