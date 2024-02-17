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
		
		ArrayList<CartMainVO> orderList = orderDao.orderMain(sqlSession, cart);
		
		HashMap orderMain = new HashMap();
		orderMain.put("orderList", orderList);
		orderMain.put("orderAmount", calcOrderAmount(orderList));
		orderMain.put("orderShipping", calcMinShipping(orderList));
		
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
	
	
	private int calcOrderAmount(ArrayList<CartMainVO> orderList) {
		int sum = 0;
		for(CartMainVO item : orderList) {
			sum += item.getTotalPrice();
		}
		return sum;
	}
	
}
