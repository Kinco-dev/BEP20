pragma solidity 0.8.10;

import "./IBEP20.sol";
import "./utils/Ownable.sol";
import "./utils/Context.sol";



contract BEP20 is Context, IBEP20, Ownable {

  mapping (address => uint256) internal _balances;

  mapping (address => mapping (address => uint256)) internal _allowances;

  uint256 internal _totalSupply;
  uint8 internal _decimals;
  string internal _symbol;
  string internal _name;

  constructor(string memory name_ , string memory symbol_, uint8 decimals_, uint256 totalSupply_) {
    _name = name_;
    _symbol = symbol_;
    _decimals = decimals_;
    _totalSupply = totalSupply_;
    _balances[msg.sender] = totalSupply_;

    emit Transfer(address(0), msg.sender, _totalSupply);
  }


  function getOwner() external view returns (address) {
    return owner();
  }


  function decimals() external view returns (uint8) {
    return _decimals;
  }


  function symbol() external view returns (string memory) {
    return _symbol;
  }


  function name() external view returns (string memory) {
    return _name;
  }


  function totalSupply() external view returns (uint256) {
    return _totalSupply;
  }


  function balanceOf(address account) external view returns (uint256) {
    return _balances[account];
  }


  function transfer(address recipient, uint256 amount) public virtual returns (bool) {
    _transfer(_msgSender(), recipient, amount);
    return true;
  }
  
    /**
   * Requirements:
   *
   * - `sender` cannot be the zero address.
   * - `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   */
  function _transfer(address sender, address recipient, uint256 amount) internal {
    require(sender != address(0), "BEP20: transfer from the zero address");
    require(recipient != address(0), "BEP20: transfer to the zero address");    
    require(amount <= _balances[sender], "BEP20: not enought tokens in the sender's balance");

    _beforeTokenTransfer(sender,recipient,amount);

    _balances[sender] = _balances[sender] - amount;
    _balances[recipient] = _balances[recipient] + amount;
    emit Transfer(sender, recipient, amount);
  }

  function allowance(address owner, address spender) external view returns (uint256) {
    return _allowances[owner][spender];
  }

  /**
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function approve(address spender, uint256 amount) external returns (bool) {
    _approve(_msgSender(), spender, amount);
    return true;
  }

    /**
   *  Sets `amount` as the allowance of `spender` over the `owner`s tokens.
   *
   * This is internal function is equivalent to `approve`, and can be used to
   * e.g. set automatic allowances for certain DEXs

   * Requirements:
   *
   * - `owner` cannot be the zero address.
   * - `spender` cannot be the zero address.
   */
  function _approve(address owner, address spender, uint256 amount) internal {
    require(owner != address(0), "BEP20: approve from the zero address");
    require(spender != address(0), "BEP20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }

  /**
   * Requirements:
   * - `sender` and `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   * - the caller must have allowance for `sender`'s tokens of at least
   * `amount`.
   */
  function transferFrom(address sender, address recipient, uint256 amount) public virtual returns (bool) {
    _transfer(sender, recipient, amount);
    _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
    return true;
  }

  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
    return true;
  }

  /**
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   * - `spender` must have allowance for the caller of at least
   * `subtractedValue`.
   */
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender] - subtractedValue);
    return true;
  }
  
  // BURNABLE // TODO delete or not
  
    /**
   * Destroys `amount` tokens from `account`, reducing the
   * total supply.
   *
   * Requirements
   *
   * - `account` cannot be the zero address.
   * - `account` must have at least `amount` tokens.
   */
  function _burn(address account, uint256 amount) internal {
    require(account != address(0), "BEP20: burn from the zero address");

    _beforeTokenTransfer(account,address(0),amount);

    _balances[account] = _balances[account] - amount;
    _totalSupply = _totalSupply - amount;
    emit Transfer(account, address(0), amount);
  }

  /**
   * Destroys `amount` tokens from `account`.`amount` is then deducted
   * from the caller's allowance.
   *
   */
  function _burnFrom(address account, uint256 amount) internal {
    _burn(account, amount);
    _approve(account, _msgSender(), _allowances[account][_msgSender()] - amount);
  }

// MINTABLE // TODO Delete or not

  function _mint(address account, uint256 amount) internal {
    require(account != address(0), "BEP20: mint to the zero address");

    _beforeTokenTransfer(address(0),account,amount);

    _totalSupply = _totalSupply + amount;
    _balances[account] = _balances[account] + amount;
    emit Transfer(address(0), account, amount);
  }
  
      /**
     * Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     */
    function _beforeTokenTransfer(address from,address to, uint256 amount) internal virtual {}
}

