// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract NoStandardToken {
    uint256 _maxSupply;
    uint256 _totalSupply;
    uint8 _decimals;
    address _owner;
    string _name;
    string _symbol;

    mapping(address => uint256) public balanceOf;
    event Transfer(address _from, address _to, uint _amount);

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 maxSupply_
    ) {
        _owner = msg.sender;
        _maxSupply = maxSupply_ * 10 ** _decimals;
        _decimals = 18;
        _name = name_;
        _symbol = symbol_;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Not the owner");
        _;
    }

    function name() public view virtual returns (string memory) {
        return _name;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    function maxSupply() public view virtual returns (uint256) {
        return _maxSupply;
    }

    function decimals() public view virtual returns (uint8) {
        return _decimals;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    function _mint(address account_, uint256 amount_) internal virtual {
        require(
            account_ != address(0),
            "Not allowed to mint from address zero"
        );
        require(amount_ > 0, "Amount being minted should be greater than zero");
        require(
            _maxSupply >= _totalSupply + amount_,
            "Max token to minted exceeded"
        );
        uint256 amount = amount_ * 10 ** _decimals;
        _totalSupply += amount;
        balanceOf[account_] += amount;
        emit Transfer(address(0), account_, amount);
    }

    function mint(uint256 amount_) public virtual onlyOwner returns (bool) {
        _mint(msg.sender, amount_);
        return true;
    }

    function _burn(address account_, uint256 amount_) internal virtual {
        require(
            account_ != address(0),
            "Not allowed to burn from address zero"
        );
        require(amount_ > 0, "Amount being burned should be greater than zero");
        uint256 amount = amount_ * 10 ** _decimals;
        _totalSupply -= amount;
        balanceOf[account_] -= amount;
        emit Transfer(account_, address(0), amount);
    }

    function burn(uint256 amount_) public virtual onlyOwner returns (bool) {
        _burn(msg.sender, amount_);
        return true;
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal virtual {
        require(_from != address(0), "Cannot transfer token from address 0");
        require(_to != address(0), "Cannot transfer to address 0");
        require(
            _from != _to,
            "_from address must not be the same with _to address"
        );
        uint256 amount = _amount * 10 ** _decimals;
        require(balanceOf[_from] >= amount, "Not enough token to transfer");
        balanceOf[_from] -= amount;
        balanceOf[_to] += amount;
        emit Transfer(_from, _to, amount);
    }

    function transfer(
        address _to,
        uint256 _amount
    ) public virtual onlyOwner returns (bool) {
        _transfer(msg.sender, _to, _amount);
        return true;
    }
}
