// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract MyToken{
   string private _name = "My Token";
   string private _symbol = "MTK";
   address private _owner;
   uint8 private _decimals = 9;
   uint256 private _totalSupply = 1_000_000 * 10**_decimals;

                        //Mappings
   mapping(address => uint256) private _balanceOf;
   mapping(address => mapping(address => uint256)) private _allowances;

                        //Events
   event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
   );

   event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
   );

   constructor(){
      _owner = msg.sender;
      _balanceOf[msg.sender] = _totalSupply;
   }

   function name() public view returns(string memory){
       return _name;
   }
   function symbol() public view returns(string memory){
      return _symbol;
   }
   function owner() public view returns(address){
      return _owner;
   }
   function decimals() public view returns(uint8){
      return _decimals;
   }
   function totalSupply() public view returns(uint256){
      return _totalSupply;
   }
   
   function transfer(address _to, uint256 _amount) public{
        require(_balanceOf[msg.sender] >= _amount, "Not enough balance");
        _balanceOf[msg.sender] -= _amount;
        _balanceOf[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
   }
   function transferFrom(address _from, address _to, uint256 _amount) public{
       require(_balanceOf[msg.sender] >= _amount, "Not enough balance");
       require(_allowances[_from][_to] >= _amount, "Insufficient Allowance");
       _allowances[_from][_to] -= _amount;
       _balanceOf[_from] -= _amount;
       _balanceOf[_to] += _amount;
       emit Transfer(_from, _to, _amount);
   }
   function approve(address theSpender, uint256 _amount) public {
        _allowances[msg.sender][theSpender] = _amount;
        emit Approval(msg.sender, theSpender, _amount);
   }
   function balanceOf(address account)public view returns(uint256){
       return _balanceOf[account];
   }

   function allowance(address theOwner, address theSpender) public view returns(uint256){
        return _allowances[theOwner][theSpender];
   }
}
