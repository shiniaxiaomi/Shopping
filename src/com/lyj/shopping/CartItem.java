package com.lyj.shopping;

public class CartItem {

	int productId;
	String peoductName;
	int count;
	double normalPrice;
	double memberPrice;
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
	public double getNormalPrice() {
		return normalPrice;
	}
	public void setNormalPrice(double normalPrice) {
		this.normalPrice = normalPrice;
	}
	public double getMemberPrice() {
		return memberPrice;
	}
	public void setMemberPrice(double memberPrice) {
		this.memberPrice = memberPrice;
	}
	
	public String getPeoductName() {
		return peoductName;
	}
	public void setPeoductName(String peoductName) {
		this.peoductName = peoductName;
	}

	public double getMemberTotalPrice(){
		return memberPrice*count;
	}
	
	public double getNormalTotalPrice(){
		return normalPrice*count;
	}
	
	
}
