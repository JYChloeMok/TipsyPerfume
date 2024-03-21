package com.kh.ttp.productSale.billing.order.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.billing.order.model.vo.OrderVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/order")
@RequiredArgsConstructor
public class AjaxOrderController {
	
	private final ProductSaleUtil productUtil;
	private final OrderService orderService;
	
	// 주문 생성
	//@PostMapping("/")
	//public ResponseEntity<String> insertOrder() {
		
	//}

	
	
	// 주문 생성
	@PostMapping
	public String createOrder(@RequestBody OrderVO order) { // customData : 주문 상품 정보(개수 등) 객체배열
		
		productUtil.log.info("order={}", order);
		productUtil.log.info("orderMessage={}", order.getOrderMessage());
		
		//orderService.createOrder(paymentResult);
		return order.toString();
	}
	
	
	
}
