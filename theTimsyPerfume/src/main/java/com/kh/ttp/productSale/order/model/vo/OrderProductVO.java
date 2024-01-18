package com.kh.ttp.productSale.order.model.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class OrderProductVO {

	private int orderNo;
	private int pdtOptionNo;
	private int orderQuantity;
}
