// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract ArbitrargeFlashLoan is FlashLoanSimpleReceiverBase {
    address payable owner;

    uint256 pancakeSwapEthToUSDC = 608582000000000; // 1643 USDC
    uint256 uniswapUsdcToEth = 610000000000000; // 1 USDC = 0.00061 ETH

    event swapEthToUSDC(uint amount, uint UsdcToEth);
    event swapUsdcToETH(uint amount, uint EthToUsdc);

    constructor(
        address _addressProvider
    ) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider)) {
        owner = payable(msg.sender);
    }

    function fn_RequestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        POOL.flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        uint256 uniswapConversion = amount * uniswapUsdcToEth; // From USDC we will convert to ETH
        emit swapEthToUSDC(amount, uniswapConversion);

        uint256 pancakeSwapConversion = uniswapConversion /
            pancakeSwapEthToUSDC; // From ETH we will convert to USDC
        emit swapUsdcToETH(amount, pancakeSwapConversion);

        uint256 arbitrage_amount = pancakeSwapConversion - amount;
        IERC20 token = IERC20(asset);

        uint256 totalLoan = amount + premium;
        IERC20(asset).approve(address(POOL), totalLoan);

        return token.transfer(owner, arbitrage_amount);
    }

    function getBalance(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can call this function"
        );
        _;
    }

    receive() external payable {}
}
