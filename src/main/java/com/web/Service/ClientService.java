package com.web.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.web.pojo.ClientBean;


public interface ClientService {
	/**
	 * 插入收货信息
	 * @param order 收货信息
	 * @return 
	 */
	public int insertClient(ClientBean order);
	/**
	 * 删除收货信息
	 * @param id 收货信息id
	 * @return
	 */
	public int deleteClient(Integer id);
	/**
	 * 更新订单状态
	 * @param order 收货信息
	 * @return
	 */
	public int updateClientStatus(ClientBean client);
	/**
	 * 更新收货信息
	 * @param order 收货信息
	 * @return
	 */
	public int updateClientInfo(ClientBean client);
	/**
	 * 根据收货信息id查询收货信息
	 * @param id 收货信息id
	 * @return
	 */
	public ClientBean getClientByid(Integer id);
	/**
	 * 根据收货信息id查询收货信息
	 * @param id 收货信息id
	 * @return
	 */
	public ClientBean getClientByClientid(String Client_id);
	/**
	 * 根据用户Id得到用户的所有收货信息
	 * @param user_id 用户id
	 * @return
	 */
	public List<ClientBean> getAllClient(Integer user_id);

}
