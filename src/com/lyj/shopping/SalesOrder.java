package com.lyj.shopping;

import java.sql.Timestamp;
import java.util.List;

public class SalesOrder {

	int id;
	MyUser user;
	String addr;
	Timestamp oDate;
	int states;
	
	Cart cart;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public MyUser getUser() {
		return user;
	}
	public void setUser(MyUser user) {
		this.user = user;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Timestamp getoDate() {
		return oDate;
	}
	public void setoDate(Timestamp oDate) {
		this.oDate = oDate;
	}
	
	
	public Cart getCart() {
		return cart;
	}
	public void setCart(Cart cart) {
		this.cart = cart;
	}
	public int getStates() {
		return states;
	}
	public void setStates(int states) {
		this.states = states;
	}
	public boolean save(){
		return OrderMgr.getInstance().saveOrder(this);
	}
	
	public List<SalesItem> getItems(){
		return OrderMgr.getInstance().getItems(this);
	}
	
	public void updateStates(){
		OrderMgr.getInstance().updateStates(this);
	}
	
}
