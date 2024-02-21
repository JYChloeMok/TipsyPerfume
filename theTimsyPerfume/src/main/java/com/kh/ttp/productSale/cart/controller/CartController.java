package com.kh.ttp.productSale.cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.cart.model.service.CartService;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CartController {
	
	
	private final CartService cartService;
	
	/**
	 * 로그인한 유저일 시 장바구니 메인 페이지로 이동
	 */
	@GetMapping("cartMain.ca")
	public String cartMain(Model model, HttpSession session) {
		model.addAttribute("cartList", cartService.cartMain(((User)LoginUser.getLoginUser(session)).getUserNo()));
		return "productSale/cartMain";
	}
	
	
}
