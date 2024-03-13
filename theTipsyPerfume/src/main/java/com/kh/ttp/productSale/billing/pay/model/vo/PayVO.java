package com.kh.ttp.productSale.billing.pay.model.vo;


import com.kh.ttp.productSale.billing.order.model.vo.OrderDetailVO;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class PayVO extends OrderDetailVO {

	/*
	PAY_NO	NUMBER
	PAY_METHOD	VARCHAR2(1 BYTE)
	PAY_TOTAL	NUMBER
	PAY_ADJUST	NUMBER
	PAY_BANK	VARCHAR2(50 BYTE)
	PAY_NAME	VARCHAR2(20 BYTE)
	PAY_STATUS	VARCHAR2(1 BYTE)
	PAY_DATE	DATE
	*/
	
	private String payMethod;
	private int payTotal;
	private int payAdjust;
	private String payBank;
	private String payName;
	private String payStatus;
	private String payDate;
	
}
