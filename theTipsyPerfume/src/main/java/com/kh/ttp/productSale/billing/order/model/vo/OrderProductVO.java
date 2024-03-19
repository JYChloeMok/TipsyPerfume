package com.kh.ttp.productSale.billing.order.model.vo;

import java.util.List;

import com.kh.ttp.productSale.product.model.vo.ProductVO;

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
	
	private List<ProductVO> orderProductList;
}
