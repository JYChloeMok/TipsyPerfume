package com.kh.ttp.productSale.billing.payment.model.service;

import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;

public interface PaymentService {
	
	// 결제 생성
	int insertPayment(PaymentVO payment);
	
	// 결제 상태 업데이트
	int updatePaymentStatus(PaymentVO payment);

}
