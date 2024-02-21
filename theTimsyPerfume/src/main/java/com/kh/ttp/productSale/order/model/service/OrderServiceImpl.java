package com.kh.ttp.productSale.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.cart.model.vo.CartMainVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.order.model.dao.OrderDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

	private final OrderDao orderDao;
	
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public HashMap orderMain(CartVO cart) {
		
		// 조회결과
		ArrayList<CartMainVO> orderList = orderDao.orderMain(sqlSession, cart);
		
		// 조회해온 결과로 최종 주문금액, 배송비 계산하는 메소드
		int cartAmount = calcCartAmount(orderList);
		int orderShipping = calcCartAmount(orderList);
		
		HashMap orderMain = new HashMap();
		orderMain.put("orderList", orderList);
		orderMain.put("cartAmount", cartAmount);
		orderMain.put("orderShipping", orderShipping);
		orderMain.put("orderAmount", cartAmount + orderShipping);
		return orderMain;
	}
	
	
	private int calcMinShipping(ArrayList<CartMainVO> orderList) {
		int currShipping;
		// 0번 인덱스 배송비
		int minShipping = Integer.parseInt(orderList.get(0).getPdtShipping());
		for(int i = 1; i < orderList.size(); i++) {
			if(minShipping == 0) {
				break;
			} else {
				// i번째 인덱스 배송비
				currShipping = Integer.parseInt(orderList.get(i).getPdtShipping());
				if(currShipping < minShipping) {
					minShipping = currShipping;
				}
			}
		}
		return minShipping;
	}
	
	
	private int calcCartAmount(ArrayList<CartMainVO> orderList) {
		int sum = 0;
		for(CartMainVO item : orderList) {
			sum += item.getTotalPrice();
		}
		return sum;
	}
	
	
}
