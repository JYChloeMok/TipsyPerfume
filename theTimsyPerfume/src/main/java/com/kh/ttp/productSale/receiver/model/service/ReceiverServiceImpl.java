package com.kh.ttp.productSale.receiver.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.receiver.model.dao.ReceiverDao;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReceiverServiceImpl implements ReceiverService {
	
	private final ReceiverDao receiverDao;
	
	private final SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<ReceiverVO> selectReceiver(int userNo) {
		return receiverDao.selectReceiver(sqlSession, userNo);
	}
	
	@Override
	public int ajaxInsertReceiver(ReceiverVO receiver) {
		return receiverDao.ajaxInsertReceiver(sqlSession, receiver);
	}



}
