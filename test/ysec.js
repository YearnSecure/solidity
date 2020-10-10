const YSEC = artifacts.require("YSEC");

contract('YSEC', (accounts) =>{
    it('Initial should be 1000000 ', async () =>{
        const YSECInstance = await YSEC.deployed();
        const totalSupply = await YSECInstance.totalSupply();
        const balance = await YSECInstance.balanceOf.call(accounts[0]);
        assert.equal(balance.valueOf(), 1000000 * Math.pow(10, 18), "1000000 wasn't in the first account");
        assert.equal(totalSupply.valueOf(), 1000000 * Math.pow(10, 18), "Total supply is not 1000000");
    });  
    it('Succesfull transfer ', async () =>{
        const YSECInstance = await YSEC.deployed();        
        await YSECInstance.transfer(accounts[1], 1000);
        const balance = await YSECInstance.balanceOf.call(accounts[0]);
        const balance2 = await YSECInstance.balanceOf.call(accounts[1]);
        assert.equal(balance.valueOf(), 1000000 * Math.pow(10, 18) - 1000, "999000 wasn't in the first account");
        assert.equal(balance2.valueOf(), 1000, "Account 2 does not have expected balance of 1000");
    });
    it('Successfull burn', async () =>{
        const YSECInstance = await YSEC.deployed();
        const balance = await YSECInstance.balanceOf.call(accounts[0]);
        const totalSupply = await YSECInstance.totalSupply();
        assert.equal(balance.valueOf(), 1000000 * Math.pow(10, 18), "1000000 wasn't in the first account");
        assert.equal(totalSupply.valueOf(), 1000000 * Math.pow(10, 18), "Total supply is not 1000000");
        await YSECInstance.burn(1000);
        const balanceAfterBurn = await YSECInstance.balanceOf.call(accounts[0]);
        const totalSupplyAfterBurn = await YSECInstance.totalSupply();
        assert.equal(balanceAfterBurn.valueOf(), 1000000 * Math.pow(10, 18) - 1000, "999000 wasn't in the first account after burn");
        assert.equal(totalSupplyAfterBurn.valueOf(), 1000000 * Math.pow(10, 18) - 1000, "Total supply is not 999000");
    });    
    it('Failed burn, no governance', async () =>{
        try{
            const YSECInstance = await YSEC.deployed();      
            const balance = await YSECInstance.balanceOf.call(accounts[0]);
            const totalSupply = await YSECInstance.totalSupply();
            assert.equal(balance.valueOf(), 1000000 * Math.pow(10, 18), "1000000 wasn't in the first account");
            assert.equal(totalSupply.valueOf(), 1000000 * Math.pow(10, 18), "Total supply is not 1000000");
            await YSECInstance.burn(1000, { from: accounts[1] });        
        }
        catch(err){
            assert.include(err.message, "Caller does not have governance", "The error message should contain 'Caller does not have governance'");
        }        
    });
    it('Successfull burn of governance', async () =>{
        try{
            const YSECInstance = await YSEC.deployed();      
            const balance = await YSECInstance.balanceOf.call(accounts[0]);
            const totalSupply = await YSECInstance.totalSupply();
            assert.equal(balance.valueOf(), 1000000 * Math.pow(10, 18), "1000000 wasn't in the first account");
            assert.equal(totalSupply.valueOf(), 1000000 * Math.pow(10, 18), "Total supply is not 1000000");
            await YSECInstance.burn(1000);
            const balanceAfterBurn = await YSECInstance.balanceOf.call(accounts[0]);
            const totalSupplyAfterBurn = await YSECInstance.totalSupply();
            assert.equal(balanceAfterBurn.valueOf(), 1000000 * Math.pow(10, 18) - 1000, "999000 wasn't in the first account after burn");
            assert.equal(totalSupplyAfterBurn.valueOf(), 1000000 * Math.pow(10, 18) - 1000, "Total supply is not 999000");     
            await YSECInstance.burnGovernance();
            await YSECInstance.burn(1000);
        }
        catch(err){
            assert.include(err.message, "Caller does not have governance", "The error message should contain 'Caller does not have governance'");
        }        
    });

});