package com.kh.ttp.productSale.order.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter@Setter@NoArgsConstructor
public class OrderProductVO {

	private int orderDetailNo;
	private int pdtNo;
	private int pdtOptionNo;
	private int orderQuantity;
	
}
