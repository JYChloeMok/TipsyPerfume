package com.kh.ttp.community.review.model.service;

import java.util.ArrayList;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.community.common.model.vo.RecommendVO;
import com.kh.ttp.community.review.model.vo.ReviewFileVO;
import com.kh.ttp.community.review.model.vo.ReviewVO;

public interface ReviewService {
	
	public int countReviewList();
	public ArrayList<ReviewVO> seletcReviewList(PageInfo pi);
	
	public ReviewVO selectReviewDetail(int reviewNo);
	public ArrayList<String> selectReviewImage(int reviewNo);
	
	public String selectRecommend(RecommendVO rc);
	public int reviewRecommend(RecommendVO rc);
	public RecommendVO countRecommend(int contentNo);
	public int insertReview(ReviewVO re, ArrayList<ReviewFileVO> fileList);
	public int countFundingReview(int pdtNo);
	public ArrayList<ReviewVO> selectReviewFunding(PageInfo pi,int pdtNo);
}
