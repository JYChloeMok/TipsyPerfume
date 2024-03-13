package com.kh.ttp.productSale.productInfo.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class ProductOptionVO {
	
	private int pdtOptionNo;
	private int pdtNo;
	private String pdtOptionFirst;
	private String pdtOptionSecond;
	
	private int pdtOptionPrice;
	private int pdtOptionStock;

}
