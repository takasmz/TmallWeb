package com.web.POJO;

public class EvaluationBean {
	/** 评论id */
	private int id;
	/** 评论内容 */
	private String content;
	/** 评论用户名 */
	private String username;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getProduction_id() {
		return production_id;
	}
	public void setProduction_id(int production_id) {
		this.production_id = production_id;
	}
	/** 商品id */
	private int production_id;
}
