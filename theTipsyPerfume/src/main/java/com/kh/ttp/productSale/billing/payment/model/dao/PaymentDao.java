package com.kh.ttp.productSale.billing.payment.model.dao;

import org.apache.ibatis.annotations.Insert;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;

@Repository
public class PaymentDao {

	public int insertPayment(SqlSessionTemplate sqlSession, PaymentVO payment) {
		return sqlSession.insert("paymentMapper.insertPayment", payment);
	}

	public int updatePaymentStatus(SqlSessionTemplate sqlSession, PaymentVO payment) {
		return sqlSession.update("paymentMapper.updatePaymentStatus", payment);
	}
	

}
