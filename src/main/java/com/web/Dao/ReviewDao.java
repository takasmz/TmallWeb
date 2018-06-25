package com.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.web.pojo.ReviewBean;

@Repository
public interface ReviewDao {
	/**
	 * 插入评论
	 * @param review 评论
	 * @return 
	 */
	public int insertReview(ReviewBean review);
	/**
	 * 删除评论
	 * @param id 评论id
	 * @return
	 */
	public int deleteReview(Integer id);
	/**
	 * 更新评论
	 * @param review 评论
	 * @return
	 */
	public int updateReview(ReviewBean review);
	/**
	 * 根据评论id查询评论
	 * @param id 评论id
	 * @return
	 */
	public ReviewBean getReviewByid(int id);
	/**
	 * 根据用户名称得到用户的所有评论
	 * @param user_id 用户id
	 * @return
	 */
	public List<ReviewBean> getAllReviewByusername(String username);
	/**
	 * 根据商品id得到商品的所有评论
	 * @param Client_Id 
	 * @return
	 */
	public List<ReviewBean> getAllReviewByproductionid(int Production_Id);
	/**
	 * 得到所有评论数
	 * @return 评论数
	 */
	public int getReviewCount();
}
