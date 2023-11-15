package com.kh.ttp.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttp.product.model.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;

	/**
	 * 상품 메인페이지 조회 기능
	 * @return
	 */
	@GetMapping("productMain.pr")
	public String productMain(@RequestParam (value="pdtIdenKey", defaultValue="M")String pdtIdenKey,
											 int pdtNo) { // Q.알아서 관리하니까 불변객체 자원소모는 신경 안써도 되나?
		
		if("A".equals(pdtIdenKey.toUpperCase())) {
			// 알콜 조회 A
			System.out.println("알콜조회");
			
			
			
		} else if("P".equals(pdtIdenKey.toUpperCase())) {
			// 향수 조회 P
			System.out.println("향수조회");
			
			
			
		} else {
			System.out.println("기타등등");
			// common/errorPage  ${ errorMsg }
		}
		System.out.println("스코프 밖");
		
		// pdtIdenKey넘겨줘야함 (식별자 보고 div띄워줄 것) 
		return "product/productMain";
	}

}
