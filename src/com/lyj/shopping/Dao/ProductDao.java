package com.lyj.shopping.Dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lyj.shopping.Product;

public interface ProductDao {

	
	public List<Product> getProducts();
	
	public List<Product> getProducts(int pageNo,int pageSize);
	
	public int getProducts(List<Product> products,int pageNo,int pageSize);
	
	public int findProducts(List<Product> products,int[] categoryId,
									  String keyWord,
									  double lowNormalPrice,
									  double highNormalPrice,
									  double lowMemberPrice,
									  double highMemberPrice,
									  Date startDate,
									  Date endDate,
									  int pageNo,
									  int pageSize);
	
	public List<Product> findProducts(String name);
	
	public boolean deleteProductByCategoryId(int categoryId);
	
	public boolean addProduct(Product p);

	public boolean deleteProduct(int id);
	
	public Product loadById(int id);
	
	public boolean  modify(Product p);

	public List<Product> getLastProducts(int num);
	
}
