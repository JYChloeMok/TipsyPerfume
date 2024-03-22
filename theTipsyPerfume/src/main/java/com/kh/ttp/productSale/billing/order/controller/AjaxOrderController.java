package com.kh.ttp.productSale.billing.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity.BodyBuilder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.billing.order.model.vo.OrderDTO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderInfoDTO;
import com.kh.ttp.productSale.billing.payment.model.service.PaymentService;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.common.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/order")
@RequiredArgsConstructor
public class AjaxOrderController {
	
	private final ProductSaleUtil productUtil;
	
	private final OrderService orderService;
	private final PaymentService paymentService;
	
	/*
	 * 결제 성공 시 "success"			: 결제가 완료되었다 + 불필요한 div 지움
	 * 재고 부족 시 "itemShortage"		: 재고가 부족한 상품이 있다 카트메인으로 이동한다
	 * (+ payStatus)
	 * 금액 검증 실패 시 "wrongAmount"	: 금액 검증이 실패했다
	 * (+ payStatus)
	 * 
	 * payStatus
	 * 결제 취소 성공 시 "refunded"		: 결제 취소가 성공했다
	 * 결제 취소 실패 시 "errorRefund"	: 결제 취소가 필요하지만 실패했다 관리자에게 문의해달라
	*/
	// 주문 생성
	@PostMapping
	public ResponseEntity<Map<String, String>> createOrder(@RequestBody OrderDTO order, HttpSession session) {

		productUtil.log.info("order={}", order);
		productUtil.log.info("orderMessage={}", order.getOrderMessage());
		
		String result = "";
		BodyBuilder response = null;

		// 결제된 정보
		PaymentDTO payment = order.getPayment();
		// 주문정보 문자열(customData) 객체배열화
		ArrayList<OrderInfoDTO> customDataList = new Gson().fromJson(order.getPayment().getCustomData(),
												 new TypeToken<List<OrderInfoDTO>>() {}.getType());
		
		// 파라미터 값 검증
		if(isOrderInfoValidated(customDataList)) {
			// 올바른 값 일 때
			// customDataList 세팅
			payment.setOrderInfoList(customDataList);
			// 유저 넘버 세팅
			int userNo = LoginUser.getLoginUser(session).getUserNo();
			(order.getReceiver()).setUserNo(userNo);
			// 주문 로직 호출
			result = orderService.createOrder(order);
			
		} else {
			// 올바르지 않은 값일 때
			result = "invalidParam";
		}

		// 반환할 상태코드 설정
		if("success".equals(result)) {
			// 주문 로직 정상적으로 성공
			// ResponseEntity세팅
			response = ResponseEntity.ok();
		} else {
			// 그 외 결제 취소
			processPaymentCancel(payment);
			// ResponseEntity세팅
			response = ("invalidParam".equals(result)) ? ResponseEntity.badRequest() : ResponseEntity.internalServerError();
		}
		
		// 반환할 값
		HashMap<String, String> orderResultMap = new HashMap();
		orderResultMap.put("result", result);
		orderResultMap.put("payStatus", payment.getPayStatus());
		
		// 결과 반환
		return response.headers(productUtil.makeApplicationJsonHeader())
					   .body(orderResultMap);
	}
	
	
	// 결제 취소
	private void processPaymentCancel(PaymentDTO payment) {
		// 결제 취소
		int cancelResult = paymentService.canclePayment(payment, 0);
		
		// 취소 후의 payStatus(결제 상태) 세팅
		payment.setPayStatus((0 < cancelResult) ? "refunded" : "errorRefund");
		
		// 취소 내역 DB 저장
		int insertResult = paymentService.insertPayment(payment);
		productUtil.log.info("insertPayment={}", insertResult);
	}
	
	
	// 값 검증
	private boolean isOrderInfoValidated(ArrayList<OrderInfoDTO> orderInfoList) {
		int multiNum;
		for(OrderInfoDTO orderInfo : orderInfoList) {
			multiNum = orderInfo.getCartNo() * orderInfo.getPdtOptionNo() * orderInfo.getOrderQuantity();
			// 하나라도 양수가 아닐 시 false
			if(multiNum < 1) {
				return false;
			}
		}
		return true;
	}
	
	
}
