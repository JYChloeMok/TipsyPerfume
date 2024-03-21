package com.kh.ttp.productSale.billing.payment.model.vo;

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
public class PaymentVO {

	private int paymentNo;
	private int paidAmount;
	
	private String applyNum;
	
	private String impUid;
	private String merchantUid;
	private String pgTid;
	private String pgProvider;
	private String payMethod;

	private String paidAt;
	private String payStatus;
	private String customData;
	
}
