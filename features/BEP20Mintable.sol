pragma solidity 0.8.10;

import "./../utils/Ownable.sol";
import "./../utils/Context.sol";
import "./../BEP20.sol";

abstract contract BEP20Mintable is Context, Ownable, BEP20{
    constructor () { }

    /**
   * Increases the total supply
   *
   * Requirements
   *
   * - `msg.sender` must be the token owner
   */
  function mint(uint256 amount) public onlyOwner returns (bool) {
    _mint(_msgSender(), amount);
    return true;
  }


}