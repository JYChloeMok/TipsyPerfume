package com.kh.ttp.productSale.cart.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class CartSelectVO {
	private int cartNo;
	private int userNo;
	private int pdtNo;
	private int cartQuantity;
	
	private int pdtPrice;
	private String pdtName;
	private String pdtShipping;
	
	private int pdtOptionNo;
	private String pdtOptionFirst;
	private String pdtOptionPrice;
	
	private int pdtFileNo;
	private String pdtFileUpload;
	
	private String pdtManufac;
	
	private int fundingNo;
	private String cuttingDate;
	private int fundingFee;
	private int cuttingPrice;
	
	private int total;
	
	
	
	
}
