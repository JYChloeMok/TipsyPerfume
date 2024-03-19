package com.kh.ttp.productSale.billing.order.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/order/")
@RequiredArgsConstructor
public class AjaxOrderController {
	
	private final OrderService orderService;
	
	// 주문 생성
	//@PostMapping("/")
	//public ResponseEntity<String> insertOrder() {
		
	//}
	private Logger log = LoggerFactory.getLogger(AjaxOrderController.class);

	// 주문 생성
	@PostMapping
	public String createOrder(PaymentVO paymentResult) {
		
		log.info("paymentResult={}", paymentResult);
		orderService.createOrder(paymentResult);
		return "success";
	}
	
	
	
}
