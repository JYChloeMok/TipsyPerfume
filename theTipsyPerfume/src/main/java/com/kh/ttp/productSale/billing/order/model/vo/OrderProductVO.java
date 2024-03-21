package com.kh.ttp.productSale.billing.order.model.vo;

import java.util.List;

import com.kh.ttp.productSale.product.model.vo.ProductVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString @Builder
public class OrderProductVO {
	
	private int orderNo;
	// private int pdtOptionNo;

	private int orderQuantity;
	private ProductVO product;
	private ProductOptionVO productOption;
	
	private List<OrderProductVO> orderProductList;
	
	/*
	public void setOrderQuantity(int orderQuantity) {
		if(0 < orderQuantity) {
			this.orderQuantity = orderQuantity;
		} else {
			throw new IllegalArgumentException("수량은 음수일 수 없습니다.");
		}
	}
	*/
}
