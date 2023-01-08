const { ethers } = require("hardhat");
const { assert, expect } = require("chai");
const { loadFixture, time } = require("@nomicfoundation/hardhat-network-helpers");

// https://github.com/smartcontractkit/chainlink/blob/dbabde12def11a803d995e482e5fc4287d9cfce4/contracts/test/test-helpers/helpers.ts#L30
const numToBytes32 = (num) => {
    const hexNum = ethers.utils.hexlify(num)
    const strippedNum = stripHexPrefix(hexNum)
    if (strippedNum.length > 32 * 2) {
        throw Error(
            "Cannot convert number to bytes32 format, value is greater than maximum bytes32 value"
        )
    }
    return addHexPrefix(strippedNum.padStart(32 * 2, "0"))
}

// https://github.com/smartcontractkit/chainlink/blob/dbabde12def11a803d995e482e5fc4287d9cfce4/contracts/test/test-helpers/helpers.ts#L93
const stripHexPrefix = (hex) => {
    if (!ethers.utils.isHexString(hex)) {
        throw Error(`Expected valid hex string, got: "${hex}"`)
    }

    return hex.replace("0x", "")
}

// https://github.com/smartcontractkit/chainlink/blob/dbabde12def11a803d995e482e5fc4287d9cfce4/contracts/test/test-helpers/helpers.ts#L21
const addHexPrefix = (hex) => {
    return hex.startsWith("0x") ? hex : `0x${hex}`
}


describe("单元测试：Chainlink AnyAPI", async function() {
    async function deployAnyApiFixture() {
        const linkTokenFactory = await ethers.getContractFactory("LinkToken");
        const linkToken = await linkTokenFactory.deploy()

        const mockOracleFactory = await ethers.getContractFactory("MockOracle");
        const mockOracle = await mockOracleFactory.deploy(linkToken.address);

        const jobId = ethers.utils.toUtf8Bytes("29fa9aa13bf1468788b7cc4a500a45b8");
        const fee = "100000000000000000";

        const anyApiFactory = await ethers.getContractFactory("AnyApiTask");
        const anyApi = await anyApiFactory.deploy(
            mockOracle.address,
            jobId,
            fee,
            linkToken.address
        );
        
        const fundAmount = "1000000000000000000";
        await linkToken.transfer(anyApi.address, fundAmount);

        return { anyApi, mockOracle }
    }

    it("单元测试 3-0： requestVolume, 成功发送 Chainlink 请求", async function() {
        const { anyApi } = await loadFixture(deployAnyApiFixture);
        const transaction = await anyApi.requestVolume();
        const transactionReceipt = await transaction.wait(1);
        const requestId = transactionReceipt.events[0].topics[1];
        expect(requestId).to.not.be.null;
    });

    it("单元测试 3-1： requestVolume, 成功发送 Chainlink 请求，并且收到结果", async function() {
        const { anyApi, mockOracle } = await loadFixture(deployAnyApiFixture);
        const transaction = await anyApi.requestVolume();
        const transactionReceipt = await transaction.wait(1);
        const requestId = transactionReceipt.events[0].topics[1];
        const callbackValue = 777;
        await mockOracle.fulfillOracleRequest(requestId, numToBytes32(callbackValue));
        const volume = await anyApi.volume();
        assert.equal(volume.toString(), callbackValue.toString()); 
    });

});