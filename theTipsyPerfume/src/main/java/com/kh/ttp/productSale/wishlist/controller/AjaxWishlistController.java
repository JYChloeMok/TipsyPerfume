package com.kh.ttp.productSale.wishlist.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.wishlist.model.service.WishlistService;
import com.kh.ttp.productSale.wishlist.model.vo.WishlistVO;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequiredArgsConstructor
public class AjaxWishlistController {
	
	
	private final ProductSaleUtil productUtil;
	
	private final WishlistService wishlistService;
	
	
	
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
	@PostMapping(value="ajaxChangeWishOne.pa", produces="text/html; charset=UTF-8") // 로그인 인터셉터거침
	public String ajaxChangeWishOne(@RequestParam(value="pdtNo", defaultValue="0") int pdtNo, HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		if((user != null) && pdtNo > 0) {
			WishlistVO wishlist = new WishlistVO();
			wishlist.setPdtNo(pdtNo);
			wishlist.setUserNo(user.getUserNo());
			boolean isFilledHeart = wishlistService.ajaxChangeWishOne(wishlist); // 가독성 위해
			return String.valueOf(isFilledHeart); // isFilledHeart + ""; X "null"방지
		} else {
			return "ERROR";
		}
	}
	
}
