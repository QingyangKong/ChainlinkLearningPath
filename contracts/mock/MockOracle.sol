// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/LinkTokenReceiver.sol";
import "@chainlink/contracts/src/v0.6/interfaces/ChainlinkRequestInterface.sol";
import "@chainlink/contracts/src/v0.6/interfaces/LinkTokenInterface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract MockOracle is ChainlinkRequestInterface, LinkTokenReceiver {
    using SafeMathChainlink for uint256;

    uint256 public constant EXPIRY_TIME = 5 minutes;
    uint256 private constant MINIMUM_CONSUMER_GAS_LIMIT = 40000;

    struct Request {
        address callbackAddr;
        bytes4 callbackFunctionId;
    }

    LinkTokenInterface internal LinkToken;
    mapping (bytes32 => Request) private commitments;

    event OracleRequest(
        bytes32 indexed specId,
        address requester,
        bytes32 requestId,
        uint256 payment,
        address callbackAddr,
        bytes4 callbackFunctionId,
        uint256 cancelExpiration,
        uint256 dataVersion,
        bytes data
    );

    event CancelOracleRequest(bytes32 indexed requestId);

    constructor(address _link) public {
        LinkToken = LinkTokenInterface(_link);
    }

    function oracleRequest(
        address _sender,
        uint256 _payment,
        bytes32 _specId,
        address _callbackAddress,
        bytes4 _callbackFunctionId,
        uint256 _nonce,
        uint256 _dataVersion,
        bytes calldata _data
    ) external 
    override 
    onlyLINK 
    checkCallbackAddress(_callbackAddress) {
        bytes32 requestId = keccak256(abi.encodePacked(_sender, _nonce));
        require(
            commitments[requestId].callbackAddr == address(0),
            "Must use a unique ID"
        );
        
        uint256 expiration = now.add(EXPIRY_TIME);

        commitments[requestId] = Request(_callbackAddress, _callbackFunctionId);

        emit OracleRequest(
            _specId,
            _sender,
            requestId,
            _payment,
            _callbackAddress,
            _callbackFunctionId,
            expiration,
            _dataVersion,
            _data
        );
    }

    function fulfillOracleRequest(bytes32 _requestId, bytes32 _data) 
        external 
        isValidRequest(_requestId) 
        returns (bool) 
    {
        Request memory req = commitments[_requestId];
        delete commitments[_requestId];
        require(gasleft() >= MINIMUM_CONSUMER_GAS_LIMIT, "Must provide consumer enough gas");

        (bool success, ) = req.callbackAddr.call(
            abi.encodeWithSelector(req.callbackFunctionId, _requestId, _data)
        );
        return success;
    }

    function cancelOracleRequest(
        bytes32 _requestId,
        uint256 _payment,
        bytes4,
        uint256 _expiration
    ) external override {
        require(
            commitments[_requestId].callbackAddr != address(0), 
            "must use a unique ID"
        );

        require(_expiration <= now, "Request is not expired");

        delete commitments[_requestId];
        emit CancelOracleRequest(_requestId);

        assert(LinkToken.transfer(msg.sender, _payment));
    }

    function getChainlinkToken() public view override returns (address) {
        return address(LinkToken);
    }

    modifier isValidRequest(bytes32 _requestId) {
        require(
            commitments[_requestId].callbackAddr != address(0),
            "Must have a valid requestId"
        );
        _;
    }

    modifier checkCallbackAddress(address _to) {
        require(_to != address(LinkToken), "Cannot callback to LINK");
        _;
    }


}