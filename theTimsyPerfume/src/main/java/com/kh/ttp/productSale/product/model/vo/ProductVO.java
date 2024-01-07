package com.kh.ttp.productSale.product.model.vo;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class ProductVO {
	
	private int pdtNo;
	private int pdtCategNo;
	private String pdtName;
	private int pdtPrice;
	private int pdtStock;
	private String pdtDate;
	private String pdtIntro;
	private String pdtDescription;
	private String pdtIngredient;
	private String pdtShipping;
	private int pdtCount;
	private int pdtDiscount;
	private String pdtStatus;
	private String pdtGpStatus;
	
	private int orderPrice;
	private int orderQuantity;
	
	
}
