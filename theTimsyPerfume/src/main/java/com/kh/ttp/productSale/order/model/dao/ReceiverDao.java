package com.kh.ttp.productSale.order.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.order.model.vo.ReceiverVO;


@Repository
public class ReceiverDao {
	
	
	public int updateEmail(SqlSessionTemplate sqlSession, ReceiverVO receiver) {
		return sqlSession.update("receiverMapper.updateEmail", receiver);
	}
	
	public int ajaxInsertReceiver(SqlSessionTemplate sqlSession, ReceiverVO receiver) {
		return sqlSession.insert("receiverMapper.insertReceiver", receiver);
	}

	public int insertReceiver(SqlSessionTemplate sqlSession, ReceiverVO r) {
		return sqlSession.insert("receiverMapper.insertReceiverf",r);
	}

	public int selectReceiverNo(SqlSessionTemplate sqlSession, ReceiverVO r) {
		return sqlSession.selectOne("receiverMapper.selectReceiverNo",r);
		
	}


}
