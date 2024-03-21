package com.kh.ttp.productSale.billing.order.model.vo;

import com.kh.ttp.productSale.billing.payment.model.vo.PaymentVO;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class OrderVO extends OrderProductVO {
		
	private int orderNo;
	private String orderDate;
	private String orderArrivalDate;
	private String orderMessage;

	// 결제
	private PaymentVO payment;
	// private int PaymentNo;
	
	// 수령인
	private ReceiverVO receiver;
	// private int userNo;
	// private int ReceiverNo;
	
	// 주문 상품
	private OrderProductVO orderProduct;

}
