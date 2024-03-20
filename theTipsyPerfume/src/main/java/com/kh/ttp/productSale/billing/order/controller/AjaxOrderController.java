package com.kh.ttp.productSale.billing.order.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.kh.ttp.productSale.billing.order.model.service.OrderService;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.product.model.vo.ProductVO;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin("*")
@RequestMapping("/order/")
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
	public String insertOrder(PaymentVO paymentResult, List<ProductVO> orderProductList, List<Integer> pdtNoArr) {
		
		productUtil.log.info("paymentResult={}", paymentResult);
		
		orderProductList = new Gson().fromJson(paymentResult.getCustomData(),
						   new TypeToken<ArrayList<ProductVO>>() {}.getType());
		
		for(ProductVO pValue : orderProductList) {
			pdtNoArr.add(pValue.getPdtNo());
		}
		
		productUtil.log.info("pdtNoArr={}", pdtNoArr);
		
		orderService.createOrder(paymentResult, pdtNoArr);
		return "success";
	}
	
	
	
}
