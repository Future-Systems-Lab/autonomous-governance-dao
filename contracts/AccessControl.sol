// Rights Reserved, Unlicensed
pragma solidity ^0.8.20;
contract AccessControl {
    mapping(address => bool) public verifiedPractitioners;
    mapping(address => bool) public verifiedAI;
    event PractitionerVerified(address practitioner);
    event AIVerified(address aiModule);
    event AccessGranted(address requester, bytes32 consentHash);
    event AccessDenied(address requester);
    address public admin;
    modifier onlyAdmin() { require(msg.sender == admin, "Not authorized"); _; }
    constructor() { admin = msg.sender; }
    function verifyPractitioner(address _p) external onlyAdmin { verifiedPractitioners[_p] = true; emit PractitionerVerified(_p); }
    function verifyAI(address _a) external onlyAdmin { verifiedAI[_a] = true; emit AIVerified(_a); }
    function verifyAccess(address _r, bytes32 _c) external {
        if (verifiedPractitioners[_r] || verifiedAI[_r]) emit AccessGranted(_r, _c);
        else emit AccessDenied(_r);
    }
}
