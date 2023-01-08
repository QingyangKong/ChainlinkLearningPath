// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/*
 * 任务 5：
 * 部署一个动态 NFT
 * 完成 setUriToUpdate 和 updateTokenUri 两个函数
 * setUriToUpdate 实现功能
 *  - 如果温度低于或者等于 10 度 -  uriToUpdate = METADATA_BELOW
 *  - 如果温度在 10 度和 20 度之间 - uriToUpdate = METADATA_AVERAGE
 *  - 如果温度高于或者等于 20 度 - uriToUpdate = METADATA_ABOVE
 * updateTokenUri 实现功能
 *  - 将 tokenId 的 uri 改为 uriToUpdate
 * 
 * 任务 5 完成标志：
 * 1. 可以通过 4_nft_basic_test.js 中的所有测试：4-1 到 4-5
 * 2. 可以在 opensea 的测试网（https://testnets.opensea.io/zh-CN）中看到发布的动态 NFT
 * 3. 通过调用 updateTokenUri 来实现图片的更新
*/

contract WeatherToken is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    string constant METADATA_UNKNOWN = "ipfs://QmTH56C6s1PQcP3T4oNqXbeaY2gcSw9cYs5yCsozmzhobv";
    string constant METADATA_BELOW = "ipfs://QmYjAtBPAo2qjtiYzUozFtcXCwgCLLLJeVgSphfB6t2yvz";
    string constant METADATA_AVERAGE = "ipfs://QmU6gvcWXBknL8d2czoxyC5N5bnFzAFDwHS3hDsWVw8Ttd";
    string constant METADATA_ABOVE = "ipfs://QmVm1ne2q3cHPvyJtEJKQ7SMbr8TFMGJK6SYYiqC9sYvRf";

    Counters.Counter private _tokenIdCounter;

    string public uriToUpdate = METADATA_UNKNOWN;

    constructor() ERC721("WeatherToken", "WTK") {}

    function setUriToUpdate(uint256 temperature) public {
        uint256 timesAmount = 10 ** 18;
        // 在这里添加代码
    }

    function updateTokenURI(uint256 tokenId) public {
        // 1. 比较 tokenId 现在的 uri 和 uriToUpdate
        // 2. 如果不相同，就更新 tokenId 的 uri
        // 在这里添加代码
    }

    function safeMint() public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, METADATA_UNKNOWN);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}