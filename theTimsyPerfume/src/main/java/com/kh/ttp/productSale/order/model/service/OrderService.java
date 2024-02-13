package com.kh.ttp.productSale.order.model.service;

import java.util.List;

import com.kh.ttp.productSale.cart.model.vo.CartVO;

public interface OrderService {
	
	// 주문서 페이지로 이동
	List<CartVO> orderMain(List<Integer> cartNoList);
	 
	// 주문서 생성
	
	
}
