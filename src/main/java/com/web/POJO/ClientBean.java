package com.web.pojo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;

import com.web.Enums.StatusEnum;

public class ClientBean implements Serializable{
	/** id */ 
	private int id;
	/** 订单号 */
	private String client_id;
	/** 用户号 */
	private int user_id;
	/** 商品号 */
	private int production_id;
	/** 商品状态 */
	private StatusEnum status;
	/** 购买时间 */
	private String time;
	/** 总金额 */
	private double payment;
	
	/** 收货人姓名 */
	@NotEmpty(message="姓名不能为空")
	private String peoplename;
	/** 手机 */
	@NotNull(message="手机不能为空")
	private String phone;
	/** 地址 */
	@NotEmpty(message="地址不能为空")
	private String address;
	/** 邮编 */
	@NotEmpty(message="邮编不能为空")
	private String postal;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPeoplename() {
		return peoplename;
	}
	public void setPeoplename(String peoplename) {
		this.peoplename = peoplename;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String adress) {
		this.address = adress;
	}
	public String getPostal() {
		return postal;
	}
	public void setPostal(String postal) {
		this.postal = postal;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
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
	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}
	public StatusEnum getStatus() {
		return status;
	}
	public void setStatus(StatusEnum status) {
		this.status = status;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public double getPayment() {
		return payment;
	}
	public void setPayment(double payment) {
		this.payment = payment;
	}


	
}
