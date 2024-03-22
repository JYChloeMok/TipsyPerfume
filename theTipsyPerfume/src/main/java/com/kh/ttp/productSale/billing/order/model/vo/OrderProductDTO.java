package com.kh.ttp.productSale.billing.order.model.vo;

import com.kh.ttp.productSale.product.model.vo.ProductDTO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionDTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString
public class OrderProductDTO {
	
	/*
		ORDER_NO
		PDT_OPTION_NO
		ORDER_QUANTITY
	 */
	private int orderQuantity;
	private ProductDTO product;
	private ProductOptionDTO productOption;
	
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
