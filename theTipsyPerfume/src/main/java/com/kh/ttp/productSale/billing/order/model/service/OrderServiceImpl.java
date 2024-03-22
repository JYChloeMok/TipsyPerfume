package com.kh.ttp.productSale.billing.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.billing.order.model.dao.OrderDao;
import com.kh.ttp.productSale.billing.order.model.vo.OrderDTO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderInfoDTO;
import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;
import com.kh.ttp.productSale.billing.payment.model.service.PaymentService;
import com.kh.ttp.productSale.cart.model.dao.CartDao;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.cart.model.vo.CartMainDTO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.product.model.dao.ProductDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

	private final PaymentService paymentService;
	/* 문제 : OrderServiceImpl이 해야할 일이 되게 많다
	 * 엉엉 
	 */
	
	private final ProductSaleUtil productUtil;
	private final SqlSessionTemplate sqlSession;

	private final CartDao cartDao;
	private final OrderDao orderDao;
	private final ProductDao productDao;
	private final PaymentDao paymentDao;
	
	@Override
	public HashMap orderMain(CartDTO cart) {

		// 조회결과
		ArrayList<CartMainDTO> orderList = orderDao.orderMain(sqlSession, cart);

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
	private int calcMinShipping(ArrayList<CartMainDTO> orderList) {
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
	private int calcCartAmount(ArrayList<CartMainDTO> orderList) {
		int sum = 0;
		for (CartMainDTO item : orderList) {
			sum += item.getTotalPrice();
		}
		return sum;
	}
	
	private HashMap<String, Object> makeOrderResult(String resultStr, ArrayList<CartMainDTO> resultData){
		HashMap<String, Object> result = new HashMap();
		result.put("resultStr", resultStr);
		result.put("resultData", resultData);
		return result;
	}
	private HashMap<String, Object> makeOrderResult(String resultStr){
		HashMap<String, Object> result = new HashMap();
		result.put("resultStr", resultStr);
		return result;
	}
	
	/**
	 * 결제 성공 시 "success"			: 결제가 완료되었다 + 불필요한 div 지움
	 * 재고 부족 시 "itemShortage"		: 재고가 부족한 상품이 있다 카트메인으로 이동한다 
	 * 금액 검증 실패 시 "wrongAmount"	: 금액 검증이 실패했다 계속 에러 발생 시 관리자에게 문의해달라
	 * 그 외 트랜잭션 중 에러 "error"		: 그 외 트랜잭션 중 에러
	 * 
	 * 여기서 보낼거 "success", "itemShortage", "wrongAmount", "error"
	 */
	@Override
	public String createOrder(OrderDTO order) {
		
		// 결제 정보 객체
		PaymentDTO payment = order.getPayment();
		
		// customData 문자열을 자바 객체배열로 전환 (주문 상품 정보)
		// OrderInfoDTO객체 : 주문 상품의 cartNo(카트번호), pdtOptionNo(상품옵션번호), orderQuantity(상품수량)
		ArrayList<OrderInfoDTO> customDataList = new Gson().fromJson(order.getPayment().getCustomData(),
																	 new TypeToken<List<OrderInfoDTO>>() {}.getType());

		// 재고부족 아이템 체크
		if(0 < productDao.countLowStockItem(sqlSession, customDataList)) {
			return "itemShortage";
		}
		//ArrayList<Integer> pdtOption = "";


		// 위는 SELECT구문 여기부터 트랜잭션 만들어짐
			// 1. 재고 감소
			productDao.adjustStock(sqlSession, reverseArithmeticSign(customDataList));

			// 2. 결제정보 저장
			paymentDao.insertPayment(sqlSession, payment);
			// ORDER_NO, USER_NO, RECEIVER_NO, PAYMENT_NO, ORDER_DATE
			// ORDER_ARRIVAL_DATE, ORDER_MESSAGE
			
			// 3. 주문서 생성
			insertOrder(order);
			
			// 4. 주문상품 목록 저장 (orderNo(SEQ_ORDER.currVal), pdtOptionNo, orderQuantity)
			//insertOrderProduct(customDataList);
			
			// 5. 장바구니 삭제
			CartDTO cart = new CartDTO();
			//art.setUserNo(LoginUser.getLoginUser(session));
			//cart.setCartNoArr(cartNoArr);
			//cartDao.deleteCart(sqlSession, cart);
			return "error";
		/*
		 WHERE
	   	  USER_NO = #{userNo}
	   	  <foreach collection="cartNoArr" item="cartNo" open="(" separator="," close=")">
			#{cartNo}
	   	  </foreach>
	   	  cart의 List<Integer> cartNoArr;
	   	*/
			
		// paymentDao.insertPayment(paymentResult);

		// 주문서 생성
		// insertOrder(order);
		// 여기까지 한 transaction

		// 장바구니 삭제(이건 성공하든 실패하든 상관x)

		// 하나라도 실패 시 결제 취소
		// fail리턴, 사유 : 재고 부족, 결제 금액 검증 실패
		return "";
	}
	
	private ArrayList<OrderInfoDTO> reverseArithmeticSign(ArrayList<OrderInfoDTO> orderInfoList) {
		// 음양 반전 깊은복사
		ArrayList<OrderInfoDTO> copiedList = new ArrayList();
		for(OrderInfoDTO orderInfo : orderInfoList) {
			copiedList.add(new OrderInfoDTO(orderInfo.getCartNo(),
											orderInfo.getPdtOptionNo(),
											(-orderInfo.getOrderQuantity())));
		}
		return copiedList;
	}

	@Override
	public int insertOrder(OrderDTO order) {
		return orderDao.insertOrder(sqlSession, order);
	}

	@Override
	public int updateOrder(OrderDTO order) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteOrder(OrderDTO order) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String createOrder(OrderDTO order) {
		// TODO Auto-generated method stub
		return null;
	}

}
