package com.kh.ttp.productSale.billing.order.model.vo;

import java.util.List;

import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class OrderDTO {
	
	/*
	ORDER_NO
	USER_NO
	RECEIVER_NO
	PAYMENT_NO
	ORDER_DATE
	ORDER_ARRIVAL_DATE
	ORDER_MESSAGE
	*/
	
	private int orderNo;
	private String orderDate;
	private String orderArrivalDate;
	private String orderMessage;
	
	// 수령인 / userNo, ReceiverNo
	private ReceiverDTO receiver;
	
	// 결제 / paymentNo
	private PaymentDTO payment;

	// 주문 상품
	private List<OrderProductDTO> orderProductList;
	
}
