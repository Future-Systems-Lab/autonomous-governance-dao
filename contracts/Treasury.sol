// Rights Reserved, Unlicensed
pragma solidity ^0.8.20;
contract Treasury {
    address public admin;
    uint256 public spendingLimit = 100 ether;
    mapping(address => bool) public authorized;
    event AuthorizedAdded(address indexed account);
    event AuthorizedRemoved(address indexed account);
    event Disbursed(address indexed to, uint256 amount, string purpose);
    modifier onlyAuthorized() { require(authorized[msg.sender], "Not authorized"); _; }
    constructor() { admin = msg.sender; authorized[admin] = true; }
    function addAuthorized(address _a) external { require(msg.sender == admin); authorized[_a] = true; emit AuthorizedAdded(_a); }
    function removeAuthorized(address _a) external { require(msg.sender == admin); authorized[_a] = false; emit AuthorizedRemoved(_a); }
    function disburse(address payable _to, uint256 _amount, string memory _p) external onlyAuthorized {
        require(_amount <= spendingLimit, "Exceeds limit");
        (bool sent,) = _to.call{value:_amount}("");
        require(sent, "Transfer failed");
        emit Disbursed(_to, _amount, _p);
    }
    receive() external payable {}
}
