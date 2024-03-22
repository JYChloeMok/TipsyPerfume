package com.kh.ttp.productSale.billing.payment.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.billing.payment.model.vo.PortOnePaymentDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {
	
	private final SqlSessionTemplate sqlSession;
	private final PaymentDao paymentDao;
	
	String hostName = "api.iamport.kr";
	
	@Override
	public int insertPayment(PaymentDTO payment) {
		return paymentDao.insertPayment(sqlSession, payment);
	}
	
	@Override
	public int updatePaymentStatus(PaymentDTO payment) {
		return paymentDao.updatePaymentStatus(sqlSession, payment);
	}

	@Override
	public int canclePayment(PaymentDTO payment, int refuntAmount) {
		/* RestTemplate restTemplate = new RestTemplate();
		 * 이제 사용하지 않는다
		 * RestTemplate은 동기 / WebClient의 특징은 비동기처리 가능하고 속도빠름, Spring 5버전부터 이용가능
		 */
		PortOnePaymentDTO portOnePayment = new PortOnePaymentDTO(payment);
		portOnePayment.getWEB_CLIENT();
		
		// 결제 취소
		return 0;
	}
	
	public void preparePayment(PaymentDTO payment) {
		PortOnePaymentDTO portOnePayment = new PortOnePaymentDTO(payment);
		WebClient webClient = portOnePayment.getWEB_CLIENT();
		
		Integer resultCode = webClient.post()
				 .uri(hostName + "/payments/prepare")
				 .bodyValue(payment)
				 .retrieve(); // 반환값 받기
				 //.bodyToMono();
				 //.toBodilessEntity()
				 //.block();
		// 포트원 결제금액 사전등록 요구 명세
		// Body { "merchant_uid": "", "amount": 0, }
		// Header Content-Type application/json
	}
	

}
