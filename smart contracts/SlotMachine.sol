// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";


contract SlotMachine is VRFConsumerBaseV2 {
    event RequestSent (uint256 requestId, uint32 numWords);
    event RequestFulfilled (uint256 requestId, uint256 slot1, uint256 slot2, uint256 slot3);
    event minimumBetTransaction (address from, address to, uint256 amount);
    event WithdrawTransaction (address from, address to, uint256 amount);
    event JackpotWinner (address jackpotWinner, uint256 reward);
    event Niner (address winner, uint256 reward);
    event Short (address winner, uint256 reward);
    
    struct RequestStatus {
        bool fulfilled;
        bool exists;
    }

    mapping(uint256 => RequestStatus) public s_requests;
    mapping(address => uint256) private balances;
    mapping(address => uint256) public lastRequestId; 

    VRFCoordinatorV2Interface COORDINATOR;

    uint64 s_subscriptionId;

    uint256[] private requestIds;
    // uint256 public lastRequestId;
    bytes32 keyHash = 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
    uint32 callbackGasLimit = 2500000;
    uint16 requestConfirmations = 3;
    uint32 numWords = 3;

    address private _owner;
    uint256 public _minimumBet;
    
    uint256 public slot1;
    uint256 public slot2;
    uint256 public slot3;

    modifier onlyOwner {
        require(_owner == msg.sender, "Only the owner can call this function");
        _;
    }

    constructor(uint64 subscriptionId, uint256 minBet) VRFConsumerBaseV2(0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed) {
        COORDINATOR = VRFCoordinatorV2Interface(0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed);
        s_subscriptionId = subscriptionId;
        _owner = msg.sender;
        _minimumBet = minBet;
    }

    function minimumBet(uint256 _amount) public virtual onlyOwner returns (uint256) {
        return _minimumBet = _amount;
    }

    function requestRandomWords() private returns (uint256 requestId) {
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        s_requests[requestId] = RequestStatus({
            exists: true,
            fulfilled: false
        });

        requestIds.push(requestId);
        lastRequestId[msg.sender] = requestId;
        emit RequestSent (requestId, numWords);
        return requestId;
    }


    function deposit() public payable virtual {
        require(msg.value > 0, "You don't have enough tokens");
        balances[address(this)] += msg.value;
    }

    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
        require(s_requests[_requestId].exists, "request not found");
        s_requests[_requestId].fulfilled = true;
        slot1 = (_randomWords[0] % 9) + 1;
        slot2 = (_randomWords[1] % 9) + 1;
        slot3 = (_randomWords[2] % 9) + 1;
        winnerLogic(slot1, slot2, slot3);
        emit RequestFulfilled (_requestId, slot1, slot2, slot3);
    }


    function spin() public payable {
        require(address(this).balance > 0, "Not enough prize money");
        require(msg.value >= _minimumBet, "Not enough balance for entry fee");
        uint256 amount = msg.value;
        balances[address(this)] += amount;
        emit minimumBetTransaction (msg.sender, _owner, amount);
        requestRandomWords();
        _transfer(_owner, amount);
        emit WithdrawTransaction (address(this), _owner, amount);
    }

    function _transfer(address to, uint256 amount) internal virtual {
        require(address(this) != address(0), "transfer from the zero address");
        require(to != address(0), "transfer to the zero address");
        require(balances[address(this)] >= amount, "Not enough token to transfer");

        unchecked {
            balances[address(this)] = address(this).balance - amount;
            (bool success, ) = to.call{value: amount}("");
            require(success, "Failed to withdraw entry fee");
            balances[to] += amount;
        }
    }

    function balanceOf(address _address) public view returns (uint256) {
        return balances[_address];
    }


    function winnerLogic(uint256 _slot1, uint256 _slot2, uint256 _slot3) private returns(bool) {
        if ( _slot1 == 9 && _slot2 == 9 && _slot3 == 9) {
            _transfer(msg.sender, 0.1 ether);
            emit JackpotWinner (msg.sender, 0.1 ether);
            return true;
        }

        if (_slot1 == 9 || _slot2 == 9 || _slot3 == 9) {
            _transfer(msg.sender, 0.05 ether);
            emit Niner (msg.sender, 0.05 ether);
            return true;
        }

        for( uint i = 1; i <= 8; i++) {
            if (_slot1 == i && _slot2 == i && _slot3 == i) {
                _transfer(msg.sender, 0.01 ether);
                emit Short (msg.sender, 0.01 ether);
                return true;
            }
        }

        return false; 
    }


    function getRequestStatus(uint256 _requestId) external view returns (bool fulfilled, uint256, uint256, uint256) {
        require(s_requests[_requestId].exists, "request not found");
        RequestStatus memory request = s_requests[_requestId];
        return (request.fulfilled, slot1, slot2, slot3);
    }

    function withdraw() public onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Failed to withdraw balance");
        balances[address(this)] = address(this).balance;
    }
}
