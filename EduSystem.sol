// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EduSystem {

    struct Learner {
        uint256 id;
        string fullName;
        bool isRegistered;
    }

    struct AcademicProgram {
        uint256 id;
        string title;
        bool available;
    }

    mapping(address => Learner) private learnerRecords;
    mapping(uint256 => AcademicProgram) private programRecords;

    mapping(address => mapping(uint256 => bool)) private enrollments;
    mapping(address => mapping(uint256 => uint8)) private scores;

    address private admin;

    event LearnerRegistered(address indexed learnerAddress, uint256 id, string fullName);
    event ProgramCreated(uint256 id, string title);
    event LearnerEnrolled(address indexed learnerAddress, uint256 programId);
    event ScoreAssigned(address indexed learnerAddress, uint256 programId, uint8 score);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function addLearner(address _learnerAddress, uint256 _id, string memory _fullName) public onlyAdmin {
        require(!learnerRecords[_learnerAddress].isRegistered, "Learner is already registered");

        learnerRecords[_learnerAddress] = Learner(_id, _fullName, true);

        emit LearnerRegistered(_learnerAddress, _id, _fullName);
    }

    function createProgram(uint256 _id, string memory _title) public onlyAdmin {
        require(!programRecords[_id].available, "Program already exists");

        programRecords[_id] = AcademicProgram(_id, _title, true);

        emit ProgramCreated(_id, _title);
    }

    function enroll(uint256 _programId) public {
        require(learnerRecords[msg.sender].isRegistered, "Learner is not registered");
        require(programRecords[_programId].available, "Program does not exist");
        require(!enrollments[msg.sender][_programId], "Learner is already enrolled in this program");

        enrollments[msg.sender][_programId] = true;

        emit LearnerEnrolled(msg.sender, _programId);
    }

    function setScore(address _learnerAddress, uint256 _programId, uint8 _score) public onlyAdmin {
        require(enrollments[_learnerAddress][_programId], "Learner is not enrolled with this program");
        require(_score <= 100, "Score must be between 0 and 100");

        scores[_learnerAddress][_programId] = _score;

        assert(scores[_learnerAddress][_programId] == _score);

        emit ScoreAssigned(_learnerAddress, _programId, _score);
    }

    function preventUnauthorized() public view {
        if (msg.sender != admin) {
            revert("Access denied: Admins only");
        }
    }
    function checkRegistration(address _learnerAddress) public view returns (bool) {
        return learnerRecords[_learnerAddress].isRegistered;
    }
    function checkEnrollment(address _learnerAddress, uint256 _programId) public view returns (bool) {
        return enrollments[_learnerAddress][_programId];
    }
    function getScore(address _learnerAddress, uint256 _programId) public view returns (uint8) {
        require(enrollments[_learnerAddress][_programId], "Learner is not enrolled with this program");
        return scores[_learnerAddress][_programId];
    }
}
