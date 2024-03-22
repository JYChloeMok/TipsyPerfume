package com.kh.ttp.productSale.billing.payment.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;

@Repository
public class PaymentDao {

	public int insertPayment(SqlSessionTemplate sqlSession, PaymentDTO payment) {
		return sqlSession.insert("paymentMapper.insertPayment", payment);
	}

	public int updatePaymentStatus(SqlSessionTemplate sqlSession, PaymentDTO payment) {
		return sqlSession.update("paymentMapper.updatePaymentStatus", payment);
	}
	
}
