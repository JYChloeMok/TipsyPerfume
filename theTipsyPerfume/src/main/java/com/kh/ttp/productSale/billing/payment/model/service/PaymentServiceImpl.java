package com.kh.ttp.productSale.billing.payment.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {
	
	private final SqlSessionTemplate sqlSession;
	private final PaymentDao paymentDao;
	
	@Override
	public int insertPayment(PaymentVO payment) {
		return paymentDao.insertPayment(sqlSession, payment);
	}
	
	@Override
	public int updatePaymentStatus(PaymentVO payment) {
		return paymentDao.updatePaymentStatus(sqlSession, payment);
	}
	

}
