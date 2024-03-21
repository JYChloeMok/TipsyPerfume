package com.kh.ttp.productSale.billing.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.billing.order.model.dao.OrderDao;
import com.kh.ttp.productSale.billing.order.model.vo.OrderVO;
import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;
import com.kh.ttp.productSale.cart.model.vo.CartMainVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.product.model.dao.ProductDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

	private final OrderDao orderDao;
	private final ProductDao productDao;
	private final PaymentDao paymentDao;
	private final SqlSessionTemplate sqlSession;
	
	private final ProductSaleUtil productUtil;
	
	@Override
	public HashMap orderMain(CartVO cart) {

		// 조회결과
		ArrayList<CartMainVO> orderList = orderDao.orderMain(sqlSession, cart);

		// 조회해온 결과로 최종 주문금액, 배송비 계산하는 메소드
		int cartAmount = calcCartAmount(orderList);
		int orderShipping = calcMinShipping(orderList);

		HashMap<String, Object> orderMain = new HashMap();
		orderMain.put("orderList", orderList);
		orderMain.put("cartAmount", cartAmount);
		orderMain.put("orderShipping", orderShipping);
		orderMain.put("orderAmount", cartAmount + orderShipping);
		return orderMain;
	}

	/**
	 * 카트 메인용 최소 배송비 계산 메소드
	 */
	private int calcMinShipping(ArrayList<CartMainVO> orderList) {
		int currShipping;
		// 0번 인덱스 배송비를 minShipping으로 설정
		int minShipping = Integer.parseInt(orderList.get(0).getPdtShipping());
		// 제일 작은 값을 minShipping으로 설정
		// minShipping이 0이면 중단
		for (int i = 1; i < orderList.size(); i++) {
			if (minShipping == 0) {
				break;
			} else {
				// i번째 인덱스 배송비
				currShipping = Integer.parseInt(orderList.get(i).getPdtShipping());
				if (currShipping < minShipping) {
					minShipping = currShipping;
				}
			}
		}
		return minShipping;
	}

	/**
	 * 카트 메인용 주문 총 합계 계산 메소드
	 */
	private int calcCartAmount(ArrayList<CartMainVO> orderList) {
		int sum = 0;
		for (CartMainVO item : orderList) {
			sum += item.getTotalPrice();
		}
		return sum;
	}

	/*	
	@Override
	public String createOrder(PaymentVO paymentResult) {
		// 파라미터 payment의 customData(JSON문자열 형태)를 자바 객체배열화
		//List<OrderCustomData> customDataList = new Gson().fromJson(paymentResult.getCustomData(), new TypeToken<List<OrderCustomData>>() {}.getType());
		productUtil.log.info("customDataList={customDataList}", customDataList);

		// 재고 < 구매 수량인 아이템이 있는지 확인(재고미달)
		//if(0 < orderDao.selectStockShortage(customDataList)) {
			// 재고 부족인 경우가 있을 시 해당 상품(상품번호pdtNo, 상품옵션pdtOptionFirst, 상품옵션번호pdtOptionNo, 상품이름pdtName List<CartMainVO>반환)
		//} else {
			// 재고 충분할 시
			
			// 1. 재고 감소
			//productDao.reduceStock(sqlSession, customDataList);
			
			// 2. 결제정보 저장
			paymentDao.insertPayment(sqlSession, paymentResult);
			// ORDER_NO, USER_NO, RECEIVER_NO, PAYMENT_NO, ORDER_DATE
			// ORDER_ARRIVAL_DATE, ORDER_MESSAGE
			// 3. 주문서 생성
			//orderDao.insertOrder(sqlSession, )
			
			// 4. 주문상품 저장
			
			// 5. 장바구니 삭제
		//}
		
		
		
		/*
		List<Integer> pdtNoArr = new ArrayList();
		for (ProductVO pValue : orderProductList) {
			pdtNoArr.add(pValue.getPdtNo());
		}
		
		
		
		// 결제 값 검증
		// pdtNo Arr로 현재 DB amount 계산

		// productUtil.log.info("pdtNoArr={}", pdtNoArr);

		// 재고 < 주문 개수(재고부족) 확인
		if (productDao.countPdtSoldOut(sqlSession, pdtNoArr) < 1) {
			// @@ 재고부족 상품이 있으면 결제 취소
		} else {
			// 재고 감소 (pdtNoArr, 구매 개수 받음)
			// productDao.adjustStock(sqlSession, )

			// 결제정보 DB 저장
		}

		// paymentDao.insertPayment(paymentResult);

		// 주문서 생성
		// insertOrder(order);
		// 여기까지 한 transaction

		// 장바구니 삭제(이건 성공하든 실패하든 상관x)

		// 하나라도 실패 시 결제 취소
		// fail리턴, 사유 : 재고 부족, 결제 금액 검증 실패

		return null;
	}*/

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

	@Override
	public String createOrder(PaymentVO paymentResult) {
		// TODO Auto-generated method stub
		return null;
	}

}
