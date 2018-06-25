package com.web.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.ReviewDao;
import com.web.pojo.ReviewBean;
import com.web.service.ReviewService;

@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	private ReviewDao reviewdao;
	
	@Override
	public int insertReview(ReviewBean review) {
		// TODO Auto-generated method stub
		return this.reviewdao.insertReview(review);
	}

	@Override
	public int deleteReview(Integer id) {
		// TODO Auto-generated method stub
		return this.reviewdao.deleteReview(id);
	}

	@Override
	public int updateReview(ReviewBean review) {
		// TODO Auto-generated method stub
		return this.reviewdao.updateReview(review);
	}

	@Override
	public ReviewBean getReviewByid(int id) {
		// TODO Auto-generated method stub
		return this.reviewdao.getReviewByid(id);
	}

	@Override
	public List<ReviewBean> getAllReviewByusername(String username) {
		// TODO Auto-generated method stub
		return this.reviewdao.getAllReviewByusername(username);
	}

	@Override
	public List<ReviewBean> getAllReviewByproductionid(int Production_Id) {
		// TODO Auto-generated method stub
		return this.reviewdao.getAllReviewByproductionid(Production_Id);
	}

	@Override
	public int getReviewCount() {
		// TODO Auto-generated method stub
		return this.reviewdao.getReviewCount();
	}

}
