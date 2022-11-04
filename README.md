# Chainlink Learning Path
![image](./image/logo-chainlink-blue.svg)
## 项目介绍
[Chainlink](https://chain.link/)，是一个去中心化预言机网络（Decentralized Oracle Network），它可以给区块链上的智能合约提供数据和计算服务。其中数据服务包括 [Data Feed](https://docs.chain.link/docs/data-feeds/)，[Any API](https://docs.chain.link/docs/any-api/introduction/) 和 [DECO](https://www.deco.works/)，计算服务包括 [VRF](https://docs.chain.link/docs/vrf/v2/introduction/)，[Automation](https://docs.chain.link/docs/chainlink-automation/introduction/) 以及 [FSS](https://www.youtube.com/watch?v=uuu23oqnzck)。不论你开发什么类型的 Web3 应用，比如 DeFi，NFT，GameFi 等等，都有可能用到预言机这项基础服务，所以预言机的服务是 Web3 开发必须要掌握的一项内容。

本项目的目的是通过 [几个简单的任务](#任务) 和 [配套的教程](#任务相关资源) 来帮助开发者了解 Chainlink 预言机，**目标人群**为想要了解预言机的智能合约开发者。完成这几个任务以后，可以联系 Frank 获得 Chainlink 提供奖品！

完成后你将会学会以下知识：
1. 理解预言机工作原理
2. 了解 Chainlink 预言机技术文档结构和相关学习资料
3. 学会如何在合约中集成 Chainlink 预言机的服务包括：
   1. Data feed（喂价）
   2. VRF（可验证随机数）
   3. Automation（合约自动化执行）
   4. AnyAPI（获取任意链下数据）

## 练习任务
### 前期准备：
1. fork `ChainlinkLearningPath` 这个 Repository 到你的 GitHub。
2. git clone Repository 到本地: `git clone https://github.com/<Your username>/ChainlinkLearningPath.git`
3. 运行 `npm install` 或者 `yarn` 安装所需要的依赖。
4. 在测试网部署时，安装浏览器端钱包 [Metamask](https://metamask.io/)，并且生成自己的账户地址。
5. 在测试网部署时，通过 [Chainlink faucet](https://faucets.chain.link/) 获得 goerli 网络的 goerli ETH 以及 Link。
### 任务 1 - Chainlink Data Feed：
1. （30分钟）学习下述学习资料中的 Chainlink Data Feed（喂价）部分内容。
2. （10分钟）完成 [contracts/DataFeedTask.sol](./contracts/DataFeedTask.sol) 中的任务。
### 任务 2 - Chainlink VRF：
1. （30分钟）学习下述学习资料中的 Chainlink VRF（可验证随机数）部分内容。
2. （30分钟）完成 [contracts/VRFTask.sol](./contracts/VRFTask.sol) 中的任务。
### 任务 3 - Chainlink Automation：
1. （30分钟）学习下述学习资料中的 Chainlink Keepers（合约自动化执行）部分内容。
2. （20分钟）完成 [contracts/KeepersTask.sol](./contracts/AutomationTask.sol) 中的任务。


## 学习资料
### 1. Chainlink Data Feed（喂价）学习资料
Chainlink Data Feeds 又称喂价，这项服务可以让用户的智能合约以最快的方式获得特定资产标的价格，不论你使用的是链上的智能合约和还是链下应用，都可以通过单一请求，从 Chainlink Data Feeds 获得资产的价格数据。

#### Data Feed 相关链接
- [Data Feed 官方技术文档](https://docs.chain.link/docs/using-chainlink-reference-contracts/)：官方技术文档 Data Feed 部分，包括原理讲解和样例合约。
- [视频教程（中文）](https://www.bilibili.com/video/BV1ed4y1N7Uv?p=2)：讲解了 Chainlink Data Feed 的原理以及使用方法。
- [视频教程（英文）](https://www.youtube.com/watch?v=e75kwGzvtnI)：讲解了 Chainlink Data Feed 的原理。
- [Data Feed 应用页面](https://data.chain.link/)：你可以在这个页面看到 Chainlink 所提供的交易对的具体信息，比如说资产信息，节点运营商信息，网络信息，数据更新规则等等。
- [Data Feed 聚合合约地址列表](https://docs.chain.link/docs/reference-contracts/)：你的智能合约中需要使用 VRFCoordinator 来集成 Chainlink VRF 的服务。

### 2. Chainlink VRF（可验证随机数）学习资料
Chainlink VRF（Verifiable Random Function）是一个随机数的生成器（Random Number Generator：RNG）。通过 Chainlink VRF 中，智能合约可以在不影响安全性和可用性的条件下获取随机数。

Chainlink VRF 收到随机数的请求以后，会将一个或者多个随机值以及它们对应的密码学证明（cryptographic proof）发送给智能合约。链上智能合约通过密码学证明对随机数验证以后，会将随机数写入用户智能合约。

Chainlink VRF 生成的随机数不能被包括矿工，节点运营商，用户和智能合约开发人员在内的任何一方单方面操纵和修改，因此保证了随机数和可靠性和安全性。
### VRF 相关链接
- [VRF 官方技术文档](https://docs.chain.link/docs/vrf/v2/introduction/)：官方技术文档 VRF 部分，包括原理讲解和样例合约。
- [视频教程（中文）](https://www.bilibili.com/video/BV1ed4y1N7Uv?p=5)：讲解了 Chainlink VRF 的原理以及使用方法。
- [视频教程（英文）](https://www.youtube.com/watch?v=JqZWariqh5s)：讲解了 Chainlink VRF 的原理以及使用方法。
- [Chainlink VRF 应用页面](https://vrf.chain.link/)：你可以通过这个网页注册 VRF Subscription 来使用 Chainlink VRF 获取随机数。
- [VRFCoordinator 合约地址](https://docs.chain.link/docs/vrf/v2/supported-networks/)：智能合约中需要使用 VRFCoordinator 来集成 Chainlink VRF 的服务。
### 3. Chainlink Automation（合约自动化执行）学习资料
Chainlink Automation（曾经被命名为 Chainlink Keepers） 可以通过链下 Chainlink 去中心化预言机网络，根据条件或者时间触发链上智能合约，实现智能合约执行的自动化。

由于区块链上的智能合约无法自动执行，通常开发人员需要通过链下脚本或者赏金模式来保证合约函数的处罚。Chainlink Keepers 可以以去中心化的方式，监控链上合约从而保证合约函数的执行。

### Automation 相关链接
- [Keepers 官方技术文档](https://docs.chain.link/docs/chainlink-keepers/introduction/)：官方技术文档 Keepers 部分，包括原理讲解和样例合约。
- [视频教程（中文）](https://www.bilibili.com/video/BV1ed4y1N7Uv?p=9)：讲解了 Chainlink Keepers 的原理以及使用方法。
- [视频教程（英文）](https://www.youtube.com/watch?v=MSKDIy85xlI)：讲解了 Chainlink Keepers 的原理。
- [Chainlink Keepers 应用页面](https://keepers.chain.link/)：用户可以使用 UI 在不同链上的注册，取消以及监控 UpKeep。
- [Chainlink Registry 地址](https://docs.chain.link/docs/chainlink-keepers/supported-networks/)：可以通过发送交易的方式，在链上直接注册 UpKeep，让用户合约通过 Chainlink Keepers 所自动化。

### 4. Chainlink Any API（获取任意链下 API 数据）学习资料
Chainlink Any API 可以让你的智能合约通过 Chainlink 去中心化预言机网络获取任意的外部数据。将智能合约与链下的数据相结合会给你的 DApp 增加很多复杂度，所以 Chainlink 通过 Any API 提供了一个极易使用并且很灵活的框架，可以将任何外部 API 的数据提供给区块链上的智能合约。

这样开发者可以将精力集中在智能合约的功能性上，链上数据的监控，链下数据的输入都可以由 Chainlink 链下预言机网络提供，使得链上合约和链下交互变得更加简单。

除此以外，开发者可以自建节点，在节点中创建任务，获取外部的 API，然后输入给链上的智能合约。通过自建节点，不仅让自身的合约实现数据获取，也可以作为数据提供商向市场上其他的智能合约提供 Any API 服务。
### Any API 相关链接
- [Any API 官方技术文档](https://docs.chain.link/docs/any-api/introduction/)：官方技术文档 Any API 部分，包括原理讲解和样例合约。
- [视频教程（中文）]()：WIP。
- [视频教程（英文）第一部分](https://www.youtube.com/watch?v=DO3O6ZUtwbs)：讲解了如何运行 Chainlink 节点。
- [视频教程（英文）第二部分](https://www.youtube.com/watch?v=fICFYsN4E74)：讲解了中如何结合 Chainlink 节点使用 External Adapter。
- [测试网预言机合约地址](https://docs.chain.link/docs/any-api/testnet-oracles/)：可以通过列表中的预言机合约地址，使用已有 Chainlink 节点的 Any API 服务。
- [Chainlink Market](https://market.link/overview)：在此页面查找不同链上的数据提供商，通过这些节点让智能合约获得诸如股票，天气，经济，体育等等领域的数据。

## 接下来做什么？
- 尝试在应用中使用 Chainlink 服务，扩展你的 dApp 的边界。

- 参与 Chainlink 生态中的活动，获得更多资源。比如 Chainlink 黑客松，Chainlink 每年会有举办两届黑客松：4 月开始的[春季黑客松](https://chainlinkspring2022.devpost.com/)和 10 月开始的[秋季黑客松](https://chain.link/hackathon)。

- 申请 Chainlink Grant。为了鼓励生态发展，给行业做贡献，Chainlink 官方会对有创新性和社会影响力的项目提供 Grant。在[这里](https://chain.link/community/grants)查看 Chainlink Grant 具体信息以及往期项目介绍。

- 申请 Chainlink 孵化器 Startup With Chainlink。Chainlink 官方会帮助优秀的早期项目方提供包括项目指导，资源对接的服务。在[这里](https://chainlinklabs.com/startup)查看 Startup With Chainlink 的更多信息。

- 成为 Chainlink Contributor。如果想要给 Chainlink 共享代码，请查看 [contributor 规则](https://github.com/smartcontractkit/chainlink/blob/develop/docs/CONTRIBUTING.md)。如果想让团队增加新的特性，或者是提交 bug，请在官方 GitHub 的 [Issue](https://github.com/smartcontractkit/chainlink/issues) 中提交。
- 赏金猎人。如果发现了任何的 vulnerability 或者 bug，欢迎提交给团队，获得赏金（bounty），请在[赏金计划](https://hackerone.com/chainlink?type=team)中查看更多的内容。

## 社区支持
Chainlink 中国开发者社区会持续性输出 Chainlink 最新信息，并且不定期举办一些分享来学习优秀案例。如果在使用 Chainlink 的时候遇到了任何的问题，可以和熟悉该技术的开发者和社区人员一起交流。

如果想要加入社区，请扫描以下二维码：
![image](./image/QRCode.png)


## 其他学习资料
任务需要使用当前比较主流的 Hardhat 合约框架以及 Goerli 测试网络。
- [Chainlink 视频教程](https://www.bilibili.com/video/BV1ed4y1N7Uv)：视频教程包含 Chainlink Data Feed, VRF 以及 Keepers 的原理讲解，使用方法以及代码演示。
- [Chainlink 原理解析文字版](https://learnblockchain.cn/article/4766)：包含 Chainlink Data Feed, VRF 以及 Keepers 的原理讲解。
- [常见技术问题汇总](https://learnblockchain.cn/people/398/questions)：列举出开发者曾经遇到过的问题以及解决方案。
- [Chainlink 官方技术文档](https://docs.chain.link/)：Chainlink 官方文档，包括各个产品的原理讲解，样例代码，必要的配置信息和合约地址。
- [Chainlink Github repo](https://github.com/smartcontractkit)：Chainlink 官方 GitHub，在官方文档以及视频教程中没有介绍的内容，可以通过查阅代码来验证。
- [（32 小时最全课程）区块链，智能合约 & 全栈 Web3 开发](https://www.bilibili.com/video/BV1Ca411n7ta)
- [Chainlink Hardhat starter kit](https://github.com/smartcontractkit/hardhat-starter-kit)
- [Chainlink预言机在智能合约中的77种应用方式（一）](https://learnblockchain.cn/article/4115)
- [Chainlink预言机在智能合约中的77种应用方式（二）](https://learnblockchain.cn/article/4144)
- [Chainlink预言机在智能合约中的77种应用方式（三）](https://learnblockchain.cn/article/4262)
- [一文读懂Web3项目为什么需要以去中心化的方式实现自动化](https://learnblockchain.cn/article/4051)
- [怎样通过 Etherscan 验证智能合约](https://learnblockchain.cn/article/4664)
- [使用 Chainlink Keepers 实现智能合约函数的自动化执行](https://learnblockchain.cn/article/4451)
- [NFT 交易所合约开发教程（Solidity & Hardhat）](https://learnblockchain.cn/article/4410)
- [Solidity 的 ABI 和 bytecode 是什么](https://learnblockchain.cn/article/4668)
- [通过 Chainlink Proof of Reserve 来验证 BTC 质押资产](https://learnblockchain.cn/article/4603)
- [开发 dApp 的三个步骤](https://learnblockchain.cn/article/4715)
- [怎样开发智能合约中的时间锁](https://learnblockchain.cn/article/4735)
- [如何在 NFT(ERC721)中获取随机数](https://learnblockchain.cn/article/3951)
- [如何在 Hardhat 中使用 Chainlink](https://learnblockchain.cn/article/3823)
- [如何在 BNB 链上创建 BEP-20 通证](https://learnblockchain.cn/article/3917)
- [如何在 Polygon 上创建 ERC-20 通证](https://learnblockchain.cn/article/4080)
- [一文速览Chainlink 2.0白皮书](https://learnblockchain.cn/article/3106)