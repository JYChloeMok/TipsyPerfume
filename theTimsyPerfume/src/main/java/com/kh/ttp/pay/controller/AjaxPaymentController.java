package com.kh.ttp.pay.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.pay.model.service.PaymentServiceImpl;
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
	
	@GetMapping("prepare")
	public ResponseEntity<Map<String, Object>> preparePaymentAjax(HttpSession session) {
		User loginUser = LoginUser.getLoginUser(session);
		User buyer = User.builder()
						 .userEmail(loginUser.getUserEmail())
						 .userName(loginUser.getUserName())
						 .phone(loginUser.getPhone())
						 .address(loginUser.getAddress())
						 .addressDetail(loginUser.getAddressDetail())
						 .postalCode(loginUser.getPostalCode())
						 .build();
		
		// 스트링 빌더
		StringBuilder sb = new StringBuilder();
		// 캘린더
		Calendar calendar = Calendar.getInstance();
		// 포맷
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		// 주문번호 만들기 (or randomUUID)<Map<String, Object>>
		sb.append(formatter.format(calendar.getTime()));
		for(int i = 0; i < 12; i++) {
			sb.append((int)(Math.random() * 10));
		}
		String merchantUid = sb.toString();
		
		// 반환할 맵 객체
		HashMap<String, Object> result = new HashMap();
		result.put("buyer", buyer);
		result.put("merchantUid", merchantUid);
		
		return new ResponseEntity<Map<String, Object>>(result,
								  productUtil.makeHeader("application", "json", "UTF-8"),
								  HttpStatus.OK);
	}












}
