package com.web.service;

import java.util.List;

import com.web.pojo.BuyCartBean;


public interface BuyCartService {
	/**
	 * 加入购物车
	 * @param buycart 商品
	 * @return 
	 */
	public int insertBuyCart(BuyCartBean buycart);
	/**
	 * 删除购物车单项
	 * @param id 购物车单项ID
	 * @return
	 */
	public int deleteBuyCart(Integer id);
	/**
	 * 更新购物车
	 * @param buycart 购物车单项
	 * @return
	 */
	public int updateBuyCart(BuyCartBean buycart);
	/**
	 * 通過購物車id查找購物車單項
	 * @return
	 */
	public BuyCartBean getBuyCartByid(int id);
	/**
	 * 通過商品id查找購物車單項
	 * @return
	 */
	public BuyCartBean getBuyCartByProductionid(int production_id);
	/**
	 * 根据用户Id得到用户的所有购物车单项
	 * @param user_id 用户id
	 * @return
	 */
	public List<BuyCartBean> getAllBuyCart(int user_id);
	/**
	 * 得到所有订单数
	 * @return 订单数
	 */
	public int getBuyCartCount(int user_id);
}
