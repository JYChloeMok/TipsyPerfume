package com.kh.ttp.productSale.billing.payment.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements paymentService {
	
	private final SqlSessionTemplate sqlSession;
	private final PaymentDao paymentDao;
	

}
