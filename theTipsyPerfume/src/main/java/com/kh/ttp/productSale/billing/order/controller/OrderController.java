package com.kh.ttp.productSale.billing.order.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final ProductSaleUtil productUtil;
	private final OrderService orderService;
	
	/**
	 * 주문하기 메인화면으로 이동
	 * @param model
	 * @param cart
	 * @param session
	 * @param cartReq
	 * @return
	 */
	@GetMapping("orderMain.od")
	public String orderMain(Model model,
							CartVO cart,
							HttpSession session,
							@RequestParam(value="cartReq", defaultValue="") String cartReq) {
		// cart객체 cartNoArr세팅
		cart.setCartNoArr(productUtil.transIntoIntegerArr(cartReq));
		
		// null이면 에러 반환
		if(cart.getCartNoArr() == null) {
			return productUtil.makeErrorMsg(model, "올바른 요청 값이 아닙니다!");
		}
		
		// 그 외 cart객체 마저 세팅
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo());
		
		// orderMain용 정보 조회, model객체 반환
		model.addAttribute("orderMain", orderService.orderMain(cart));
		return "productSale/orderMain";
	}
	
	


	
	
	
}
