package com.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.web.pojo.OrderBean;

//事务，前端负载均衡，大数据十万，百万查询，


@Repository
public interface OrderDao {
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
	public OrderBean getOrderByid(int id);
	/**
	 * 根据用户Id得到用户的所有订单
	 * @param user_id 用户id
	 * @return
	 */
	public List<OrderBean> getAllOrderByuserid(int user_id);
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
