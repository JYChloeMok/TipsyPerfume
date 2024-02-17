package com.kh.ttp.productSale.order.model.service;

import java.util.Map;

import com.kh.ttp.productSale.cart.model.vo.CartVO;

public interface OrderService {
	
	// 주문서 페이지로 이동
	Map orderMain(CartVO cart);
	 
	// 주문서 생성
	
	
}
