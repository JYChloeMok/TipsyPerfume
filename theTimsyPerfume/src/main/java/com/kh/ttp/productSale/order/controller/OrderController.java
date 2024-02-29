package com.kh.ttp.productSale.order.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.order.model.service.OrderService;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final ProductSaleUtil productUtil;
	private final OrderService orderService;
	
	@GetMapping("orderMain.od")
	public String orderMain(Model model,
							CartVO cart,
							HttpSession session,
							@RequestParam(value="cartReq", defaultValue="") String cartReq) {
		// 빈문자열 제거
		String[] cartReqList = cartReq.replace(" ", "").split(",");
		
		// 빈배열 체크
		if(cartReqList.length < 1) {
			return productUtil.makeErrorMsg(model, "올바른 요청 값이 아닙니다!"); 
		}
		
		// int변환(검증) 및 카트 번호 세팅
		cart.setCartNoArr(new ArrayList());
		ArrayList cartArr = (ArrayList)cart.getCartNoArr();
		for(String cartNo : cartReqList) {
			try {
				cartArr.add(Integer.parseInt(cartNo));
			} catch (NumberFormatException e) {
				e.getStackTrace();
				return productUtil.makeErrorMsg(model, "올바른 요청 값이 아닙니다!");
			}
		}
		// 유저넘버 세팅
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo());
		
		model.addAttribute("orderMain", orderService.orderMain(cart));
		return "productSale/orderMain";
	}
	

	
	
	
}
