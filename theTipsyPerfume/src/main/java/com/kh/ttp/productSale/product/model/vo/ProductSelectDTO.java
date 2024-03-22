package com.kh.ttp.productSale.product.model.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString
public class ProductSelectDTO extends ProductDTO {
	
	//private ProductVO productVo;
	private float reviewAvg;
	
	private String pdtCteg;
	private String pdtManufac;
	private String pdtGroup;
	
	private int pdtFileNo;
	private int pdtFileIndex;
	private String pdtImgSrc;

}
