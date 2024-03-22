package com.kh.ttp.productSale.receiver.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.receiver.model.vo.ReceiverDTO;


@Repository
public class ReceiverDao {
	
	/**
	 * 현재 로그인한 유저가 보유한 주소록 목록 조회
	 * @param userNo : 유저 번호(PK)
	 * @return : 주소록 정보가 담긴 리스트
	 */
	public List<ReceiverDTO> selectReceiver(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectList("receiverMapper.selectReceiver", userNo);
	}
	
	public int updateEmail(SqlSessionTemplate sqlSession, ReceiverDTO receiver) {
		return sqlSession.update("receiverMapper.updateEmail", receiver);
	}
	
	public int ajaxInsertReceiver(SqlSessionTemplate sqlSession, ReceiverDTO receiver) {
		return sqlSession.insert("receiverMapper.insertReceiver", receiver);
	}

	public int insertReceiver(SqlSessionTemplate sqlSession, ReceiverDTO r) {
		return sqlSession.insert("receiverMapper.insertReceiverf",r);
	}

	public int selectReceiverNo(SqlSessionTemplate sqlSession, ReceiverDTO r) {
		return sqlSession.selectOne("receiverMapper.selectReceiverNo",r);
		
	}
	



}
