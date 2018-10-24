package com.lyj.shopping;

import java.util.ArrayList;
import java.util.List;

import com.lyj.shopping.Dao.CategoryDao;

public class Category {
	private int id;
	private String name;
	private String desrc;
	private int pid;
	private boolean leaf;
	private int grade;
	private int productNum;
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
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
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}

	public static boolean add(Category c){
		return CategoryDao.save(c);
	}
	
	public static boolean delete(int id){
		return CategoryDao.delete(id);
	}
	
	public static boolean addChildCategory(Category c){
		return CategoryDao.addChildCategory(c);
	}
	
	public static boolean addTopCategory(String name,String descr){//添加最根上的节点
		Category c=new Category();
		c.setId(-1); 
		c.setName(name);
		c.setDesrc(descr);
		c.setPid(0);
		c.setGrade(1);
		return CategoryDao.save(c);
	}
	
	public static List<Category> getCategories(){
		List<Category> categories=new ArrayList<Category>();	
		CategoryDao.getCategories(categories, 0);
		return categories;
	}
	
	public static boolean modify(Category c){
		
		return CategoryDao.modify(c);
	}
	
	public static Category loadById(int id){
		Category c=CategoryDao.loadById(id);		
		return c;
		
	}
	
}
