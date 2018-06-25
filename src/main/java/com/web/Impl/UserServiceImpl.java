package com.web.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.dao.UserDao;
import com.web.pojo.UserBean;
import com.web.service.UserService;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userdao;
	
	
	public int insertUser(UserBean userbean) {
		// TODO Auto-generated method stub
		return this.userdao.insertUser(userbean);
	}

	
	public int updateUser(UserBean userbean) {
		// TODO Auto-generated method stub
		return this.userdao.updateUser(userbean);
	}

	
	public int deleteUser(Integer id) {
		// TODO Auto-generated method stub
		return this.userdao.deleteUser(id);
	}

	public UserBean getUserById(Integer id) {
		// TODO Auto-generated method stub
		return this.userdao.getUserById(id);
	}
	
	@Transactional
	public int hasMatchCount(String username, String password) {
		// TODO Auto-generated method stub
		int count = this.userdao.getMatchCount(username, password);
		System.out.println(count);
		return count;
	}
	
	
	public UserBean getUserByUsername(String Username) {
		// TODO Auto-generated method stub
		return this.userdao.getUserByUsername(Username);
	}
	
	public int getUserid(HttpSession session){
    	String username = (String) session.getAttribute("username");
		return this.userdao.getUserByUsername(username).getId();
    }


	@Override
	public List<UserBean> getalluser() {
		// TODO Auto-generated method stub
		return this.userdao.getalluser();
	}


	@Override
	public int getMatchCount(String uesrname, String password) {
		// TODO Auto-generated method stub
		return this.userdao.getMatchCount(uesrname, password);
	}
}
