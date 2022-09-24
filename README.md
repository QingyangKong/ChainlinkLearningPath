# Chainlink Learning Path
![image](./image/logo-chainlink-blue.svg)

Chainlink 预言机网络，可以让区块链上的智能合约获取到真实的世界的数据，同时可以使用链下的计算资源。在给链上智能合约输入数据的同时，Chainlink 还通过去中心化的预言机网络保证了数据的安全性和可靠性。

本项目的**目标人群**为刚开始了解预言机甚至是智能合约的开发者，目的是希望能够通过[几个任务](#任务)和[配套的教程](#任务相关资源)实现：
1. 帮助智能合约开发者理解预言机工作原理
2. 帮助开发者了解 Chainlink 预言机所需的开发环境
3. 帮助开发者了解使用 Chainlink 预言机所需的配置
4. 帮助开发者学会如何集成 Chainlink 预言机的下列服务：
   1. Data feed（喂价）
   2. VRF（可验证随机数）
   3. Keepers（合约自动化执行）
   4. AnyAPI（获取任意链下数据）

## 任务
1. 环境配置：
   1. fork 这个 Repo 
   2. clone Repo 到本地
   3. 通过 yarn 包管理工具安装必要 package
   4. 安装浏览器钱包 Metamask
   5. 获取以太坊 RPC（推荐使用 [Alchemy](https://www.alchemy.com/) 或者 [Infura](https://infura.io/)）
2. Chainlink Data Feed 任务：
   1. 学习 [Chainlink Data Feed（喂价）](#chainlink-data-feed喂价) 部分内容。
   2. 根据学习内容合约中完成三种 Token 价格的获取，并且在完成 USD 的转换，详情见描述。
3. Chainlink VRF 任务：
   1. 学习 [Chainlink VRF（可验证随机数）](#chainlink-vrf可验证随机数) 部分学习到的内容。
   2. 在合约中从 VRF 中获取 10 个不重复的随机数，存入用户合约的数组中，详情见描述。
4. Chainlink Keepers 任务：
   1. 学习[Chainlink Keepers（合约自动化执行）](#chainlink-keepers合约自动化执行)部分内容。
   2. 使用 Keepers 根据随机数动态改变已有的变量值，详情见描述。

## 任务相关教程
任务需要使用当前比较主流的 Hardhat 合约框架以及 Goerli 测试网络。
- [Chainlink 视频教程](https://www.bilibili.com/video/BV1ed4y1N7Uv)：视频教程包含 Chainlink Data Feed, VRF 以及 Keepers 的原理讲解，使用方法以及代码演示。
- [Chainlink 原理解析文字版](https://learnblockchain.cn/article/4766)：包含 Chainlink Data Feed, VRF 以及 Keepers 的原理讲解。
- [常见技术问题汇总](https://learnblockchain.cn/people/398/questions)：列举出开发者曾经遇到过的问题以及解决方案。
- [Chainlink 官方技术文档](https://docs.chain.link/)：Chainlink 官方文档，包括各个产品的原理讲解，样例代码，必要的配置信息和合约地址。
- [Chainlink faucet（水龙头）](https://faucets.chain.link/)：Chainlink 官方 faucet，可以在不同的链上获取测试 token，目前 Rinkeby 和 Kovan 测试网络已经不再支持，请使用 Goerli 测试网。
- [Chainlink Github repo](https://github.com/smartcontractkit)：Chainlink 官方 GitHub，在官方文档以及视频教程中没有介绍的内容，可以通过查阅代码来验证。

## Chainlink Data Feed（喂价）
Chainlink Data Feeds 又称喂价，这项服务可以让用户的智能合约以最快的方式获得真实世界中的资产标的价格，不论你使用的是链上的智能合约和还是链下应用，都可以通过单一一次请求，从 Chainlink Data Feeds 获得资产的价格数据。

### 相关链接
- [Data Feed 应用页面](https://data.chain.link/)：你可以在这个页面看到 Chainlink 所提供的交易对的具体信息，比如说资产信息，节点运营商信息，网络信息，数据更新规则等等。
- [Data Feed 聚合合约地址列表](https://docs.chain.link/docs/reference-contracts/)：你的智能合约中需要使用 VRFCoordinator 来集成 Chainlink VRF 的服务。
- [视频教程（中文）](https://www.bilibili.com/video/BV1ed4y1N7Uv?p=2)：讲解了 Chainlink Data Feed 的原理以及使用方法。
- [视频教程（英文）](https://www.youtube.com/watch?v=e75kwGzvtnI)：讲解了 Chainlink Data Feed 的原理。
- [Data Feed 官方技术文档](https://docs.chain.link/docs/using-chainlink-reference-contracts/)：官方技术文档 Data Feed 部分，包括原理讲解和样例合约。
## Chainlink VRF（可验证随机数）
Chainlink VRF（Verifiable Random Function）是一个随机数的生成器（Random Number Generator：RNG）。通过 Chainlink VRF 中，智能合约可以在不影响安全性和可用性的条件下获取随机数。

Chainlink VRF 每次收到一个随机数的请求，都可以将一个或者多个随机值以及它们对应的密码学证明（cryptographic proof）发送给智能合约。链上智能合约通过密码学证明对随机数验证以后，会将随机数写入用户智能合约。

这个过程保证了随机数的结果不能被包括矿工，节点运营商，用户和智能合约开发人员在内的任何一方单方面操纵和修改，以此保证了随机数和可靠性和安全性。
### 相关链接
- [Chainlink VRF 应用页面](https://vrf.chain.link/)：你可以通过这个网页注册 VRF Subscription 来使用 Chainlink VRF 获取随机数。
- [VRFCoordinator 合约地址](https://docs.chain.link/docs/vrf/v2/supported-networks/)：智能合约中需要使用 VRFCoordinator 来集成 Chainlink VRF 的服务。
- [视频教程（中文）](https://www.bilibili.com/video/BV1ed4y1N7Uv?p=5)：讲解了 Chainlink VRF 的原理以及使用方法。
- [视频教程（英文）](https://www.youtube.com/watch?v=JqZWariqh5s)：讲解了 Chainlink VRF 的原理以及使用方法。
- [VRF 官方技术文档](https://docs.chain.link/docs/vrf/v2/introduction/)：官方技术文档 VRF 部分，包括原理讲解和样例合约。
## Chainlink Keepers（合约自动化执行）
Chainlink Keepers 可以通过链下 Chainlink 去中心化预言机网络，根据条件或者时间触发链上智能合约，实现智能合约执行的自动化。

### 相关链接
- [Chainlink Market](https://market.link/overview)：可以使用此页面查找不同链上的数据提供商，通过这些节点让智能合约获得诸如股票，天气，经济，体育等等领域的数据。
- [Chainlink Registry 地址](https://docs.chain.link/docs/chainlink-keepers/supported-networks/)：可以通过发送交易的方式，在链上直接注册 UpKeep，让用户合约通过 Chainlink Keepers 所自动化。
- [视频教程（中文）](https://www.bilibili.com/video/BV1ed4y1N7Uv?p=9)：讲解了中如何运行自己的 Chainlink 节点。
- [视频教程（英文）](https://www.youtube.com/watch?v=fICFYsN4E74)：讲解了中如何使用 External Adapter。
- [Any API 官方技术文档](https://docs.chain.link/docs/any-api/introduction/)：官方技术文档 Keepers 部分，包括原理讲解和样例合约。

## Chainlink Any API（获取任何链下 API 数据）
Chainlink Any API 可以让你的智能合约通过 Chainlink 去中心化预言机网络获取任意的外部数据。将智能合约与链下的数据相结合会给你的 DApp 增加很多复杂度，所以 Chainlink 通过 Any API 提供了一个极易使用并且很灵活的框架，可以将任何外部 API 的数据提供给区块链上的智能合约。

这样开发者可以将精力集中在智能合约的功能性上，链上数据的监控，链下数据的输入都可以由 Chainlink 链下预言机网络提供，使得链上合约和链下交互变得更加简单。

除此以外，开发者可以自建节点，在节点中创建任务，获取外部的 API，然后输入给链上的智能合约。通过自建节点，不仅让自身的合约实现数据获取，也可以作为数据提供商向市场上其他的智能合约提供 Any API 服务。
### 相关链接
- [Chainlink Keepers 应用页面](https://keepers.chain.link/)：用户可以使用 UI 在不同链上的注册，取消以及监控 UpKeep。
- [测试网预言机合约地址](https://docs.chain.link/docs/any-api/testnet-oracles/)：可以通过发送交易的方式，在链上直接注册 UpKeep，让用户合约通过 Chainlink Keepers 所自动化。
- [视频教程（中文）](https://www.bilibili.com/video/BV1ed4y1N7Uv?p=9)：讲解了 Chainlink VRF 的原理以及使用方法。
- [视频教程（英文）](https://www.youtube.com/watch?v=MSKDIy85xlI)：讲解了 Chainlink VRF 的原理。
- [一文读懂Web3项目为什么需要以去中心化的方式实现自动化](https://learnblockchain.cn/article/4051)：文章详细解释了 Chainlink Keepers 的特点和优势。

## 接下来做什么？
尝试在应用中使用 Chainlink 服务

除了在自己的项目中使用 Chainlink 的服务，还可以参与 Chainlink 生态中的活动，获得更多资源。比如参加 Chainlink 黑客松。Chainlink 每年会有两次黑客松，为 4 月开始的[春季黑客松](https://chainlinkspring2022.devpost.com/)和 10 月开始的[秋季黑客松](https://chain.link/hackathon)。

申请 Chainlink Grant。为了鼓励生态发展，为行业做出共享，Chainlink 官方会对有创新性和社会影响力的项目提供 Grant。在[这里](https://chain.link/community/grants)查看 Chainlink Grant 具体信息以及往期项目介绍。

成为 Chainlink Contributor。如果想要给 Chainlink 共享代码，请查看 [contributor 规则](https://github.com/smartcontractkit/chainlink/blob/develop/docs/CONTRIBUTING.md)。如果想让团队增加新的特性，或者是提交 bug，请在官方 GitHub 的 [Issue](https://github.com/smartcontractkit/chainlink/issues) 中提交。

## 社区支持
Chainlink 中国开发者社区会持续性输出 Chainlink 最新信息，并且不定期举办一些分享来学习优秀案例。或者你在使用 Chainlink 的时候遇到了任何的问题，可以和熟悉的开发者一起交流。

如果想要加入社区，请扫描以下二维码：
![image](./image/QRCode.png)


## 其他资料
- [（32 小时最全课程）区块链，智能合约 & 全栈 Web3 开发](https://www.bilibili.com/video/BV1Ca411n7ta)
- [（32 小时最全课程）区块链，智能合约 & 全栈 Web3 开发（英文）](https://www.youtube.com/watch?v=gyMwXuJrbJQ)
- [Chainlink Hardhat starter kit](https://github.com/smartcontractkit/hardhat-starter-kit)
- [Chainlink预言机在智能合约中的77种应用方式（一）](https://learnblockchain.cn/article/4115)
- [Chainlink预言机在智能合约中的77种应用方式（二）](https://learnblockchain.cn/article/4144)
- [Chainlink预言机在智能合约中的77种应用方式（三）](https://learnblockchain.cn/article/4262)
- [一文读懂Web3项目为什么需要以去中心化的方式实现自动化](https://learnblockchain.cn/article/4051)