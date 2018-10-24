package com.lyj.shopping;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	
	boolean isMember=false;

	public boolean isMember() {
		return isMember;
	}

	public void setMember(boolean isMember) {
		this.isMember = isMember;
	}

	private List<CartItem> items=new ArrayList<CartItem>();
	
	public List<CartItem> getItems(){
		return items;
	}
	
	public void setItems(List<CartItem> items){
		this.items=items;
	}
	
	public void add(CartItem item){
		items.add(item);
	}
	

	public double getMemberTotalPrice(){
		double totalPrice=0;
		for(int i=0;i<items.size();i++){
			CartItem ci=items.get(i);
			totalPrice+=ci.getMemberTotalPrice();
		}
		return totalPrice;
	}
	
	public double getNormalTotalPrice(){
		double totalPrice=0;
		for(int i=0;i<items.size();i++){
			CartItem ci=items.get(i);
			totalPrice+=ci.getNormalTotalPrice();
		}
		return totalPrice;
	}
	
}
