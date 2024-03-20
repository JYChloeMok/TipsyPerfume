package com.kh.ttp.productSale.billing.payment.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.payment.model.service.PaymentServiceImpl;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/payment/")
@RequiredArgsConstructor
public class AjaxPaymentController {
	
	private final ProductSaleUtil productUtil;
	private final PaymentServiceImpl paymentService;
	
	/**
	 * 외부 결제API 요청 파라미터 준비 메소드
	 * @param session
	 * @return : ResponseEntity로 HashMap 반환<br />
	 * 키 buyer : 주문자(로그인 유저) 정보<br />
	 * 키 merchantUid : 주문 번호<br />
	 */
	@GetMapping("prepare")
	public ResponseEntity<Map<String, Object>> preparePaymentAjax(HttpSession session) {

		// 주문자 정보
		User buyer = LoginUser.getLoginUser(session);
		
		// 주문번호
		String merchantUid = createMerchantUid();
		
		// 반환할 맵 객체
		HashMap<String, Object> result = new HashMap();
		result.put("buyer", buyer);
		result.put("merchantUid", merchantUid);
		
		// ResponseEntity 리턴
		return ResponseEntity.ok() // <Map<<String, Object>>추론
							 .headers(productUtil.makeApplicationJsonHeader())
							 .body(result);
	}

	// 주문번호 만들기
	private String createMerchantUid() {
		// 스트링 빌더, 캘린더, 포매팅 객체 (주문번호 만들기 준비)
		StringBuilder sb = new StringBuilder();
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		
		// 주문번호 만들기 날짜8자리 + 난수 12자리 / (or randomUUID)
		sb.append(formatter.format(calendar.getTime()));
		for(int i = 0; i < 12; i++) {
			sb.append((int)(Math.random() * 10));
		}
		
		// 주문번호
		return sb.toString();
	}









}
