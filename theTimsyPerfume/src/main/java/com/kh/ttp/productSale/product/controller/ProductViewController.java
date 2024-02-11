package com.kh.ttp.productSale.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.common.template.Pagination;
import com.kh.ttp.productSale.common.ProductSaleUtil;
import com.kh.ttp.productSale.product.model.service.ProductService;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class ProductViewController {

	
	private ProductSaleUtil productUtil;
	
	private final ProductService productService;
	
	
	/**
	 * 상품 메인 조회 기능   : 상품 분류, 정렬 식별자에 따라 상품을 조회한 후</br>
	 * 정렬 기준 별 조회결과ArrayList들을 HashMap에 담아 반환
	 * @param mv	  : ModelAndView객체
	 * @param pdtCteg : 상품 카테고리 구분용 식별자 ("A" 주류 / "F" 향수)
	 * @param sort    : 정렬 기준 ("New" 최신순 / "BestSeller" 베스트셀러순 / "Popular" 위시리스트순
	 * @return ModelAndView : sort(정렬 기준), pdtCteg(상품 분류), pMap(조회 결과 HashMap)
	 */
	@GetMapping("productMain.pr")
	public ModelAndView productMain(ModelAndView mv,
									String pdtCteg,
									@RequestParam(value="sort", defaultValue="New") String sort) {
		
		if("A".equals(pdtCteg) || "F".equals(pdtCteg)) {
			mv.addObject("sort", sort)
			  .addObject("pdtCteg", pdtCteg)
			  .addObject("pMap", productService.productMain(pdtCteg))
			  .setViewName("productSale/productMain");
		} else {
			productUtil.makeErrorMsg(mv, "상품 메인화면 이동 실패...");
		}
		return mv;
	}
	

	/**
	 * 향수 리스트 조회 기능        : 조회 요청하는 페이지의 향수 상품을 조회해 ArrayList를 반환 
	 * @param mv    	  : ModelAndView객체
	 * @param sort        : 상품 정렬 기준
	 * @param currentPage : 현재 페이지
	 * @return ModelAndView : pi(페이지네이션 정보), sort(정렬 기준), pdtList(조회된 상품 리스트), pdtCteg(상품 분류)가 담김
	 */
	@GetMapping("perfumeList.pr")
	public ModelAndView perfumeList(ModelAndView mv,
									   @RequestParam(value="sort", defaultValue="New") String sort,
									   @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = productService.productCount("F");
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 12, 10);
		mv.addObject("pi", pi)
		  .addObject("sort", sort)
		  .addObject("pdtCteg", "F") // 향수 식별자(사이드바 정렬보기 요청 시 필요)
		  .addObject("pdtList", productService.perfumeList(sort, pi))
		  .setViewName("productSale/productList");
		return mv;
	}
	
	
	/**
	 * 주류 리스트 조회 기능        : 조회 요청하는 페이지의 주류 상품을 조회해 ArrayList를 반환</br>
	 * 로그인한 성인유저인지 검증하는 인터셉터(AdultValidationInterceptor)를 통과해야 이용 가능
	 * @param mv    	  : ModelAndView객체
	 * @param sort        : 상품 정렬 기준
	 * @param currentPage : 현재 페이지
	 * @return ModelAndView : pi(페이지네이션 정보), sort(정렬 기준), pdtList(조회된 상품 리스트), pdtCteg(상품 분류)가 담김
	 */
	@GetMapping("alcoholList.pr")
	public ModelAndView alcoholList(ModelAndView mv,
								 	@RequestParam(value="sort", defaultValue="New") String sort,
								 	@RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = productService.productCount("A");
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 12, 10);
		mv.addObject("pi", pi)
		  .addObject("sort", sort)
		  .addObject("pdtCteg", "A")
		  .addObject("pdtList", productService.alcoholList(sort, pi))
		  .setViewName("productSale/productList");
		return mv;
	}
	
	
	/**
	 * 향수 디테일 조회   : 특정 향수상품 1개의 정보를 조회하는 메소드
	 * @param mv	: ModelAndView객체
	 * @param pdtNo : 상품의 번호(DB의 Primary Key)
	 * @return ModelAndView : 모델 영역에 페이지 표시에 필요한 정보(향수 이름, 설명 등)로 필드가 초기화된 객체가 담김
	 */
	@GetMapping("perfumeDetail.pr")
	public ModelAndView perfumeDetail(ModelAndView mv, @RequestParam(value="pdtNo", defaultValue="0") int pdtNo) {
		if(pdtNo > 0) {
			mv.addObject("pdtDetail", productService.perfumeDetail(pdtNo))
			  .setViewName("productSale/productDetail");
		} else {
			productUtil.makeErrorMsg(mv, "상품 번호가 올바르지 않습니다!<br>나중에 다시 시도해주세요.");
		}
		return mv;
	}
	
	
	/**
	 * 주류 디테일 조회   : 특정 주류상품 1개의 정보를 조회하는 메소드</br>
	 * 로그인한 성인유저인지 검증하는 인터셉터(AdultValidationInterceptor)를 통과해야 이용 가능
	 * @param mv	: ModelAndView객체
	 * @param pdtNo : 상품의 번호(DB의 Primary Key)
	 * @return ModelAndView : 모델 영역에 페이지 표시에 필요한 정보(주류 이름, 설명 등)로 필드가 초기화된 객체가 담김
	 */
	@GetMapping("alcoholDetail.pr")
	public ModelAndView alcoholPdtDetail(ModelAndView mv, @RequestParam(value="pdtNo", defaultValue="0") int pdtNo) {
		
		if(pdtNo > 0) {
			mv.addObject("pdtDetail", productService.alcoholDetail(pdtNo))
			  .setViewName("productSale/productDetail");
		} else {
			productUtil.makeErrorMsg(mv, "상품 번호가 올바르지 않습니다!<br>나중에 다시 시도해주세요.");
		}
		return mv;
	}

	
	
}
