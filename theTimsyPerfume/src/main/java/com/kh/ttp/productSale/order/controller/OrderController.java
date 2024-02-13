package com.kh.ttp.productSale.order.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.order.model.service.OrderService;

@Controller
public class OrderController {
	
	private ProductSaleUtil productUtil;
	private OrderService orderService;
	
	@GetMapping("orderMain.od")
	public String orderMain(Model m,
							CartVO cart,
							HttpSession session,
							@RequestParam(value="cartReq", defaultValue="") String cartReq) {

		String[] cartReqList = cartReq.split(",");
		// 유효성 검사 후 cartVO객체 초기화
		for(String cartNo : cartReqList) {
			if(StringUtils.hasText(cartNo)) { // 텍스트인 것만
				cartNo = cartNo.trim();
				try {
					cart.getCartNoArr().add(Integer.parseInt(cartNo)); // 카트 번호 세팅
				} catch (NumberFormatException e) {
					e.getStackTrace();
					return productUtil.makeErrorMsg(m, "올바른 요청 값이 아닙니다!");
				}
			}
		}
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo()); // 유저넘버 세팅
		m.addAttribute("orderList", orderService.orderMain(cart));
		return "productSale/orderMain";
	}
	
}
