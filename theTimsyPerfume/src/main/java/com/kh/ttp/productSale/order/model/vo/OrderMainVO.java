package com.kh.ttp.productSale.order.model.vo;

import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class OrderMainVO {
	
	private int totalPrice;
	private String pdtName;
	private String pdtShipping;
	
	private OrderVO order;
	private CartVO cart;
	private ProductOptionVO productOption;
		
}
