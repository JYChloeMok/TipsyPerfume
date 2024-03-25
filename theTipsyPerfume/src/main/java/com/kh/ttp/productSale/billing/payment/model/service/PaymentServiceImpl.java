package com.kh.ttp.productSale.billing.payment.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.common.model.vo.CodeMessage;
import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.common.util.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {
	
	private final ProductSaleUtil productUtil;
	private final SqlSessionTemplate sqlSession;
	private final PaymentDao paymentDao;
	
	String hostName = "api.iamport.kr";
	
	
	
	@Override
	public CodeMessage preparePortOnePayment(PaymentDTO payment) {
		// DB에서 금액 확인
		/*
		int cal = 2000000;
		
		// 요청에 필요한 객체 생성
		PaymentDTO payment = PaymentDTO.builder()
									   .orderAmount(cal)
				  					   .merchantUid(productUtil.getSessionString(session, "merchantUid"))
				  					   .build();
		// 사전검증 요청
		//paymentService.preparePayment(payment);
		PortOnePaymentDTO portOnePayment = new PortOnePaymentDTO(payment);
		WebClient webClient = portOnePayment.getWEB_CLIENT();
		
		CodeMessage result = webClient.post()
				 .uri(hostName + "/payments/prepare")
				 .bodyValue(payment)
				 .retrieve(); // 반환값 받기
				 //.bodyToMono();
				 //.toBodilessEntity()
				 //.block();
		// 포트원 결제금액 사전등록 요구 명세
		// Body { "merchant_uid": "", "amount": 0, }
		// Header Content-Type application/json
		*/
		
		// merchant세션 비우기
		
		// 코드랑 에러 메세지 보내기
		return null;
	}
	
	
	
	@Override
	public PaymentDTO proceedRefund(PaymentDTO payment, int refundAmount) {
		/* RestTemplate restTemplate = new RestTemplate();
		 * 이제 사용하지 않는다
		 * RestTemplate은 동기 / WebClient의 특징은 비동기처리 가능하고 속도빠름, Spring 5버전부터 이용가능
		 */
		//PortOnePaymentDTO portOnePayment = new PortOnePaymentDTO(payment);
		//portOnePayment.getWEB_CLIENT();
		
		// 결제 취소 => code와 message필드 초기화
		
		// 취소 결과 DB저장 => 결과에 따라 dmlResult필드 초기화
		
		// 결과 반환
		return null;
	}
	
	
	
	@Override
	public int insertPayment(PaymentDTO payment) {
		return paymentDao.insertPayment(sqlSession, payment);
	}
	
	@Override
	public int updatePaymentStatus(PaymentDTO payment) {
		return paymentDao.updatePaymentStatus(sqlSession, payment);
	}

	

}
