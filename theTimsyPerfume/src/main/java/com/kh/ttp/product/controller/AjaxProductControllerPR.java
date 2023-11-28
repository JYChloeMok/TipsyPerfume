package com.kh.ttp.product.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.ttp.product.model.service.ProductServicePR;
import com.kh.ttp.product.model.vo.CartVO;
import com.kh.ttp.product.model.vo.ProductOption;
import com.kh.ttp.product.model.vo.WishlistVO;
import com.kh.ttp.user.model.vo.User;

@Controller
public class AjaxProductControllerPR {
	
	@Autowired
	private ProductServicePR productService;
	
	/**
	 * 유저의 위시리스트에 이미 추가되어있는 상품인지 체크 후<br>
	 * 이미 있으면 위시리스트 취소(DELETE), 없으면 추가(INSERT)
	 * @param pdtNo : 위시리스트를 추가하려는 상품 번호(PK)
	 * @param session : 로그인 유저 번호(PK)를 뽑기위한 세션
	 * @return
	 * 위시리스트가 있는 상태로 표시해야 할 때 문자열 "true"반환<br>
	 * 비워진 상태로 표시해야할 때 문자열 "false" 반환<br>
	 * (가독성을 위해 "true", "false"반환)
	 */
	@ResponseBody // @@@Ajax는 만약 LoginInterceptor가 필요하면 따로 만들어야..!
	@PostMapping(value="ajaxChangeWishOne.pa", produces="text/html; charset=UTF-8")
	public String ajaxChangeWishOne(@RequestParam(value="pdtNo", defaultValue="0") int pdtNo, HttpSession session) {
		if(pdtNo > 0) {
			WishlistVO wishlist = new WishlistVO();
			wishlist.setPdtNo(pdtNo);
			wishlist.setUserNo(((User)session.getAttribute("loginUser")).getUserNo());
			boolean isFilledHeart = productService.ajaxChangeWishOne(wishlist); // 가독성 위해
			return isFilledHeart + "";
		} else {
			return "ERROR";
		}
	}
	
	/**
	 * 상품 재고가 1개 이상인지 조회 후 장바구니에 해당 상품 1개 추가
	 * @param pdtNo
	 * @param session
	 * @return : 추가 성공 시 "1"문자열, 실패 시 "0"문자열 반환
	 */
	@ResponseBody
	@PostMapping(value="ajaxAddCartSingleQuan.pa", produces="text/html; charset=UTF-8")
	public String ajaxAddCartSingleQuan(@RequestParam(value="pdtNo", defaultValue="0") int pdtNo, HttpSession session) {
		if(pdtNo > 0) {
			CartVO cart = new CartVO();
			cart.setUserNo(((User)session.getAttribute("loginUser")).getUserNo());
			cart.setPdtNo(pdtNo);
			return productService.ajaxAddCartSingleQuan(cart) + "";
		} else {
			return "ERROR";
		}
	}
	
	/**
	 * 상품 번호로 상품이 가진 옵션을 조회하는 메소드
	 * @param pdtNo
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="ajaxShowCartQuickAddModal.pa", produces="application/json; charset=UTF-8")
	public String ajaxShowCartQuickAddModal(@RequestParam(value="pdtNo", defaultValue="0") int pdtNo) {
		return new Gson().toJson(productService.ajaxShowCartQuickAddModal(pdtNo));
	}
	
	
	
	
	
	
	
}
