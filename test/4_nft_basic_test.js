const { ethers } = require("hardhat")
const { assert, expect } = require("chai")
const { loadFixture, time } = require("@nomicfoundation/hardhat-network-helpers");
const { BigNumber } = require("ethers");

const unknowUri = "ipfs://QmTH56C6s1PQcP3T4oNqXbeaY2gcSw9cYs5yCsozmzhobv";
const averageUri = "ipfs://QmU6gvcWXBknL8d2czoxyC5N5bnFzAFDwHS3hDsWVw8Ttd";
const aboveUri = "ipfs://QmVm1ne2q3cHPvyJtEJKQ7SMbr8TFMGJK6SYYiqC9sYvRf";
const belowUri = "ipfs://QmYjAtBPAo2qjtiYzUozFtcXCwgCLLLJeVgSphfB6t2yvz";

describe("单元测试：NFT 基础", async function() {
    async function deployNftFixure() {
        const [deployer] = await ethers.getSigners()
        const nftFactory = await ethers.getContractFactory("WeatherToken");
        const nft = await nftFactory.connect(deployer).deploy();

        return { nft }
    }

    it("单元测试 4-1： NFT 可以被成功 mint", async function(){
        const [deployer] = await ethers.getSigners()
        const { nft } = await loadFixture(deployNftFixure)
        await nft.connect(deployer).safeMint();
        const uri = await nft.tokenURI(0)
        assert.equal(uri, unknowUri)
    })

    it("单元测试 4-2： tokenUri 可以修改为 below", async function(){
        const [deployer] = await ethers.getSigners()
        const { nft } = await loadFixture(deployNftFixure)
        await nft.connect(deployer).safeMint()
        await nft.setUriToUpdate(ethers.utils.parseEther("9.0"))
        const uriToUpdate = await nft.uriToUpdate()
        assert.equal(uriToUpdate, belowUri)
    })

    it("单元测试 4-3： tokenUri 可以修改为 avevrage", async function(){
        const [deployer] = await ethers.getSigners()
        const { nft } = await loadFixture(deployNftFixure)
        await nft.connect(deployer).safeMint()
        await nft.setUriToUpdate(ethers.utils.parseEther("15.0"))
        const uriToUpdate = await nft.uriToUpdate()
        assert.equal(uriToUpdate, averageUri)
    })

    it("单元测试 4-4： tokenUri 可以修改为 above", async function(){
        const [deployer] = await ethers.getSigners()
        const { nft } = await loadFixture(deployNftFixure)
        await nft.connect(deployer).safeMint()
        await nft.setUriToUpdate(BigNumber.from("25000000000000000000"))
        const uriToUpdate = await nft.uriToUpdate()
        assert.equal(uriToUpdate, aboveUri)
    })

    it("单元测是 4-5：token Id 0 的 tokenUri 可以被修改", async function(){
        const [deployer] = await ethers.getSigners()
        const { nft } = await loadFixture(deployNftFixure);
        await nft.connect(deployer).safeMint();
        await nft.connect(deployer).setUriToUpdate(15000000000000000000n)
        await nft.connect(deployer).updateTokenURI(0)
        const tokenUriTokenId0 = await nft.tokenURI(0)
        assert.equal(tokenUriTokenId0, averageUri)
    })
})