package com.web.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.Dao.EvaluationDao;
import com.web.POJO.EvaluationBean;
import com.web.Service.EvaluationService;

@Service
public class EvaluationServiceImpl implements EvaluationService{

	@Autowired
	private EvaluationDao evaluationdao;
	
	@Override
	public int insertEvalution(EvaluationBean Evalution) {
		// TODO Auto-generated method stub
		return this.evaluationdao.insertEvalution(Evalution);
	}

	@Override
	public int deleteEvalution(Integer id) {
		// TODO Auto-generated method stub
		return this.evaluationdao.deleteEvalution(id);
	}

	@Override
	public int updateEvalution(EvaluationBean Evalution) {
		// TODO Auto-generated method stub
		return this.evaluationdao.updateEvalution(Evalution);
	}
	
}
