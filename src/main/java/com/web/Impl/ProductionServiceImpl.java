package com.web.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.dao.BuyCartDao;
import com.web.dao.ClientDao;
import com.web.dao.OrderDao;
import com.web.dao.ProductionDao;
import com.web.pojo.BuyCartBean;
import com.web.pojo.ClientBean;
import com.web.pojo.OrderBean;
import com.web.pojo.ProductionBean;
import com.web.pojo.PropertyBean;
import com.web.pojo.TypeBean;
import com.web.service.ProductionService;

@Service
public class ProductionServiceImpl implements ProductionService{

	@Autowired
	private ProductionDao productiondao;
	
	@Autowired
	private OrderDao orderdao;
	
	@Autowired
	private ClientDao clientdao;
	
	@Autowired
	private BuyCartDao buycartdao;
	
	@Override
	public int insertProduction(ProductionBean Production) {
		// TODO Auto-generated method stub
		return this.productiondao.insertProduction(Production);
	}

	@Override
	public int deleteProduction(Integer id) {
		// TODO Auto-generated method stub
		return this.productiondao.deleteProduction(id);
	}

	@Override
	public int updateProduction(ProductionBean Production) {
		// TODO Auto-generated method stub
		return this.productiondao.updateProduction(Production);
	}

	@Override
	public ProductionBean getProductionByid(Integer id) {
		// TODO Auto-generated method stub
		return this.productiondao.getProductionByid(id);
	}

	@Override
	public List<ProductionBean> getProductionByname(String Production_Name) {
		// TODO Auto-generated method stub
		return this.productiondao.getProductionByname(Production_Name);
	}

	@Override
	public List<ProductionBean> getProductionBytid(int tid) {
		// TODO Auto-generated method stub
		return this.productiondao.getProductionBytid(tid);
	}

	@Override
	public List<ProductionBean> getProductionBybrands(String Production_brands) {
		// TODO Auto-generated method stub
		return this.productiondao.getProductionBybrands(Production_brands);
	}

	@Override
	public String getimgpathByid(Integer id) {
		// TODO Auto-generated method stub
		return this.productiondao.getimgpathByid(id);
	}


	@Override
	public List<PropertyBean> getPropertyBypid(int pid) {
		// TODO Auto-generated method stub
		return this.productiondao.getPropertyBypid(pid);
	}

	@Override
	public List<PropertyBean> getPropertyBytid(int tid) {
		// TODO Auto-generated method stub
		return this.productiondao.getPropertyBytid(tid);
	}

	

	@Override
	public List<ProductionBean> getallproduction() {
		// TODO Auto-generated method stub
		return this.productiondao.getallproduction();
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void buyproduction(List<ProductionBean> productionlist,ClientBean client,List<OrderBean> orders,List<BuyCartBean> buycartlist) {
		// TODO Auto-generated method stub
		for(ProductionBean production:productionlist)
			this.productiondao.updateStockAndSales(production.getId(),production.getStock(),production.getSales_volume());
		this.clientdao.insertClient(client);
		for(OrderBean order:orders)
			this.orderdao.insertOrder(order);
		if(buycartlist!=null)
			for(BuyCartBean buycart:buycartlist)
				buycartdao.deleteBuyCart(buycart.getId());
	}


}
