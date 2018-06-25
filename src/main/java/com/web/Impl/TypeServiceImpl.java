package com.web.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.TypeDao;
import com.web.pojo.TypeBean;
import com.web.service.TypeService;

@Service
public class TypeServiceImpl implements TypeService{

	@Autowired
	private TypeDao typedao;
	
	@Override
	public List<TypeBean> gettids(int n) {
		// TODO Auto-generated method stub
		return this.typedao.gettids(n);
	}

	@Override
	public TypeBean gettypebyid(int tid) {
		// TODO Auto-generated method stub
		return this.typedao.gettypebyid(tid);
	}

	@Override
	public List<String> getalltype() {
		// TODO Auto-generated method stub
		return this.typedao.getalltype();
	}

	@Override
	public int updatetype(TypeBean type) {
		// TODO Auto-generated method stub
		return this.typedao.updatetype(type);
	}

	@Override
	public int inserttype(TypeBean type) {
		// TODO Auto-generated method stub
		return this.typedao.inserttype(type);
	}

	@Override
	public int deleteType(int oid) {
		// TODO Auto-generated method stub
		return this.typedao.deleteType(oid);
	}

}
