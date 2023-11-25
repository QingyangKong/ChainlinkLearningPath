const { loadFixture } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");

describe("单元测试：Chainlink VRF", async ()=> {

    async function deployVRFConsumerFixture() {
        const [deployer] = await ethers.getSigners();

        const BASE_FEE = "100000000000000000";
        const GAS_PRICE_LINK = "1000000000";
        
        
        const VRFCoordinatorContract = await ethers.getContractFactory("VRFCoordinatorV2Mock");
        const VRFCoordinator = await VRFCoordinatorContract
            .deploy(
                BASE_FEE,
                GAS_PRICE_LINK
            );
        await VRFCoordinator.waitForDeployment();

        const txResponse = await VRFCoordinator.createSubscription();
        await txResponse.wait(1);

        const txResponse_1 = await VRFCoordinator.createSubscription();
        await txResponse_1.wait(1);

        const subCreationEventName = VRFCoordinator.filters.SubscriptionCreated;
        const events = await VRFCoordinator.queryFilter(subCreationEventName);
        const subscriptionId = events[0].topics[1];

        const fundAmount = "1000000000000000000";
        await VRFCoordinator.fundSubscription(subscriptionId, fundAmount);

        const keyHash = "0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc";
        const vrfCoordinatorAddr = VRFCoordinator.target;

        const VRFConsumerContract = await ethers.getContractFactory("VRFTask");

        const VRFConsumer = await VRFConsumerContract
            .connect(deployer)
            .deploy(
                subscriptionId,
                vrfCoordinatorAddr,
                keyHash
            );
        
        const VRFConsumerAddr = VRFConsumer.target;
        await VRFCoordinator.addConsumer(subscriptionId, VRFConsumerAddr);

        return { VRFConsumer, VRFCoordinator };
    }

    it("单元测试 1-0: VRF 请求成功发送", async function() {
        const { VRFConsumer, VRFCoordinator } = await loadFixture(deployVRFConsumerFixture);
        await expect(VRFConsumer.requestRandomWords()).to.emit(
            VRFCoordinator,
            "RandomWordsRequested"
        );
    });


    it("单元测试 1-1: 成功接受到随机数", async function() {
        const { VRFConsumer, VRFCoordinator } = await loadFixture(deployVRFConsumerFixture);
        await VRFConsumer.requestRandomWords();
        const requestId = await VRFConsumer.s_requestId();

        
        await expect(
            VRFCoordinator.fulfillRandomWords(
                requestId,
                VRFConsumer.target
            )
        ).to.emit(VRFConsumer, "ReturnedRandomness")

        const rand0 = await VRFConsumer.s_randomWords(0);
        const rand1 = await VRFConsumer.s_randomWords(1);
        const rand2 = await VRFConsumer.s_randomWords(2);
        const rand3 = await VRFConsumer.s_randomWords(3);
        const rand4 = await VRFConsumer.s_randomWords(4);

        expect(rand0).to.be.above(0, "1st random number is not greater than 0");
        expect(rand1).to.be.above(0, "1st random number is not greater than 0");
        expect(rand2).to.be.above(0, "1st random number is not greater than 0");
        expect(rand3).to.be.above(0, "1st random number is not greater than 0");
        expect(rand4).to.be.above(0, "1st random number is not greater than 0");
    });

    it("单元测试 1-2: 成功得到 5 个不重复的随机数", async function() {
        const { VRFConsumer, VRFCoordinator } = await loadFixture(deployVRFConsumerFixture);
        await VRFConsumer.requestRandomWords();
        const requestId = await VRFConsumer.s_requestId();

        await VRFCoordinator.fulfillRandomWords(requestId, VRFConsumer.target);
        
        const rand0 = await VRFConsumer.s_randomWords(0);
        const rand1 = await VRFConsumer.s_randomWords(1);
        const rand2 = await VRFConsumer.s_randomWords(2);
        const rand3 = await VRFConsumer.s_randomWords(3);
        const rand4 = await VRFConsumer.s_randomWords(4);

        const arr = [
            parseInt(rand0), 
            parseInt(rand1), 
            parseInt(rand2), 
            parseInt(rand3), 
            parseInt(rand4)
        ]

        const set = new Set(arr);
        expect(set).to.have.lengthOf(5, "there is duplicates in your random numbers");
    });
});