package com.web.pojo;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class UserBean implements Serializable{
	private int id;
	
	@NotEmpty(message="用户名不能为空")
	@Size(min=2,max=15,message="用户名为2-15位")
	private String username;
	
	@NotEmpty(message="密码不能为空}")
	@Size(min=6,max=12,message="密码为6-12位")
	private String password;
	
	@NotEmpty(message="昵称不能为空")
	private String nickname;
	
	@NotEmpty(message="邮箱不能为空")
	@Email(message="邮箱格式错误")
	private String mail;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	
}
