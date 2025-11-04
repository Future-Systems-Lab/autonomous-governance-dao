// Rights Reserved, Unlicensed
pragma solidity ^0.8.20;
contract WellnessToken {
    string public name = "HypnoNeuroToken";
    string public symbol = "HNT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    address public admin;
    event RewardIssued(address indexed user, uint256 amount, string activity);
    modifier onlyAdmin() { require(msg.sender == admin, "Not authorized"); _; }
    constructor() { admin = msg.sender; }
    function issueReward(address _user, string memory _activity) external onlyAdmin {
        uint256 rewardAmount = 1 * 10**uint256(decimals);
        balanceOf[_user] += rewardAmount;
        totalSupply += rewardAmount;
        emit RewardIssued(_user, rewardAmount, _activity);
    }
    function getBalance(address _user) external view returns (uint256) { return balanceOf[_user]; }
}
