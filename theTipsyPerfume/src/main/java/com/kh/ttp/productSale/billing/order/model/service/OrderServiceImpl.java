package com.kh.ttp.productSale.billing.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.kh.ttp.productSale.billing.order.model.dao.OrderDao;
import com.kh.ttp.productSale.billing.order.model.vo.OrderDTO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderInfoDTO;
import com.kh.ttp.productSale.billing.payment.model.dao.PaymentDao;
import com.kh.ttp.productSale.billing.payment.model.service.PaymentService;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.cart.model.dao.CartDao;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.cart.model.vo.CartMainDTO;
import com.kh.ttp.productSale.cart.model.vo.SaleMainDTO;
import com.kh.ttp.productSale.common.util.BillingUtil;
import com.kh.ttp.productSale.common.util.ProductSaleUtil;
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
	private final BillingUtil billingUtil;
	private final SqlSessionTemplate sqlSession;

	private final CartDao cartDao;
	private final OrderDao orderDao;
	private final ProductDao productDao;
	private final PaymentDao paymentDao;
	
	@Override
	public HashMap orderMain(CartDTO cart) {

		// 조회결과
		ArrayList<SaleMainDTO> orderList = orderDao.orderMain(sqlSession, cart);

		// 결과값 없다면 null반환(GET매핑 URL조작  시 없는 cartNo이었을 수도 있음)
		if(orderList == null || orderList.size() < 1) { // DAO에서 null반환하지만 안전하게 or연산자 더블체크
			return null;
		}
		
		// 조회해온 결과로 최종 주문금액, 배송비 계산하는 메소드
		int cartAmount = billingUtil.calcCartAmount(orderList);
		int orderShipping = billingUtil.calcMinShipping(orderList);
		
		HashMap<String, Object> orderMain = new HashMap();
		orderMain.put("orderList", orderList);
		orderMain.put("cartAmount", cartAmount);
		orderMain.put("orderShipping", orderShipping);
		orderMain.put("orderAmount", cartAmount + orderShipping);
		orderMain.put("isEnoughStock", billingUtil.isEnoughStock(orderList));
		return orderMain;
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
		ArrayList<OrderInfoDTO> customDataList = (ArrayList)order.getPayment().getOrderInfoList();

		// 0. 재고 확인(수량 부족한 아이템 있는지)
		/*
		int lowStockItem = productDao.countLowStockItem(sqlSession, customDataList);
		if(0 < lowStockItem) {
			return "itemShortage";
		}
		*/
		//ArrayList<Integer> pdtOption = "";
		// 위는 SELECT구문 여기부터 트랜잭션 만들어짐
		/*
		 * SELECT문으로 먼저 체크 후 재고가 있을 경우에만 UPDATE 실행하려 했음
		 * 그러나 오라클에서 SELECT은 트랜잭션 발생x
		 * => 다른사람이 업데이트 중인 데이터는 커밋 전 까지 못읽음
		 * => SELECT은 했는데 UPDATE에서 오류날 수도 있음
		 * => 조건을 걸어서 UPDATE를 먼저 수행하자
		 * (주문옵션넘버 = #{넘버} and #{주문수량} < 재고)
		 * 조건을 주문 옵션 넘버만 걸어서 UPDATE하면
		 *  오류가 발생할 수도 있는데 오류를 성공실패 여부를 알기위해 사용하는건 좋지 않아보임
		 * => 그리고 오류 발생시 재고부족으로 인한 것인지 체크하기 위해 예외만 출력함(SELECT은 좀 오버인듯)
		 * 오류 발생 안하면 문제x
		 */

		// 1. 재고 감소 : quantity의 부호를 -로 바꾼 후 재고감소
		int itemLength = customDataList.size();
		try {
			int adjustResult = productDao.adjustStock(sqlSession, invertQuantitySign(customDataList));
		} catch(DataAccessException e) { // SQLException => 스프링에선 DataAccessException로 패킹해줌
			productUtil.log.info("adjustResult에러={}", e.getMessage());
			
			// 일단 주문 수량/판매중단 문제인지 SELECT하는걸로 해보자
			int lowStockItem = productDao.countLowStockItem(sqlSession, customDataList);
			if(0 < lowStockItem) {
				return "itemShortage";
			} else {
				return "errorRuntime";
			}
		}
		// 재고감소 요청한 아이템 수 != 업데이트된 행 개수라면
		if(itemLength != adjustResult) {
			// 실패 원인이 재고부족/판매중단상품 때문인지 확인 (그 외 경우는 에러구문 봄)
			
		}
		
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
	
	
	// 재고 리스트의 부호 반전
	// 첫번째 값이 양수면 모두 음수로 반전시키고 첫번째 값이 음수면 모두 양수로 반전시킴
	// 실제 사용에서 이 메소드를 사용한다면? 모두 업데이트(추가) 혹은 모두 업데이트(감소)일 것
	// 어떤 것은 증가시키고, 어떤 것은 감소시키는 행위를 한번에 시행하지는 않을 것
	// 그러므로 일괄 -로, 혹은 +로 변경
	private ArrayList<OrderInfoDTO> invertQuantitySign(ArrayList<OrderInfoDTO> orderInfoList) {
		// 음양 반전 깊은복사
		ArrayList<OrderInfoDTO> copiedList = new ArrayList();
		for(OrderInfoDTO orderInfo : orderInfoList) { // +면?
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
