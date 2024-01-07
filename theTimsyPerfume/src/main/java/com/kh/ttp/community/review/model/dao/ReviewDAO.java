package com.kh.ttp.community.review.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.community.common.model.vo.RecommendVO;
import com.kh.ttp.community.review.model.vo.ReviewFileVO;
import com.kh.ttp.community.review.model.vo.ReviewVO;

@Repository
public class ReviewDAO {

	public int countReviewList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reviewMapper.countReviewList");
	}
	
	public ArrayList<ReviewVO> seletcReviewList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("reviewMapper.seletcReviewList", null, rowBounds);
	}

	public ReviewVO selectReviewDetail(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.selectOne("reviewMapper.selectReviewDetail", reviewNo);
	}
	
	public ArrayList<String> selectReviewImage(SqlSessionTemplate sqlSession, int reviewNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewImage", reviewNo);
	}

	public String selectRecommend(SqlSessionTemplate sqlSession, RecommendVO rc) {
		return sqlSession.selectOne("reviewMapper.selectRecommend", rc);
	}

	public int updateRecommend(SqlSessionTemplate sqlSession, RecommendVO rc) {
		return sqlSession.update("reviewMapper.updateRecommend", rc);
	}

	public int insertRecommend(SqlSessionTemplate sqlSession, RecommendVO rc) {
		return sqlSession.insert("reviewMapper.insertRecommend", rc);
	}

	public RecommendVO countRecommend(SqlSessionTemplate sqlSession, int contentNo) {
		return sqlSession.selectOne("reviewMapper.countRecommend", contentNo);
	}

	public int insertReview(SqlSessionTemplate sqlSession, ReviewVO re) {
		return sqlSession.insert("reviewMapper.insertReview", re);
	}

	public int insertReviewFile(SqlSessionTemplate sqlSession, ArrayList<ReviewFileVO> fileList) {
		return sqlSession.insert("reviewMapper.insertReviewFile", fileList);
	}

	public int countFundingReview(SqlSessionTemplate sqlSession, int pdtOptionNo) {
		return sqlSession.selectOne("reviewMapper.countFundingReview",pdtOptionNo);
	}

	public ArrayList<ReviewVO> selectReviewFunding(SqlSessionTemplate sqlSession, RowBounds rowBounds, int pdtNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewFunding",pdtNo,rowBounds);
	}


}
