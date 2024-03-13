package com.kh.ttp.productSale.billing.order.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.productSale.billing.order.model.service.OrderService;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/order/")
@RequiredArgsConstructor
public class AjaxOrderController {
	
	private final OrderService orderService;
	
	// 주문 생성
	//@PostMapping("/")
	//public ResponseEntity<String> insertOrder() {
		
	//}
	
	
	// 주문페이지에서 결제버튼 클릭 시 가맹점 주문번호 MERCHANT_UID 생성
	//@GetMapping("pay")
	/*
	// 사전 등록
	@ResponseBody
	@RequestMapping("preparePayment") // 실제로는 Get으로 써야하는 요청이지만 Post사용 = 추후 변경될 수 있으니 RequestMapping
	public PaymentVO preparePayment(@RequestBody ArrayList<OrderProductVO> orderProduct) {
		System.out.println(orderProduct);
		
		// 들어온 아이템들 DB에 있는지 확인
		
		
		// 금액 계산
		
		// 주문번호 채번 ("pid"문자열, 현재 시간 밀리초, 1 ~ 100사이 난수)
		int amount = 400000;
		String merchantUid = "pid" + System.currentTimeMillis() + ((int)(Math.random() * 100) + 1);
		PaymentVO payment = PaymentVO.builder()
				 					 .amount(amount)
				 					 .merchantUid(merchantUid)
				 					 .build();
		// 주문정보 저장
		return payment;
	}
	
	// 주문 생성 요청
	@ResponseBody
	@PostMapping("orderMethod")
	public String orderProduct(@RequestBody ArrayList<OrderProductVO> orderProduct) throws MalformedURLException, IOException {
		
		if(orderProduct == null) {
			return "ERROR";
		}
		
		// 유저정보 얻기
		

		
		// 상품 주문정보 생성(주문시도 상태 30분 이상 지나면 주문실패)
		OrderDetailVO.builder()
					 .orderProduct(orderProduct)
					 .build();
		
		// 재고 체크 및 감소
		
		// 결제요청
		
		return "success";
	}
	*/
	
	
	
}