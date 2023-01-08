// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import "./WeatherToken.sol";

contract APIConsumer is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    uint256 public temperature;
    bytes32 private jobId;
    uint256 private fee;
    address public nftAddress;

    constructor(address _nftAddress) ConfirmedOwner(msg.sender) {
        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        
        // private address and jobId
        // setChainlinkOracle(0x4217B5985dF90357BE40A4E5c5C9Db97465C6261);
        // jobId = "eaab3c37bad44a51bb62bab4cafea330";
        
        // address and jobId maintained by Chainlink devrel team
        setChainlinkOracle(0xCC79157eb46F5624204f47AB42b3906cAA40eaB7);
        jobId = "ca98366cc7314957b8c012c72f05aeeb";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
        nftAddress = _nftAddress;
    }

    function updateNftAddress(address addressToUpdate) public onlyOwner  {
        nftAddress = addressToUpdate;
    }

    /**
     * Create a Chainlink request to retrieve API response, find the target
     * data, then multiply by 1000000000000000000 (to remove decimal places from data).
     */
    function requestTemperature() public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfill.selector
        );

        // Set the URL to perform the GET request on
        req.add(
            "get",
            "https://restapi.amap.com/v3/weather/weatherInfo?city=440300&key=5d48285a3ae22561983e6caa93b5b0b5"
        );

        req.add("path", "lives,0,temperature"); // Chainlink nodes 1.0.0 and later support this format

        // Multiply the result by 1000000000000000000 to remove decimals
        int256 timesAmount = 10 ** 18;
        req.addInt("times", timesAmount);

        // Sends the request
        return sendChainlinkRequest(req, fee);
    }

    /**
     * Receive the response in the form of uint256
     */
    function fulfill(
        bytes32 _requestId,
        uint256 _temperature
    ) public recordChainlinkFulfillment(_requestId) {
        temperature = _temperature;
        WeatherToken weatherToken = WeatherToken(nftAddress);
        weatherToken.setUriToUpdate(temperature);
    }

    /**
     * Allow withdraw of Link tokens from the contract
     */
    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(
            link.transfer(msg.sender, link.balanceOf(address(this))),
            "Unable to transfer"
        );
    }
}
