// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import '@chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol';

/*
 * 任务 3 内容，在合约中维持一个数组，记录 10 个账户的余额
 * 如果余额不足最小额度，则通过 Chainlink Keepers 对余额进行补充到最小额度
 * 参考视频教程：https://www.bilibili.com/video/BV1ed4y1N7Uv?p=9
 */
contract KeepersTask is KeeperCompatibleInterface {

    uint256[10] public balances;
    uint256 public constant LIMIT = 1000;
    
    /*
     * 步骤 1 - 在构造函数中初始化数组 balances
     * 将 balances 中的数值初始化为最小值
     */
    constructor() {}

    /*
     * 步骤 2 - 定义 withdraw 函数
     * 使得用户可以通过 withdraw 函数改变数组中的余额
     */
    function withdraw(uint256 amount, uint256[] memory indexes) public {}   


    /* 
     * 步骤 3 - 通过 checkUpKeep 来检测数组 balances 中的数值是否小于最小值 LIMIT
     * 注意这部分操作将由 Chainlink 预言机节点在链下计算
     * 可以尝试在 checkUpKeep 函数中改变状态，观察是否会发生改变
     */  
    function checkUpkeep(
        bytes calldata /* checkData */
    ) external view override returns (bool upkeepNeeded, bytes memory performData) {

    }

    /* 
     * 步骤 4 - 通过 performUpKeep 来完成将数组中补足余额的任务（可以将遍历操作在链下进行）
     * 例如发现 balances[0] = 500，则将其增加 500 变为 1000
     * 注意可以通过 performData 使用 checkUpkeep 的运算结果，减少 gas 费用
     */
    function performUpkeep(
        bytes calldata /* performData */
    ) external override {
    
    }

    /**
     * 步骤 5 - 通过 Remix 部署合约（使用 goerli 网络）
     * 
     * 步骤 6 - 在 chainlink keepers 页面注册 Upkeep（使用 goerli 网络）
     * 
     * 步骤 7 - 补充注册的 upkeep 的余额，以使 upKeep 可以运行
     * 
     * 成功标志
     * 可以观察到 balances 中的余额可以被自动补足
     * 可以观察到 Keepers 页面中的 history 有成功的交易
     * 
     * 恭喜你，完成了 3 个任务，请在 fork 的 repository 提交修改
     * 联系 Frank 获得奖品！
     */
    
}