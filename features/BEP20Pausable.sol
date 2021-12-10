pragma solidity 0.8.10;

import "./../BEP20.sol";
import "./../utils/Pausable.sol";
import "./../utils/Ownable.sol";

abstract contract BEP20Pausable is Ownable, BEP20, Pausable {
    
        function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused(), "BEP20Pausable: token transfer while paused");
        }
    
        function unpause() public onlyOwner virtual  {
            _unpause();
        }
        function pause() public onlyOwner virtual  {
            _pause();
        }
}