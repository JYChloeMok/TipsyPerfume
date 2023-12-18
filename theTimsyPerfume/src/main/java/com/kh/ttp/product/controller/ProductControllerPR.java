package com.kh.ttp.product.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.product.model.service.ProductServicePR;
import com.kh.ttp.product.model.vo.ProductSelectVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ProductControllerPR {

	private final ProductServicePR productService;
	
	
	// AF / 6개 12개 // New / BestSeller / Popular // 다 넘기고 전부 mybatis에서 검증
	/**
	 * @param pdtCteg : 주류 향수 구분, 주류 = A, 향수 = F
	 * @return
	 * ModelAndView의 pdtCteg : 주류/향수 구분 식별자<br>
	 * ModelAndView의 pMap :<br>
	 * 식별자(pdtCteg)에 따라 주류/향수를 각각 최신순, 베스트셀러순, 위시리스트순으로 조회한다<br>
	 * 각 정렬 기준 별 조회 결과를 각각 ArrayList(ProductSelectVO리터럴)에 담은 후<br>
	 * 만들어진 3개의 ArrayList를 HashMap<String, Object>에 담고,<br>
	 * 이 HashMap을 ModelAndView에 pMap이라는 키값으로 담는다
	 *//*
	@GetMapping("productMain.pr") // productMain.pr?pdtCteg=A
	public ModelAndView productMainList(@RequestParam(value="sort", defaultValue="New") String sort, String pdtCteg, ModelAndView mv) {
		
		if("A".equals(pdtCteg) || "F".equals(pdtCteg)) {
			int listCount = productService.selectProductCount(pdtCteg);
			PageInfo pi = Pagination.getPageInfo(listCount, 1, 6, 10);

			mv.addObject("pMap", productService.productMainList(pdtCteg, pi))
			  .addObject("pdtCteg", pdtCteg) 														// 주류 / 향수 식별자
			  .addObject("sort", sort)
			  .setViewName("product/productMain");
		} else {
			mv.addObject("errorMsg", "상품 메인화면 이동 실패...")
			  .setViewName("common/errorPage");
		}
		return mv;
	}
	*/
	
	@GetMapping("productMain.pr")
	public ModelAndView productMainList(String pdtCteg,
										ModelAndView mv,
										@RequestParam(value="sort", defaultValue="New") String sort) {
		if("A".equals(pdtCteg) || "F".equals(pdtCteg)) {
			int listCount = productService.selectProductCount(pdtCteg);
			PageInfo pi = Pagination.getPageInfo(listCount, 1, 6, 10);
			mv.addObject("sort", sort)
			  .addObject("pdtCteg", pdtCteg) 													               	// 주류 / 향수 식별자
			  .addObject("pMap", productService.productMainList(pdtCteg, pi))
			  .setViewName("product/productMain");
		} else {
			mv.addObject("errorMsg", "상품 메인화면 이동 실패...")
			  .setViewName("common/errorPage");
		}
		return mv;
	}
	
	
	// 향수 전체조회
	@GetMapping("selectPerfumePdtList.pr")
	public String selectPerfumePdtList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									   @RequestParam(value="sort", defaultValue="New") String sort,
									   Model m) {
		
		int listCount = productService.selectProductCount("F");
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 12, 10);
		
		m.addAttribute("pdtCteg", "F") // 향수도 식별자 넘겨야함(사이드바 정렬보기 요청 시 필요)
		 .addAttribute("sort", sort)
		 .addAttribute("pdtList", productService.selectPerfumePdtList(sort, pi))
		 .addAttribute("pi", pi);
		return "product/productList";
	}
	
	
	// 향수 디테일조회
	@GetMapping("perfumePdtDetail.pr") // pdtNo, F
	public ModelAndView perfumePdtDetail(@RequestParam(value="pdtNo", defaultValue="0") int pdtNo,
								   ModelAndView mv) {
		if(pdtNo > 0) {
			mv.addObject("pdtDetail", productService.perfumePdtDetail(pdtNo))
			  .setViewName("product/productDetail");
		} else {
			mv.addObject("errorMsg", "상품 번호가 올바르지 않습니다")
			  .setViewName("common/errorPage");
		}
		return mv;
	}
	
	// 주류전체조회
	@GetMapping("selectAlcoholPdtList.pr") // 성인 인터셉터 거침(세션에 N)
	public String selectAlcoholPdtList(@RequestParam(value="sort", defaultValue="New") String sort,
									   @RequestParam(value="currentPage", defaultValue="1") int currentPage,
									   Model m) {
		int listCount = productService.selectProductCount("A");
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 12, 10);
		
		m.addAttribute("pdtCteg", "A")
		 .addAttribute("sort", sort)
		 .addAttribute("pdtList", productService.selectAlcoholPdtList(sort, pi))
		 .addAttribute("pi", pi);
		
		return "product/productList";
	}
	
	// 주류 디테일조회
	@GetMapping("alcoholPdtDetail.pr") // 성인 인터셉터 거침(세션에 N)
	public ModelAndView alcoholPdtDetail(@RequestParam(value="pdtNo", defaultValue="0") int pdtNo,
										 ModelAndView mv) {
		if(pdtNo > 0) {
			mv.addObject("pdtDetail", productService.alcoholPdtDetail(pdtNo))
			  .setViewName("product/productDetail");
		} else {
			mv.addObject("errorMsg", "상품 번호가 올바르지 않습니다")
			  .setViewName("common/errorPage");
		}
		return mv;
	}
	
	
	// 카트 메인 가기
	@GetMapping("cartMain.ca")
	public String cartMain(ModelAndView mv, HttpSession session) {
//		if(null != session.getAttribute("loginUser")) {
//			mv.addObject("cartList", productService.cartMain(((User)session.getAttribute("loginUser")).getUserNo()))
//			  .setViewName("orderKinds/cartMain");
//		} else {
//			mv.addObject("errorMsg", "장바구니 조회 실패").setViewName("common/errorPage");
//		}
//		return mv;
		return "orderKinds/cartMain";
	}
	
	
	@GetMapping("orderSheet.pr")
	public String orderSheet() {
		return "orderKinds/OrderSheet";
	}
	
	
}
