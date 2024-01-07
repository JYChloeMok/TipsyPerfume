package com.kh.ttp.productSale.pay.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.pay.model.vo.prepay.PayKakaoVO;

@Repository
public class PayKakaoDao {

	public int insertInfoMakeKakaoNoSeq(SqlSessionTemplate sqlSession, Map kakaoReadyMap) {
		int result = sqlSession.insert("payKakaoMapper.insertInfoMakeKakaoNoSeq", kakaoReadyMap);
		System.out.println("카카오레디 맵~~~~~~~~ : " + kakaoReadyMap);
		System.out.println("카카오레디 시행결과~~~~~~~~ : " + result);
		return result;
	}
	
	public String selectPayKakaoNoSeq(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("payKakaoMapper.selectPayKakaoNoSeq");
	}

	public int insertTid(SqlSessionTemplate sqlSession,  Map kakaoReadyMap) {
		return sqlSession.insert("payKakaoMapper.insertTid", kakaoReadyMap);
	}

	public PayKakaoVO selectPayKakao(SqlSessionTemplate sqlSession, String userEmail) {
		return sqlSession.selectOne("payKakaoMapper.selectPayKakao", userEmail);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	public void checkReadyInput(SqlSessionTemplate sqlSession, PayKakaoReady kakaoReady) {
		HashMap<String, Object> map = sqlSession.selectOne("payKakaoMapper.checkReadyInput", kakaoReady);
	}
	*/
	
	
}
