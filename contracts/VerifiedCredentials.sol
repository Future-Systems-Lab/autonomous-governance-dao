// Rights Reserved, Unlicensed
pragma solidity ^0.8.20;

contract VerifiedCredentials {
    address public admin;

    struct Credential {
        bytes32 credentialHash;
        uint256 issuedAt;
        bool revoked;
    }

    mapping(address => Credential) public credentials;
    event CredentialIssued(address indexed holder, bytes32 hash);
    event CredentialRevoked(address indexed holder);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function issueCredential(address _holder, bytes32 _credentialHash) external onlyAdmin {
        credentials[_holder] = Credential({
            credentialHash: _credentialHash,
            issuedAt: block.timestamp,
            revoked: false
        });
        emit CredentialIssued(_holder, _credentialHash);
    }

    function verifyCredential(address _holder, bytes32 _credentialHash) external view returns (bool) {
        Credential memory cred = credentials[_holder];
        return (cred.credentialHash == _credentialHash && !cred.revoked);
    }

    function revokeCredential(address _holder) external onlyAdmin {
        require(credentials[_holder].issuedAt != 0, "No credential found");
        credentials[_holder].revoked = true;
        emit CredentialRevoked(_holder);
    }
}
