package com.lyj.shopping;

import java.util.Date;
import java.util.List;

import com.lyj.shopping.Dao.ProductDao;
import com.lyj.shopping.Dao.ProductMySQLDao;

public class ProductMgr {
	ProductDao productDao=null;
	
	private static ProductMgr pm=null;
	private ProductMgr(){
		
	}
	static {	
		if(pm==null){
			pm=new ProductMgr();
			pm.setProductDao(new ProductMySQLDao());
		}
	}

	public static ProductMgr getInstance(){
		return pm;
	}
	
	public ProductDao getProductDao() {
		return productDao;
	}

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public List<Product> getProducts(){
		return productDao.getProducts();

	}
	public int getProducts(List<Product> products,int pageNo,int pageSize){
		
		return productDao.getProducts(products, pageNo, pageSize);
	}
	
	public List<Product> getProducts(int pageNo,int pageSize){
		
		return productDao.getProducts(pageNo, pageSize);
	}
	
	public int findProducts(List<Product> products,int[] categoryId,
									  String keyWord,
									  double lowNormalPrice,
									  double highNormalPrice,
									  double lowMemberPrice,
									  double highMemberPrice,
									  Date startDate,
									  Date endDate,
									  int pageNo,
									  int pageSize){
		

		return productDao.findProducts(products,categoryId, keyWord, lowNormalPrice, highNormalPrice, lowMemberPrice, 
										highMemberPrice, startDate, endDate, pageNo, pageSize);
	}
	
	public List<Product> findProducts(String name){
		
		return null;
	}
	
	public boolean deleteProductByCategoryId(int categoryId){
		
		return false;
	}
	
	public boolean addProduct(Product p){
		
		return productDao.addProduct(p);
	}
	
	public boolean deleteProduct(int id){
		return productDao.deleteProduct(id);
		
	}
	
	public Product loadById(int id){
		
		return productDao.loadById(id);
	}
	
	public boolean modify(Product p) {
		return productDao.modify(p);
	}

	
	public List<Product> getLastProducts(int num){
		return productDao.getLastProducts(num);
		
	}
}
