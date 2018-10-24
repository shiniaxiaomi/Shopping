package com.lyj.shopping;

import java.sql.Timestamp;

public class Product {

	int id;
	String name;
	String desrc;
	double normalPrice;
	double memberPrice;
	Timestamp pdate;
	int categoryId;
	String strCategoryId;
	
	
	public String getStrCategoryId() {
		return strCategoryId;
	}
	public void setStrCategoryId(String strCategoryId) {
		this.strCategoryId = strCategoryId;
	}
	public int getId() {
		return id;
		
		
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDesrc() {
		return desrc;
	}
	public void setDesrc(String desrc) {
		this.desrc = desrc;
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
	public Timestamp getPdate() {
		return pdate;
	}
	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	
}
