package com.kh.ttp.productSale.billing.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class OrderVO {
	/*
	ORDER_NO	NUMBER
	USER_NO	NUMBER
	RECEIVER_NO	NUMBER
	ORDER_DATE	DATE
	ORDER_EST_DATE	DATE
	ORDER_ARRIV_DATE	DATE
	ORDER_MESSAGE	VARCHAR2(90 BYTE)
	*/
	/*
	"ORDER_NO"	NUMBER
	"USER_NO"	NUMBER
	"RECEIVER_NO"	NUMBER
	"MERCHANT_UID"	VARCHAR2(300)
	"ORDER_DATE"	DATE
	"ORDER_ARRIV_DATE"	DATE
	"ORDER_MESSAGE"	VARCHAR2(90)
	*/
	private int orderNo;
	private int userNo;
	private int ReceiverNo;
	private String merchantUid;
	private String orderDate;
	private String orderArrivalDate;
	private String orderMessage;
	
	

}
