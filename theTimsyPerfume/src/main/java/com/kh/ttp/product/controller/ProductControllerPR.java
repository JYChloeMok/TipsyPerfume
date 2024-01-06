package com.kh.ttp.product.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.product.model.service.ProductServicePR;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ProductControllerPR {

	private final ProductServicePR productService;
	
	/**
	 * @param mv	   : ModelAndView객체 (에러 메세지와 에러페이지의 정보)
	 * @param errorMsg : 에러 시 출력할 메세지
	 * @return : 에러 메세지, 에러 페이지 정보를 담은 ModelAndView객체를 반환
	 */
	private ModelAndView makeErrorMsg(ModelAndView mv, String errorMsg) {
		mv.addObject("errorMsg", errorMsg)
		  .setViewName("common/errorPage");
		return mv;
	}
	
	
	/**
	 * 상품 메인 조회 기능   : 상품 분류, 정렬 식별자에 따라 상품을 조회한 후</br>
	 * 정렬 기준 별 조회결과ArrayList들을 HashMap에 담아 반환
	 * @param pdtCteg : 상품 카테고리 구분용 식별자 ("A" 주류 / "F" 향수)
	 * @param sort    : 정렬 기준 ("New" 최신순 / "BestSeller" 베스트셀러순 / "Popular" 위시리스트순
	 * @return : ModelAndView객체 = sort, pdtCteg, pMap(조회결과 HashMap)
	 */
	@GetMapping("productMain.pr")
	public ModelAndView productMainList(String pdtCteg,
										ModelAndView mv,
										@RequestParam(value="sort", defaultValue="New") String sort) {
		
		if("A".equals(pdtCteg) || "F".equals(pdtCteg)) {
			mv.addObject("sort", sort)
			  .addObject("pdtCteg", pdtCteg)
			  .addObject("pMap", productService.productMainList(pdtCteg))
			  .setViewName("product/productMain");
		} else {
			makeErrorMsg(mv, "상품 메인화면 이동 실패...");
		}
		return mv;
	}
	

	/**
	 * @param currentPage
	 * @param sort
	 * @param m
	 * @return
	 */
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
	public ModelAndView cartMain(ModelAndView mv, HttpSession session) { // 로그인 인터셉터
		mv.addObject("cartList", productService.cartMain(((User)session.getAttribute("loginUser")).getUserNo()))
		  .setViewName("orderKinds/cartMain");
		return mv;
		//System.out.println(productService.cartMain(((User)session.getAttribute("loginUser")).getUserNo()));
	}
	
	
	@GetMapping("orderSheet.pr")
	public String orderSheet() {
		return "orderKinds/OrderSheet";
	}
	
	
}
