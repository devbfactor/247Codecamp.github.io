// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract IdentityVerification is ERC721URIStorage {
    uint256 private _tokenIdCounter;

    mapping(address => bytes32) public _hashToTokenId;
    mapping(address => bool) private _isVerified;
    mapping(address => bool) private _isAlive;
    mapping(address => uint256) private _lastVerification;

    address public immutable owner;

    event Activity(
        address indexed _user,
        uint256 indexed _tokenId,
        string indexed _activity
    );
    event VerificationRequest(address indexed _user, uint256 indexed _tokenId);

    constructor() ERC721("IdentityVerification", "IDV") {
        owner = msg.sender;
    }

    function verifyIdentity(
        string memory tokenURI,
        string memory name,
        string memory idType,
        string memory idNumber,
        uint256 dateOfBirth
    ) external {
        require(!_isVerified[msg.sender], "Identity already verified");
        uint256 newTokenId = _getNextTokenId();
        _mint(msg.sender, newTokenId);
        _tokenIdCounter++;
        string memory identityInfo = string(
            abi.encodePacked(name, ",", idType, ",", idNumber, ",", dateOfBirth)
        );
        bytes32 hash = keccak256(abi.encodePacked(identityInfo));
        _setTokenURI(newTokenId, tokenURI);
        _hashToTokenId[msg.sender] = hash;
        _isVerified[msg.sender] = true;
    }

    function isIdentityVerified(address person) external view returns (bool) {
        return _isVerified[person];
    }

    function _getNextTokenId() private view returns (uint256) {
        return _tokenIdCounter + 1;
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        require(to == owner, "NFT is not transferable");
        super.transferFrom(from, to, tokenId);
    }

    function activity(uint256 _tokenId, string calldata _activity) public {
        require(ownerOf(_tokenId) == msg.sender, "You do not own this token");
        emit Activity(msg.sender, _tokenId, _activity);
    }

    function isApprovedForAll(
        address owner,
        address operator
    ) public view override returns (bool) {
        require(false, "Approval is required to perform this action");
    }

    function requestVerification(uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender, "You do not own this token");

        // Check if 30 days have elapsed since the last verification request
        uint256 lastVerificationTime = _lastVerification[msg.sender];
        require(
            block.timestamp >= lastVerificationTime + 30 days,
            "30 days have not elapsed since last verification"
        );

        // Set the last verification time to now
        _lastVerification[msg.sender] = block.timestamp;

        // Set _isAlive to false
        _isAlive[msg.sender] = false;

        // Emit VerificationRequest event
        emit VerificationRequest(msg.sender, _tokenId);
    }

    function verifyAlive(uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender, "You do not own this token");
        _isAlive[msg.sender] = true;
    }

    function isAlive(address person) external view returns (bool) {
        return _isAlive[person];
    }
}
