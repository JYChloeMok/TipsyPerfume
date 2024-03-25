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
import com.google.gson.JsonParseException;
import com.google.gson.reflect.TypeToken;
import com.kh.ttp.common.model.vo.CodeMessage;
import com.kh.ttp.common.util.LoginUser;
import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.billing.order.model.vo.OrderDTO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderInfoDTO;
import com.kh.ttp.productSale.billing.payment.model.service.PaymentService;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.common.util.ProductSaleUtil;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverDTO;

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
	 * 
	 * 뭔진 몰라도 런타임 에러 "errorRuntime" : 어떤 사유인지 정해지지 않았으나 런타임 에러 발생
	*/
	// 주문 생성
	@PostMapping
	public ResponseEntity<Map<String, String>> createOrder(@RequestBody OrderDTO order, HttpSession session) {
		productUtil.log.info("order={}", order);
		productUtil.log.info("orderMessage={}", order.getOrderMessage());
		
		// [1] 필요한 값 가공 및 세팅
		
		// 필요한 변수들 선언
		boolean flag = false;
		String result = "";
		BodyBuilder response = null;
		ArrayList<OrderInfoDTO> customDataList = null;
		
		// 결제 정보 (포트원 결제는 완료된 상태)
		/* 결제하고 콜백함수에서 만들어오는거라 null일 일은 없을듯 */
		PaymentDTO payment = order.getPayment();
		
		// 주문정보 가공 (JSON형태 문자열 => 자바 객체배열)
		/* order객체 내부 customData는 화면값을 문자열로 만들어서 결제요청 했던거라 실제로 null이 아닐지라도 더블체크 필요 */
		customDataList = fromJsonOrderInfoList(order.getPayment().getCustomData());
		
		
		// [2] 로직 수행 후 처리결과 result 설정
		
		// 가공된 데이터 검증 및 주문 로직 (카트번호, 상품 옵션 번호, 주문수량이 모두 양수)
		if(customDataList != null && isOrderInfoValidated(customDataList)) {
			// 검증됐다면 파라미터 세팅 
			payment.setOrderInfoList(customDataList);
			// 주문자(유저번호) 세팅
			ReceiverDTO receiver = order.getReceiver();
			receiver.setUserNo(LoginUser.getLoginUser(session).getUserNo());
			// 서비스의 주문 로직 호출 후 결과
			result = orderService.createOrder(order);
		} else {
			// 검증 실패 시 결제 취소 및 취소내역 DB 저장 (파라미터 환불금액 0 => 전체환불)
			PortOneCancelDTO cancelResult = paymentService.proceedRefund(payment, 0);
			productUtil.log.info("주문취소 결과 cancelResult={}", cancelResult);
			
			// 결제 취소 여부에 따라 결과 세팅
			result = (0 < cancelResult.getDmlResult()) ? "refunded" : "errorRefund";
			
			if("errorRefund".equals(result)) {
				productUtil.log.info("큰일이다...");
			}
		}
		
		// DB의 주문 금액 값 과 비교(세션 말고 서비스단에서 DB조회한걸로) => 포트원 결제금액 사전등록 API로 해결
		
		// [3] result의 값에 따라 ResponseEntity의 상태코드 설정
		
		// 로직 성공 시
		if("success".equals(result)) {
			// 상태코드 ok설정
			response = ResponseEntity.ok();
		} else {
			// 그 외 result의 결과에 따라 상태코드 설정
			response = ("invalidParam".equals(result)) ? ResponseEntity.badRequest() : ResponseEntity.internalServerError();
		}
		
		// session의 주문 금액 삭제 => 이제 orderAmount는 저장 안함
		
		// [4] 반환할 값 설정
		
		// 반환할 값
		HashMap<String, String> orderResultMap = new HashMap();
		orderResultMap.put("result", result);
		orderResultMap.put("payStatus", payment.getPayStatus());
		
		// [5] 반환
		// 결과 반환
		return response.headers(productUtil.makeApplicationJsonHeader())
					   .body(orderResultMap);
	}
	
	
	
	/**
	 * 주문한 상품 정보 JSON형식 문자열을 자바 객체배열로 가공해 반환<br>
	 * 예외 발생 시 에러메세지 출력
	 * @param customData : 주문 상품 JSON형식 문자열
	 * @return : ArrayList &lt;OrderInfoDTO&gt;<br>
	 * 성공 시 OrderInfoDTO형태를 담은 자바 객체배열, 실패 시 null반환
	 */
	private ArrayList<OrderInfoDTO> fromJsonOrderInfoList(String orderInfo) {
		ArrayList<OrderInfoDTO> orderInfoList = null;
		try {
			orderInfoList = new Gson().fromJson(orderInfo,
							 new TypeToken<List<OrderInfoDTO>>() {}.getType());
		} catch(JsonParseException e) {
			productUtil.log.info("JSON 파싱 중 JsonParseException발생, 에러 메세지={}", e.getMessage());
		} catch(Exception e) {
			productUtil.log.info("JSON 파싱 중 Exception발생, 에러 메세지={}", e.getMessage());
		}
		finally {
			productUtil.log.info("customDataList={}", orderInfoList);
		}
		return orderInfoList;
	}
	
	
	
	/**
	 * 배열 내 OrderInfoDTO객체의 cartNo(카트번호), pdtOptionNo(상품 옵션 번호),
	 * orderQuantity(주문 수량)가 모두 양수인지 검증하는 메소드
	 * @param orderInfoList : 주문한 상품 정보가 들어있는 리스트
	 * @return : boolean<br>
	 * 모두 유효한 값일 시 true, 아닐 시 false
	 */
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
	
	
	/**
	 * 결제 취소(전체환불)하고 결과에 따라 payment(결제 정보)객체의 payStatus(결제 상태)
	 * @param payment : 환불할 상품정보가 담긴 객체
	 * @return : PaymentDTO<br>
	 * 모든 과정이 성공했을 시 파라미터로 받은 payment객체의 payStatus는 "refunded", 하나라도 실패했을 시 "errorRefund"
	
	private PaymentDTO processPaymenCancel(PaymentDTO payment) {
		// 결제 취소
		int cancelResult = paymentService.canclePayment(payment, 0);
		
		// 취소 후의 payStatus(결제 상태) 세팅
		payment.setPayStatus((0 < cancelResult) ? "refunded" : "errorRefund");
		
		// 취소 내역 DB 저장 => 서비스에서
		int insertResult = paymentService.insertPayment(payment);
		if(insertResult == 0) {
			
		}
		
		productUtil.log.info("insertPayment={}", insertResult);
		payment.setPayStatus()
		
		// 결제 상태가 세팅된 payment객체
		return payment;
	}
	 */

	
	
}
