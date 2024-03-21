package com.kh.ttp.productSale.billing.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString
public class OrderCustomData {
	
	private int cartNo;
	private int pdtOptionNo;
	private int orderQuantity;

}
