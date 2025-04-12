//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Score {
    error NotTeacher();
    error ScoreOver();

    event SetScore(address indexed addr, uint data);
    //mapping(address => uint) public students;
    address teacher;
    address owner;


    constructor() {
        owner = msg.sender;
    }

    function setTeacher(address t) public {
        if (owner == msg.sender) {
            teacher = t;
        }

    }

    modifier onlyTeacher() {
        if(msg.sender != teacher) {
            revert NotTeacher();
        }
        _;
    }

    function setScore(address addr, uint data) external onlyTeacher {
        if (data > 100) {
            revert ScoreOver();
        }
        //students[addr] = data;
        emit SetScore(addr, data);
    }
}

interface IScore {
    function setScore(address addr, uint data) external;
}

contract Teacher {

    IScore score;

    constructor(address s) {
        score = IScore(s);
    }


    function callSetScore(address addr, uint data) public {
        score.setScore(addr, data);
    }
}