package com.kh.ttp.productSale.cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.cart.model.service.CartService;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/cart/")
@RequiredArgsConstructor
public class AjaxCartController {

	
	private final ProductSaleUtil productUtil;
	
	private final CartService cartService;
	
	/**
	 * 장바구니에 상품 추가 요청이 들어오면 재고 및 현재 장바구니에 있는 상품인지 체크 함
	 * 아직 추가되지 않은 상품은 cartQuantity만큼 INSERT, 이미 있는 경우 기존 수량에 더해 UPDATE 수행함
	 * @param cart : pdtNo(상품PK), pdtOptionNo(상품옵션PK), cartQuantity(카트에 추가할 수량)
	 * @param pdtCteg : 상품 카테고리, "F"(향수) / "A"(주류)
	 * @return : INSERT 혹은 UPDATE 성공 시 1, 실패 시 0, 재고가 없을 시 -1 반환
	 */
	@PostMapping("ajaxCheckStockAddCart.ca")
	public ResponseEntity<String> ajaxCheckStockAddCart(CartVO cart,
									  					@RequestParam String pdtCteg,
									  					HttpSession session) {
		User loginUser = LoginUser.getLoginUser(session);
	
		if(productUtil.isPdtCtegValid(pdtCteg) && (!("A".equals(pdtCteg)) || "Y".equals(loginUser.getAdultStatus()))) {
			cart.setUserNo(loginUser.getUserNo());
			return new ResponseEntity<String>(String.valueOf(cartService.checkStockAddCart(cart)),
											  productUtil.makeHeader("text", "html", "UTF-8"),
											  HttpStatus.OK);
		}
		return productUtil.makeAjaxErrorResult();
	}
	
	// 카트 수량 업데이트 (TB_CART에서 변경 가능한건 수량밖에 없음)
	@PutMapping("quantity/{cartNo}")
	public ResponseEntity<String> updateCart(CartVO cart, HttpSession session) {
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo());
		String result = (cartService.updateCart(cart) != 0) ? "success" : "fail";
		HttpHeaders header = productUtil.makeHeader("html", "text", "UTF-8");
		return new ResponseEntity<String>(result, header, HttpStatus.OK);
	}
	
	// 카트 아이템 삭제
	@PutMapping("delete/{cartNo}")
	public ResponseEntity<String> deleteCart(CartVO cart, HttpSession session) {
		cart.setUserNo(LoginUser.getLoginUser(session).getUserNo());
		String result = (cartService.deleteCart(cart) != 0) ? "success" : "fail";
		HttpHeaders header = productUtil.makeHeader("html", "text", "UTF-8");
		return new ResponseEntity<String>(result, header, HttpStatus.OK);
	}
	 
	
	
	
	
}
