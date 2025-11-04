// Rights Reserved, Unlicensed
pragma solidity ^0.8.20;
contract ComplianceLog {
    address public admin;
    event LogRecorded(bytes32 indexed dataHash, uint256 timestamp);
    modifier onlyAdmin() { require(msg.sender == admin, "Not authorized"); _; }
    constructor() { admin = msg.sender; }
    function recordEvent(bytes32 _dataHash) external onlyAdmin {
        emit LogRecorded(_dataHash, block.timestamp);
    }
}
