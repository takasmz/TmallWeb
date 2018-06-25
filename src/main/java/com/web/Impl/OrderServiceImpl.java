package com.web.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.OrderDao;
import com.web.pojo.OrderBean;
import com.web.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderDao orderdao;

	@Override
	public int insertOrder(OrderBean order) {
		// TODO Auto-generated method stub
		return this.orderdao.insertOrder(order);
	}

	@Override
	public int deleteOrder(Integer id) {
		// TODO Auto-generated method stub
		return this.orderdao.deleteOrder(id);
	}

	@Override
	public int updateOrder(OrderBean order) {
		// TODO Auto-generated method stub
		return this.orderdao.updateOrder(order);
	}

	@Override
	public OrderBean getOrderByid(Integer id) {
		// TODO Auto-generated method stub
		return this.orderdao.getOrderByid(id);
	}

	@Override
	public List<OrderBean> getAllOrderByuserid(Integer user_id) {
		// TODO Auto-generated method stub
		return this.orderdao.getAllOrderByuserid(user_id);
	}

	@Override
	public int getOrderCount() {
		// TODO Auto-generated method stub
		return this.orderdao.getOrderCount();
	}

	@Override
	public List<OrderBean> getAllOrderByclientid(String Client_Id) {
		// TODO Auto-generated method stub
		return this.orderdao.getAllOrderByclientid(Client_Id);
	}

}
