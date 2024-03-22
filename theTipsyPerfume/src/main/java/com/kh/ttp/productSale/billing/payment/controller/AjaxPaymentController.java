package com.kh.ttp.productSale.billing.payment.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.payment.model.service.PaymentServiceImpl;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.user.model.vo.UserDTO;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/payment")
@RequiredArgsConstructor
public class AjaxPaymentController {
	
	private final ProductSaleUtil productUtil;
	private final PaymentServiceImpl paymentService;
	
	
	/**
	 * 포트원 사전 검증 등록 메소드(OrderMain로딩과 동시에 실행됨)
	 * @param session : 현재 세션<br>
	 * 					정상 경로로 접근했을 시 주문 금액(orderAmount)과 주문고유번호(merchantUid)가 있음
	 * @return : 성공 시 sucess, 실패 시 fail문자열 반환
	 */
	@PostMapping("/prepare")
	public ResponseEntity preparePaymentAjax(HttpSession session) {

		String merchantUid = productUtil.getSessionString(session, "merchantUid");
		PaymentDTO payment = PaymentDTO.builder()
				  					   .merchantUid(productUtil.getSessionString(session, "merchantUid"))
				  					   .orderAmount(productUtil.getSessionInteger(session, "orderAmount"))
				  					   .build();
		paymentService.preparePayment(payment);
		return null;
	}

	/**
	 * 외부 결제API 요청 파라미터 준비 메소드
	 * @param session
	 * @return : ResponseEntity로 HashMap 반환<br />
	 * 키 buyer : 주문자(로그인 유저) 정보<br />
	 * 키 merchantUid : 주문 번호<br />
	 */
	@GetMapping("/payment/paymentParam")
	public ResponseEntity<Map<String, Object>> paymentParamAjax(HttpSession session) {
		// 주문자 정보
		UserDTO buyer = LoginUser.getLoginUser(session);

		// 주문번호
		// => 요청이 orderMain을 통하지 않는 경우 등 유효하지 않은 값
		// 	    유효하지 않을 경우 빈문자열 반환(JS에서 falsy값)
		String merchantUid = productUtil.getSessionString(session, "merchantUid");
		
		// 맵 객체 세팅
		HashMap<String, Object> result = new HashMap();
		result.put("buyer", buyer);
		result.put("merchantUid", merchantUid);
		// ResponseEntity 리턴
		return ResponseEntity.ok() // <Map<<String, Object>>추론
							 .headers(productUtil.makeApplicationJsonHeader())
							 .body(result);
	}


	
	












}
