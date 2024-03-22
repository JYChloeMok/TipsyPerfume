package com.kh.ttp.productSale.billing.payment.model.service;

import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;

public interface PaymentService {
	
	// 결제 생성
	int insertPayment(PaymentDTO payment);
	
	// 결제 상태 업데이트
	int updatePaymentStatus(PaymentDTO payment);
	
	// 결제 취소(환불)
	/**
	 * 결제 취소(환불)
	 * @param payment : 결제 정보가 담긴 객체
	 * @param refuntAmount : 결제 취소/환불할 금액, 0이하 입력 시 전체 환불
	 * @return : 성공시 1, 실패시 0
	 */
	int canclePayment(PaymentDTO payment, int refundAmount);
}
