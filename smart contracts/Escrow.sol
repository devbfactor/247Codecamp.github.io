//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Escrow {

  // The address of the buyer
  address payable public buyer;

  // The address of the seller
  address payable public seller;

  // The amount of money that is being escrowed
  uint256 public amount;

  // The start of countdown for confirming of payment.
  uint256 public timeStart;

  // The end of countdown for confirming of payment.
  uint256 public timeEnd;

  // Used as a flag to prevent reentrant calls in the contract.
  bool private locked;

  // To verify if there's ongoing delivery.
  bool public ongoingDelivery;

  // The status of the escrow
  enum Status {
    AwaitingPayment,
    AwaitingDelivery,
    AwaitingConfirmation,
    Completed,
    Disputed
  }

  // Initalization of Status enum.
  Status public status;
  
  event Received(address sender, uint256 value);

  modifier nonReentrant {
      require(!locked, "Reentrant call detected");
      locked = true;
      _;
      locked = false;
  }

  // The constructor sets the initial status of the escrow to "AwaitingPayment"
  constructor() {
    status = Status.AwaitingPayment;
  }

  // The buyer can pay the seller by calling this function
  function pay(address _seller) public payable virtual {
    require(msg.sender != address(0), "Buyer must not be Address 0");
    require(msg.value > 0, "Amount should be not 0");

    buyer = payable(msg.sender);
    seller = payable(_seller);
    
    require(status == Status.AwaitingPayment);
    amount += msg.value;
    status = Status.AwaitingDelivery;
  }

  // The seller can deliver the goods to the buyer by calling this function
  function deliver() public virtual {
    require(status == Status.AwaitingDelivery);
    require(msg.sender == seller, "Only the seller can call this function");
    require(msg.sender != address(0), "Seller must not be Address 0");
    status = Status.AwaitingConfirmation;
    
    timeStart = block.timestamp;
    timeEnd = countdown();
    ongoingDelivery = true;
  }

  // The buyer can confirm that it received the item by calling this function
  function confirm() public virtual {
    require(status == Status.AwaitingConfirmation, "Status needs to be Awaiting Confirmation");
    require(msg.sender == buyer, "Only the buyer can call this function");
    require(msg.sender != address(0), "Buyer must not be Address 0");
    status = Status.Completed;
    releasePayment();
  }

  // This function releases the payment to the seller if the status is "Completed"
  function releasePayment() internal nonReentrant {
    seller.transfer(amount);
  }

  // It is used to handle the case where the buyer fails to confirm the receipt of the item within a specified timeout period.
  function confirmTimeout() external virtual {
    require(status == Status.AwaitingConfirmation, "Status needs to be Awaiting Confirmation");
    require(status != Status.Disputed, "Status is currently disputed");
    require(block.timestamp >= timeStart + 1800, "Confirmation timeout not yet reached.");
    status = Status.Completed;
    releasePayment();
    ongoingDelivery = false;
  }

  // It calculates the end time for the confirmation timeout period.
  function countdown() internal virtual returns (uint256) {
    uint256 time = block.timestamp + 120;
    return time;
  }

  // The buyer can dispute the transaction by calling this function
  function dispute() public {
    require(status == Status.AwaitingConfirmation);
    require(msg.sender == buyer, "Buyer must not be the caller of this function");
    require(msg.sender != address(0), "Buyer must not be Address 0");
    status = Status.Disputed;
    ongoingDelivery = false;
  }

  // This function is called if the buyer disputes the transaction
  function disputeResolution() public {
    require(status == Status.Disputed);
    // TODO: Implement dispute resolution mechanism
  }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}
