package com.kh.ttp.productSale.order.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.ttp.productSale.cart.model.service.CartService;
import com.kh.ttp.user.model.vo.User;

@Controller
public class OrderController {
	
	//@GetMapping("orderMain")
	public String orderMain() {
		// cartNo정보로 조회
		
		
		return "productSale/orderMain";
	}
	
}
