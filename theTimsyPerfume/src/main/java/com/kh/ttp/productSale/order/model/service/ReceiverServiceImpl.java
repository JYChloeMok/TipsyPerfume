package com.kh.ttp.productSale.order.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.order.model.dao.ReceiverDao;
import com.kh.ttp.productSale.order.model.vo.ReceiverVO;

@Service
public class ReceiverServiceImpl implements ReceiverService {
	
	@Autowired
	private ReceiverDao receiverDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int ajaxInsertReceiver(ReceiverVO receiver) {
		return receiverDao.ajaxInsertReceiver(sqlSession, receiver);
	}

}
