// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract HelloWorld {
    string public greet = "Hello World";
    mapping(address => uint256) public myMap;

    function foo(uint256 _x) external pure returns (uint256) {
        if (_x < 10) {
            return 0;
        } else if (_x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function get(address _addr) external view returns (uint256) {
        return myMap[_addr];
    }

    function set(address _addr, uint256 _i) public {
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        delete myMap[_addr];
    }
}
