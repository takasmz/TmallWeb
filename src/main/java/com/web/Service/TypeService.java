package com.web.service;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.web.pojo.TypeBean;

public interface TypeService {
	/**
	 * 
	 * @param n
	 * @return
	 */
	public List<TypeBean> gettids(int n);
	/**
	 * 通过id得到类别
	 * @param tid 类别id
	 * @return
	 */
	public TypeBean gettypebyid(int tid);
	/**
	 * 得到所有类别
	 * @return
	 */
	public List<String> getalltype();
	/**
	 * 更新类别
	 * @param type
	 * @return
	 */
	public int updatetype(TypeBean type);
	/**
	 * 增加类别
	 * @param type
	 * @return
	 */
	public int inserttype(TypeBean type);
	/**
	 * 删除类别
	 * @param oid
	 * @return
	 */
	public int deleteType(int oid);
}
