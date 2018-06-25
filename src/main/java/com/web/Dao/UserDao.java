package com.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import com.web.pojo.UserBean;

@Repository
public interface UserDao {
	/**
	 * 插入用户
	 * @param userbean
	 * @return
	 */
	public int insertUser(UserBean userbean);
	/**
	 * 更新用户
	 * @param userbean
	 * @return
	 */
	public int updateUser(UserBean userbean);
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	public int deleteUser(Integer id);
	/**
	 * 通过得到用户
	 * @param id
	 * @return
	 */
	public UserBean getUserById(Integer id);
	/**
	 * 通过用户名称得到用户
	 * @param Username
	 * @return
	 */
	public UserBean getUserByUsername(String Username);
	/**
	 * 验证登陆
	 * @param uesrname
	 * @param password
	 * @return
	 */
	public int getMatchCount(@Param("username") String uesrname,@Param("password") String password);
	/**
	 * 得到所有用户
	 * @return
	 */
	public List<UserBean> getalluser();
}
