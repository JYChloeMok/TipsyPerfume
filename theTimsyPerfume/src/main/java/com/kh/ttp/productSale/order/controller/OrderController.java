package com.kh.ttp.productSale.order.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class OrderController {
	
	@GetMapping("orderSheet.pr")
	public String orderSheet() {
		return "orderKinds/OrderSheet";
	}
	
}
