package com.kh.ttp.productSale.order.model.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderVO extends OrderDetailVO {
	/*
	ORDER_NO	NUMBER
	USER_NO	NUMBER
	RECEIVER_NO	NUMBER
	ORDER_DATE	DATE
	ORDER_EST_DATE	DATE
	ORDER_ARRIV_DATE	DATE
	ORDER_MESSAGE	VARCHAR2(90 BYTE)
	*/
	private int userNo;
	private int ReceiverNo;
	private String orderDate;
	private String orderEstDate;
	private String orderArrivDate;
	private String orderMessage;

}
