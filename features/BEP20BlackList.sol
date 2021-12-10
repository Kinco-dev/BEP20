pragma solidity 0.8.10;

import "./../utils/Ownable.sol";
import "./../BEP20.sol";

 abstract contract BEP20BlackList is Ownable, BEP20 {

    event BlackList(address indexed account, bool isBlacklisted);

    mapping(address=>bool) areBlacklisted;

    function blackList(address _account ) public onlyOwner {
        require(!areBlacklisted[_account], "this address already blacklisted");
        areBlacklisted[_account] = true;
        emit BlackList(_account,true);
    }
    
    function removeFromBlacklist(address _account) public onlyOwner {
        require(areBlacklisted[_account], "this address already whitelisted");
        areBlacklisted[_account] = false;
        emit BlackList(_account,false);
    }
    
        function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        require(!areBlacklisted[to], "Recipient is backlisted");
        require(!areBlacklisted[from], "Sender is backlisted");


    }
    

}