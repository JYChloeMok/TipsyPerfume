package com.kh.ttp.productSale.billing.order.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.common.BillingUtil;
import com.kh.ttp.productSale.common.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final BillingUtil billingUtil;
	private final ProductSaleUtil productUtil;
	private final OrderService orderService;
	
	/**
	 * 주문하기 메인화면으로 이동
	 * 세션에 "orderAmount", "merchantUid"키의 값은 오직 여기서만 세팅함
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
		
		// 문자열로 cartNoArr배열 만들기
		ArrayList<Integer> cartNoArr = productUtil.shapeIntoIntegerArr(cartReq);
		
		// cartNoArr가 null 값이면 에러 리턴
		if(cartNoArr == null) {
			return productUtil.makeErrorMsg(model, "올바른 요청 값이 아닙니다!");
		}
		
		// 유효한 값이면 파라미터 세팅 후 오더메인 호출(주문 메인용 상품 정보 조회)
		cart.setCartNoArr(cartNoArr);
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo());
		HashMap<String, Object> orderMain = orderService.orderMain(cart);
		
		// 세션에 정보 저장 (orderAmount(주문금액)는 방금 조회해온 값, merchantUid는 여기서 생성)
		session.setAttribute("orderAmount", orderMain.get("orderAmount"));
		session.setAttribute("merchantUid", billingUtil.makeMerchantUid());
		productUtil.log.info("orderAmount={}", session.getAttribute("orderAmount"));
		productUtil.log.info("merchantUid={}", session.getAttribute("merchantUid"));
		// model객체 세팅
		model.addAttribute("orderMain", orderMain);
		// 주문 메인으로 반환
		return "productSale/orderMain";
	}
	
	


	
	
	
}
