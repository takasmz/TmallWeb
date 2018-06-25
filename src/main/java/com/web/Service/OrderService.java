package com.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.web.pojo.OrderBean;


public interface OrderService {
	/**
	 * 插入订单
	 * @param order 订单
	 * @return 
	 */
	public int insertOrder(OrderBean order);
	/**
	 * 删除订单
	 * @param id 订单id
	 * @return
	 */
	public int deleteOrder(Integer id);
	/**
	 * 更新订单
	 * @param order 订单
	 * @return
	 */
	public int updateOrder(OrderBean order);
	/**
	 * 根据订单id查询订单
	 * @param id 订单id
	 * @return
	 */
	public OrderBean getOrderByid(Integer id);
	/**
	 * 根据用户Id得到用户的所以订单
	 * @param user_id 用户id
	 * @return
	 */
	public List<OrderBean> getAllOrderByuserid(Integer user_id);
	/**
	 * 根据Client_Id得到用户的所有订单
	 * @param Client_Id 
	 * @return
	 */
	public List<OrderBean> getAllOrderByclientid(String Client_Id);
	/**
	 * 得到所有订单数
	 * @return 订单数
	 */
	public int getOrderCount();
}
