package com.web.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.BuyCartDao;
import com.web.pojo.BuyCartBean;
import com.web.service.BuyCartService;

@Service
public class BuyCartServiceImpl implements BuyCartService{
	
	@Autowired
	private BuyCartDao buycartdao;
	
	@Override
	public int insertBuyCart(BuyCartBean buycart) {
		// TODO Auto-generated method stub
		return this.buycartdao.insertBuyCart(buycart);
	}

	@Override
	public int deleteBuyCart(Integer id) {
		// TODO Auto-generated method stub
		return this.buycartdao.deleteBuyCart(id);
	}

	@Override
	public int updateBuyCart(BuyCartBean buycart) {
		// TODO Auto-generated method stub
		return this.buycartdao.updateBuyCart(buycart);
	}

	@Override
	public List<BuyCartBean> getAllBuyCart(int user_id) {
		// TODO Auto-generated method stub
		return this.buycartdao.getAllBuyCart(user_id);
	}

	@Override
	public int getBuyCartCount(int user_id) {
		// TODO Auto-generated method stub
		return this.buycartdao.getBuyCartCount(user_id);
	}

	@Override
	public BuyCartBean getBuyCartByProductionid(int production_id) {
		// TODO Auto-generated method stub
		return this.buycartdao.getBuyCartByProductionid(production_id);
	}

	@Override
	public BuyCartBean getBuyCartByid(int id) {
		// TODO Auto-generated method stub
		return this.buycartdao.getBuyCartByid(id);
	}

}
