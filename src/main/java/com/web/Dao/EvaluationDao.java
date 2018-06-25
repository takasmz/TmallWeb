package com.web.Dao;

import org.springframework.stereotype.Repository;

import com.web.POJO.EvaluationBean;

@Repository
public interface EvaluationDao {
	/**
	 * 插入评论
	 * @param Evalution 评论
	 * @return 
	 */
	public int insertEvalution(EvaluationBean Evalution);
	/**
	 * 删除评论
	 * @param id 评论id
	 * @return
	 */
	public int deleteEvalution(Integer id);
	/**
	 * 更新评论
	 * @param Evalution 评论
	 * @return
	 */
	public int updateEvalution(EvaluationBean Evalution);
}
