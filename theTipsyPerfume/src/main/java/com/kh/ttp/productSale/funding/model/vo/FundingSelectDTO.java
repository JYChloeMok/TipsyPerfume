package com.kh.ttp.productSale.funding.model.vo;

import java.sql.Date;

import com.kh.ttp.productSale.product.model.vo.ProductDTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString
public class FundingSelectDTO extends ProductDTO {

	private int pdtFileNo;
	private String pdtFilePath;
	private String pdtFileOrigin;
	private String pdtFileUpload;
	private String pdtManufac;
	private String pdtGroup;
	private int pdtOptionNo;
	private String pdtOptionFirst;
	private String pdtOptionSecond;
	private int fundingNo;
	private Date cuttingDate;
	private int fundingFee;
	private int cuttingPrice;
	private int pdtOptionPrice;
	private int pdtOptionStock;
	

}
