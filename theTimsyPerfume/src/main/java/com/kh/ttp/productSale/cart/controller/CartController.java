package com.kh.ttp.productSale.cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ttp.productSale.cart.model.service.CartService;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CartController {
	
	
	private final CartService cartService;
	
	
	@GetMapping("cartMain.ca")
	public ModelAndView cartMain(ModelAndView mv, HttpSession session) { // 로그인 인터셉터
		mv.addObject("cartList", cartService.cartMain(((User)session.getAttribute("loginUser")).getUserNo()))
		  .setViewName("productSale/cartMain");
		return mv;
		//System.out.println(productService.cartMain(((User)session.getAttribute("loginUser")).getUserNo()));
	}
	
	
}
