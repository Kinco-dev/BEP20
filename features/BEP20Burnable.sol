pragma solidity 0.8.10;

import "./../utils/Context.sol";
import "./../BEP20.sol";

abstract contract BEP20Burnable is Context,BEP20{
    
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

}