package com.kh.ttp.productSale.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderController {
	
	@GetMapping("orderMain.od")
	public String orderMain() {
		// cartNo정보로 조회
		
		
		return "productSale/orderMain";
	}
	
}
