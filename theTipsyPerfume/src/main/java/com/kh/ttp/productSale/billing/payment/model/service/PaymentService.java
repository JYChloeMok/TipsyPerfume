package com.kh.ttp.productSale.billing.payment.model.service;

import com.kh.ttp.common.model.vo.CodeMessage;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;

public interface PaymentService {
	
	// 결제 준비 API
	/**
	 * 포트원 결제금액 사전 등록 메소드<br>
	 * 최종 주문 금액, merchantUid를 이용해 포트원 결제금액 사전 등록 API를 호출<br>
	 * @param payment : PaymentDTO객체, orderAmount(최종 주문 금액), merchantUid(주문 번호) 값이 필요
	 * @return : CodeMessage<br>
	 * 결과 코드(int)와 결과 메세지(String)이 있음
	 */
	CodeMessage preparePortOnePayment(PaymentDTO payment);
	
	// 결제 취소(환불) API 및 통신 결과 DB저장
	/**
	 * 결제 환불 프로세스<br>
	 * 포트원 API에 결제 취소 요청을 보낸 후 결과를 DB에 저장한다<br>
	 * API결제가 취소되었다면 payment테이블의 status도 업데이트
	 * 이후 //////////////// PaymentDTO 반환 ////////CodeMessage객체의 code, message필드에 포트원 API 통신 response를,<br>
	 * dmlResult필드에 DB저장 성공 여부(성공 시 1, 실패 시 0)를 담는다
	 * @param payment : 결제 정보가 담긴 객체
	 * @param refundAmount : 결제 취소할 금액, 0이하 입력 시 전체 환불
	 * @return : CodeMessage
	 */
	PaymentDTO proceedRefund(PaymentDTO payment, int refundAmount);
	
	// 결제 생성
	int insertPayment(PaymentDTO payment);
	
	// 결제 상태 업데이트
	int updatePaymentStatus(PaymentDTO payment);


	
	
	
	
	
}












