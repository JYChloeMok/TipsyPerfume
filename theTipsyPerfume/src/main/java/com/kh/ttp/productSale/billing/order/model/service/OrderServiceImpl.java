package com.kh.ttp.productSale.billing.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.billing.order.model.dao.OrderDao;
import com.kh.ttp.productSale.billing.order.model.vo.OrderVO;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;
import com.kh.ttp.productSale.cart.model.vo.CartMainVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;

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
		int orderShipping = calcMinShipping(orderList);
		
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


	@Override
	public String createOrder(PaymentVO payment) {
		// 결제 값 검증
		// pdtNo Arr로 현재 DB amount 계산
		
		// 재고 체크
		//selectStockWithOptionList();
		
		// 재고 감소
		
		// 주문서 생성
		//insertOrder(order);
		// 여기까지 한 transaction
		
		// 장바구니 삭제(이건 성공하든 실패하든 상관x)
		
		// 하나라도 실패 시 결제 취소
		// fail리턴, 사유 : 재고 부족, 결제 금액 검증 실패
		
		
		return null;
	}


	@Override
	public int insertOrder(OrderVO order) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public int updateOrder(OrderVO order) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public int deleteOrder(OrderVO order) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
}
