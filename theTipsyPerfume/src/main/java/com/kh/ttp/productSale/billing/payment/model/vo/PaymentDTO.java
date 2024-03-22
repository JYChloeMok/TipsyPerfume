package com.kh.ttp.productSale.billing.payment.model.vo;

import java.util.List;

import com.kh.ttp.productSale.billing.order.model.vo.OrderInfoDTO;

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
public class PaymentDTO {

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
	
	private List<OrderInfoDTO> orderInfoList;
	
}
