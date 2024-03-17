package com.kh.ttp.community.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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

	
	/**
	 * 상품 번호(pdtNo), rowNum(rowNum)을 이용해<br>
	 * pdtNo번 상품의 최신 작성순 리뷰 탑 rowNum개를 조회하는 메소드<br>
	 * rowNum은 최대 10까지 가능
	 * @param pMap : 상품번호(pdtNo), 로우넘버(rowNum)
	 * @return
	 * ResponseEntity반환, 리뷰 정보가 담긴 리스트가 들어있음
	 */
	ArrayList<ReviewVO> selectRecentReviewWithRownum(HashMap<String, Integer> pMap);


}
