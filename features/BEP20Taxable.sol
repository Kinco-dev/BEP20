pragma solidity 0.8.10;

import "./../utils/Context.sol";
import "./../BEP20.sol";
import "./../utils/Ownable.sol";

abstract contract BEP20Taxable is Context,Ownable, BEP20{
    
    mapping(address=>bool) areExcludedFromFees;
    uint8 public burnFee;
    uint8 public ownerFee;
    
    constructor () {
        areExcludedFromFees[address(this)] = true;
        areExcludedFromFees[owner()] = true;
        burnFee = 5; // TODO change fees
        ownerFee = 5;
    }
    function setBurnFee(uint8 _burnFee) onlyOwner public{
        burnFee = _burnFee;
    }
    function setOwnerFee(uint8 _ownerFee) onlyOwner public{
        ownerFee = _ownerFee;
    }

    function excludeFromFee(address excludedAddress) onlyOwner public {
        areExcludedFromFees[excludedAddress] = true;
    }
        
    function includeFromFee(address includedAddress) onlyOwner public {
        areExcludedFromFees[includedAddress] = false;
    }

    function isExcludedFromFee(address account) public view returns (bool) {
        return areExcludedFromFees[account];
    }
    
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transferWithFees(_msgSender(),recipient,amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transferWithFees(sender,recipient,amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
        return true;
    }
    function _transferWithFees(address sender, address recipient, uint256 amount) private {
        uint totalAmount = amount;
      if(!areExcludedFromFees[sender] && !areExcludedFromFees[recipient]) {
          // burn fee 
          uint burnAmount = amount * burnFee / 100;
          _burn(sender, burnAmount);
          totalAmount -= burnAmount; 
          // owner fee 
          uint ownerAmount =  amount * ownerFee / 100;
          _transfer(sender,owner(),ownerAmount);
          totalAmount -= ownerAmount; 
      }
      _transfer(sender, recipient, totalAmount);
    }
}