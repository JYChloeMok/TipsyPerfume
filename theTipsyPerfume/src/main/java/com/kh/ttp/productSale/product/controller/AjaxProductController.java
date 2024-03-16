package com.kh.ttp.productSale.product.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.product.model.service.ProductService;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;

import lombok.RequiredArgsConstructor;

@CrossOrigin("*")
@RestController
@RequestMapping("/product/")
@RequiredArgsConstructor
public class AjaxProductController {

	
	private final ProductSaleUtil productUtil;
	private final ProductService productService;

	
	/**
	 * 상품 번호로 상품이 가진 옵션을 조회하는 메소드
	 * @param pdtNo : 상품 번호
	 * @return : 특정 상품의 옵션들이 담긴 ArrayList
	 */
	@GetMapping("option/{pdtNo}")
	public ResponseEntity ajaxProductOption(@PathVariable(name="pdtNo") int pdtNo) {
		return (pdtNo <= 0) ? productUtil.makeAjaxErrorResult()
							: new ResponseEntity<List<ProductOptionVO>>(productService.ajaxProductOption(pdtNo),
																		productUtil.makeHeader("application", "json", "UTF-8"),
																		HttpStatus.OK);
	}
	
	
	/**
	 * 상품 번호, rowNum(여기서는 2)로 최신순 리뷰 2개를 조회하는 메소드
	 * @param pdtNo : 상품 번호
	 * @return
	 */
	@GetMapping("reviews/{pdtNo}/row-num/{rowNum}")
	public ResponseEntity ajaxSelectRecentTwoReview(@PathVariable(name="pdtNo") int pdtNo,
													@PathVariable(name="rowNum") int rowNum) {
		if(pdtNo > 0 && rowNum < 11) {
			HashMap<String, Integer> pMap = new HashMap();
			pMap.put("pdtNo", pdtNo);
			pMap.put("rowNum", rowNum);
			return new ResponseEntity<List<ReviewVO>>(productService.selectRecentReviewWithRownum(pMap),
													  productUtil.makeHeader("application", "json", "UTF-8"),
													  HttpStatus.OK);
		}
		return productUtil.makeAjaxErrorResult();
	}
	
	

	
	
	
	
}
