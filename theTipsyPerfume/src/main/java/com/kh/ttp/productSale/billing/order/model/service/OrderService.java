package com.kh.ttp.productSale.billing.order.model.service;

import java.util.HashMap;
import java.util.List;

import com.kh.ttp.productSale.billing.order.model.vo.OrderDTO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderInfoDTO;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;

public interface OrderService {
	
	// 주문 메인 페이지로 이동
	HashMap orderMain(CartDTO cart);
	
	// 주문하기 전체 로직
	String createOrder(OrderDTO order);
	
	// 주문서 조회(SELECT)
	
	// 주문서 생성(INSERT)
	int insertOrder(OrderDTO order);
	
	// 주문서 업데이트(UPDATE)
	int updateOrder(OrderDTO order);
	
	// 주문서 삭제(DELETE)
	int deleteOrder(OrderDTO order);
	
	// 주문상품 목록 저장(INSERT)
	int insertOrderProduct(List<OrderInfoDTO> orderInfoList);
	
}
