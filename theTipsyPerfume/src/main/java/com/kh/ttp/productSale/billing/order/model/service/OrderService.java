package com.kh.ttp.productSale.billing.order.model.service;

import java.util.Map;

import com.kh.ttp.productSale.billing.order.model.vo.OrderVO;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;

public interface OrderService {
	
	// 주문서 페이지로 이동
	Map orderMain(CartVO cart);
	
	// 주문서 생성
	String createOrder(PaymentVO paymentResult);
	
	// 주문서 조회(SELECT)
	
	// 주문서 생성(INSERT)
	int insertOrder(OrderVO order);
	
	// 주문서 업데이트(UPDATE)
	int updateOrder(OrderVO order);
	
	// 주문서 삭제(DELETE)
	int deleteOrder(OrderVO order);

	
}
