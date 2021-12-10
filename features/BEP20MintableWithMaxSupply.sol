pragma solidity 0.8.10;

import "./../utils/Ownable.sol";
import "./../utils/Context.sol";
import "./../BEP20.sol";

abstract contract BEP20MintableWithMaxSupply is Context, Ownable, BEP20{
    
    uint256 _maxSupply;
    
    constructor () { 
        _maxSupply = 5000 *10**18 + 500; // TODO change maxSupply
    }
    
    function maxSupply() public view virtual returns (uint256) {
        return _maxSupply;
    }


    /**
   * Increases the total supply
   *
   * Requirements
   *
   * - `msg.sender` must be the token owner
   */
  function mint(uint256 amount) public onlyOwner returns (bool) {
       require(_totalSupply + amount <= _maxSupply, "BEP20MintableWithMaxSupply: max supply exceeded");
       _mint(_msgSender(), amount);
       return true;
  }


}