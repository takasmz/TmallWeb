package com.web.pojo;

import java.io.Serializable;
import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

public class TypeBean implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	@NotEmpty
	private String name;
	@NotEmpty
	private String path;
	private List<ProductionBean> listproduction;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<ProductionBean> getListproduction() {
		return listproduction;
	}
	public void setListproduction(List<ProductionBean> listproduction) {
		this.listproduction = listproduction;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
}
