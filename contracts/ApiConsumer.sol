// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import "./WeatherToken.sol";

/*
 * 任务 6：
 * 通过 Chainlink AnyApi 给在任务 5 中部署的动态 NFT 更新数据
 * 完成 requestTempreture 和 fulfill
 * 
 * 任务 6 完成标志：
 * 1. fulfill 函数可以成功调用 weatherToken 的 setUriToUpdate 函数
 * 2. 可以在 opensea 的测试网（https://testnets.opensea.io/zh-CN）中看到 NFT 的图片发生了更新
*/

contract APIConsumer is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    uint256 public temperature;
    bytes32 private jobId;
    uint256 private fee;
    address public nftAddress;

    constructor(address _nftAddress) ConfirmedOwner(msg.sender) {
        // 代码中的设置适用于
        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        setChainlinkOracle(0xCC79157eb46F5624204f47AB42b3906cAA40eaB7);
        jobId = "ca98366cc7314957b8c012c72f05aeeb";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
        nftAddress = _nftAddress;
    }

    function updateNftAddress(address addressToUpdate) public onlyOwner  {
        nftAddress = addressToUpdate;
    }

    function requestTemperature() public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfill.selector
        );

        // 可以通过高德或者其他你喜欢的 api 获得天气数据 
        // 高德 Api 使用方法：https://lbs.amap.com/api/webservice/guide/api/weatherinfo
        // 补完下面一行代码
        req.add(
            "get",
            "https://restapi.amap.com/v3/weather/weatherInfo?city=110101&key=<key>"
        );

        // 完成 path：指的是 json 数据中的有效信息的位置
        // 补完下面一行代码
        req.add("path", "");

        int256 timesAmount = 10 ** 18;
        req.addInt("times", timesAmount);
        return sendChainlinkRequest(req, fee);
    }

    /**
     * 回调函数，收到预言机节点发回的 uint256 数据
     */
    function fulfill(
        bytes32 _requestId,
        uint256 _temperature
    ) public recordChainlinkFulfillment(_requestId) {
        // 通过返回的 temperature 调用 WeatherToken 中的 setUriToUpdate 函数
        // 请在此添加代码
    }

    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(
            link.transfer(msg.sender, link.balanceOf(address(this))),
            "Unable to transfer"
        );
    }
}
