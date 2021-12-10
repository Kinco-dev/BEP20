pragma solidity 0.8.10;


contract Context {

  constructor () { }

  function _msgSender() internal view returns (address) {
    return msg.sender;
  }

  function _msgData() internal view returns (bytes memory) {
    this; // to delete the warning with pure
    return msg.data;
  }
}