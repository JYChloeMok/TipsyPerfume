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
import com.kh.ttp.productSale.common.util.ProductSaleUtil;
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
	 * 결제에 필요한 파라미터를 준비함
	 * @param session
	 * @return : ResponseEntity로 HashMap 반환<br>
	 * 키 buyer : 주문자(로그인 유저) 정보<br>
	 * 키 merchantUid : 주문 번호<br>
	 */
	@GetMapping("/payment/paymentParam")
	public ResponseEntity<Map<String, Object>> paymentParamAjax(HttpSession session) {
		// 주문자 정보
		UserDTO buyer = LoginUser.getLoginUser(session);

		// 주문번호
		// => 요청이 orderMain을 통하지 않는 경우 등
		// 	    유효하지 않은 값일 경우 빈문자열 반환(JS에서 falsy값)
		//    ex) 외부에서 '도메인/payment/paymentParam' ajax요청 보낸 경우
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
