package com.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.web.pojo.ClientBean;

@Repository
public interface ClientDao {
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
	public int deleteClient(int id);
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
	public ClientBean getClientByid(int id);
	/**
	 * 根据收货信息id查询收货信息
	 * @param id 收货信息id
	 * @return
	 */
	public ClientBean getClientByClientid(@Param(value="client_id")String Client_id);
	/**
	 * 根据用户Id得到用户的所有收货信息
	 * @param user_id 用户id
	 * @return
	 */
	public List<ClientBean> getAllClient(int user_id);

}
