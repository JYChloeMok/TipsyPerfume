package com.kh.ttp.productSale.billing.order.controller;


import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
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
							CartDTO cart,
							HttpSession session,
							@RequestParam(value="cartReq", defaultValue="") String cartReq) {
		// cart객체 cartNoArr세팅
		cart.setCartNoArr(productUtil.transIntoIntegerArr(cartReq));
		
		// cartNoArr 비어있으면 에러 반환
		if(cart.getCartNoArr().isEmpty()) { // transIntoIntegerArr null은 들어올 일 없음
			return productUtil.makeErrorMsg(model, "올바른 요청 값이 아닙니다!");
		}
		
		// 그 외 유저넘버 세팅
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo());
		
		// orderMain용 정보 조회
		HashMap<String, Object> orderMain = orderService.orderMain(cart);
		
		// model객체 세팅
		model.addAttribute("orderMain", orderMain);
		
		// 세션에 주문 금액 저장
		session.setAttribute("orderAmount", orderMain.get("orderAmount"));
		productUtil.log.info("orderAmount={}", session.getAttribute("orderAmount"));
		
		return "productSale/orderMain";
	}
	
	


	
	
	
}
