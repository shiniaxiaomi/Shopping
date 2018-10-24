package com.lyj.shopping;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.lyj.shopping.Dao.OrderMySQLDao;
import com.lyj.shopping.util.DB;

public class OrderMgr {//懒汉式

	private static OrderMgr om=null;
	OrderMySQLDao dao=null;
	
	static {
		if(om==null){
			om=new OrderMgr();
			
			om.setDao(new OrderMySQLDao());
		}
	}
	
	private OrderMgr(){}
	
	public static OrderMgr getInstance(){
		return om;
	}
	
	

	public OrderMySQLDao getDao() {
		return dao;
	}

	public void setDao(OrderMySQLDao dao) {
		this.dao = dao;
	}
	
	public boolean saveOrder(SalesOrder so){
		return dao.saveOrder(so);
	}
	
	
	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		return dao.getOrders(orders,pageNo,pageSize);
	}
	
	public SalesOrder loadById(int id){
		return dao.loadById(id);
	}

	public List<SalesItem> getItems(SalesOrder salesOrder) {
		return dao.getSalesItems(salesOrder);
	}

	public void updateStates(SalesOrder salesOrder) {
		dao.updateStates(salesOrder);
		
	}

	
	
}
