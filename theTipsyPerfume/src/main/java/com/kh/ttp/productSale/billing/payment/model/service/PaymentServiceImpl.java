package com.kh.ttp.productSale.billing.payment.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {
	
	private final SqlSessionTemplate sqlSession;
	private final PaymentDao paymentDao;
	
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
		WebClient webClient = WebClient.create();
		
		// 결제 취소
		return 0;
	}
	

}
