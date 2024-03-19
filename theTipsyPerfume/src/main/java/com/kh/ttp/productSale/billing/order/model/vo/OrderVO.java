package com.kh.ttp.productSale.billing.order.model.vo;

import com.kh.ttp.productSale.receiver.model.vo.ReceiverVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class OrderVO {

	private int orderNo;
	private int userNo;
	private int ReceiverNo;
	private int PaymentNo;
	
	private String orderDate;
	private String orderArrivalDate;
	private String orderMessage;
	
	// 주문상품, 수령인
	private ReceiverVO receiver;
	private OrderProductVO orderProduct;
	
	

}
