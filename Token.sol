pragma solidity 0.8.10;
// TODO rename the file

import "./BEP20.sol"; // TODO delete the unused imports
import "./features/BEP20Mintable.sol";
import "./features/BEP20MintableWithMaxSupply.sol";
import "./features/BEP20Burnable.sol";
import "./features/BEP20Pausable.sol";
import "./features/BEP20BlackList.sol";
import "./features/BEP20Taxable.sol";




contract Token is BEP20Taxable, BEP20MintableWithMaxSupply, BEP20Burnable, BEP20Pausable, BEP20BlackList { // TODO replace name of contract and inheritances
    
    constructor() BEP20("nameExample", "SYMBOL",18, 5000*10**18) { // TODO replace parameters
    }
    
    function _beforeTokenTransfer(address from,address to, uint256 amount // TODO change _beforeTokenTransfer calls
    ) internal override(BEP20, BEP20Pausable, BEP20BlackList) {
        BEP20._beforeTokenTransfer(from, to, amount);
        BEP20Pausable._beforeTokenTransfer(from, to, amount);
        BEP20BlackList._beforeTokenTransfer(from, to, amount);
    }

    function transfer(address recipient, uint256 amount) public override(BEP20, BEP20Taxable) returns (bool) {
        return BEP20Taxable.transfer(recipient,amount); //TODO delete function if taxable contract not used
    }
    function transferFrom(address sender, address recipient, uint256 amount) public override(BEP20, BEP20Taxable) returns (bool) {
        return BEP20Taxable.transferFrom(sender,recipient,amount);
    }
}
