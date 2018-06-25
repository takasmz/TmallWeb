package com.web.pojo;

import java.io.Serializable;

import com.web.Enums.StatusEnum;

public class OrderBean implements Serializable{
	/** 订单号 */
	private int id;
	/** 用户id */
	private int user_id;
	/** 收貨人id */
	private String client_id;
	/** 购买数量 */
	private int number;
	/** 商品id */
	private int production_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public int getProduction_id() {
		return production_id;
	}
	public void setProduction_id(int production_id) {
		this.production_id = production_id;
	}
	public String getClient_id() {
		return client_id;
	}
	public void setClient_id(String string) {
		this.client_id = string;
	}
}
