package com.kh.ttp.productSale.billing.order.controller;

import org.json.simple.JSONArray;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/order")
@RequiredArgsConstructor
public class AjaxOrderController {
	
	private final ProductSaleUtil productUtil;
	private final OrderService orderService;
	
	// 주문 생성
	//@PostMapping("/")
	//public ResponseEntity<String> insertOrder() {
		
	//}

	
	
	// 주문 생성
	@PostMapping
	public String createOrder(@RequestBody PaymentVO payment) { // customData : 주문 상품 정보(개수 등) 객체배열
		
		productUtil.log.info("payment={}", payment.getCustomData());
		
		
		/*
		 * // Json형식 문자열 객체로 변환 List<ProductVO> orderProductList = new ArrayList();
		 * orderProductList = new Gson().fromJson(paymentResult.getCustomData(), new
		 * TypeToken<ArrayList<ProductVO>>() {}.getType());
		 * 
		 * // 상품 번호만 Integer형 리스트로 추출해서 서비스 넘기기 List<Integer> pdtNoArr = new
		 * ArrayList(); for(ProductVO pValue : orderProductList) {
		 * pdtNoArr.add(pValue.getPdtNo()); }
		 * 
		 * productUtil.log.info("pdtNoArr={}", pdtNoArr);
		 */
		
		//orderService.createOrder(paymentResult);
		return payment.toString();
	}
	
	
	
}
