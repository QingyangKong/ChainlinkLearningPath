const { ethers } = require("hardhat");
const { assert, expect } = require("chai");
const { loadFixture, time } = require("@nomicfoundation/hardhat-network-helpers");

describe("单元测试：Chainlink Automation", async function() {
    async function deployAutomationFixture() {
        const automationContract = await ethers.getContractFactory("AutomationTask");
        const interval = "120";
        const automation = await automationContract.deploy(interval);
        return { automation };
    }

    it("单元测试 2-0： 状态未发生变化时，checkUpkeep 返回 false", async function() {
        const { automation } = await loadFixture(deployAutomationFixture);
        const checkData = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(""));
        const { upkeepNeeded } = await automation.callStatic.checkUpkeep(checkData);
        assert.equal(upkeepNeeded, false);
    });

    it("单元测试 2-1：满足 checkUpkeep 状态时，成功执行 performUpkeep ", async function() {
        const { automation } = await loadFixture(deployAutomationFixture);
        const checkData = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(""));
        
        const interval = await automation.interval();
        await time.increase(interval.toNumber() + 1);
        await automation.fight(1);

        let { updateNeeded, performData } = await automation.callStatic.checkUpkeep(checkData);
        if (performData == undefined) {
            performData = checkData
        }
        await automation.performUpkeep(performData);
        const health = await automation.healthPoint(1);
        assert(health == 1000, "the health is not refreshed to 1000");

    });

});