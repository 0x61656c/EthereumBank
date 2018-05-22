pragma solidity ^0.4.2;

contract PayableSmartContract{

	address client;
	bool public _switch = false;

	//events record data on blockchain. used for recording transaction and the like
	event UpdateStatus(string _msg, uint _amount);

	function Custodian(){
		client = msg.sender;
	} 

	modifier ifClient(){
		if(msg.sender != client){
			throw;
		}
		else{
			_;
		}
	}

	function depositFunds() payable{
		UpdateStatus('User has deposited:', msg.value);
	}	

	function getFunds() constant returns(uint){
		return this.balance;
	}

	function withdrawFunds(uint amount){
		if(client.send(amount)){
			UpdateStatus('User has withdrawn:', msg.value);
			_switch = true;}
		else{
			_switch = false;}
	}
}