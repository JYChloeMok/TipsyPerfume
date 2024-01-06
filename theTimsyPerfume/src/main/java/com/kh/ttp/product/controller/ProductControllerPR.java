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

	/**
	 * 프로덕트 서비스의 인터페이스
	 */
	private final ProductServicePR productService;
	
	
	/**
	 * 에러 발생 시 사용되는 ModelAndView객체를 설정하는 메소드
	 * @param errorMsg : 에러 시 출력할 메세지
	 * @return ModelAndView : 에러 메세지(Model)와 에러 페이지의 경로(View) 정보를 담음
	 */
	private ModelAndView makeErrorMsg(ModelAndView mv, String errorMsg) {
		
		mv.addObject("errorMsg", errorMsg)
		  .setViewName("common/errorPage");
		return mv;
	}
	
	
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
			  .setViewName("product/productMain");
		} else {
			makeErrorMsg(mv, "상품 메인화면 이동 실패...");
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
	@GetMapping("perfumePdtList.pr")
	public ModelAndView perfumePdtList(ModelAndView mv,
									   @RequestParam(value="sort", defaultValue="New") String sort,
									   @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = productService.productCount("F");
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 12, 10);
		mv.addObject("pi", pi)
		  .addObject("sort", sort)
		  .addObject("pdtCteg", "F") // 향수 식별자(사이드바 정렬보기 요청 시 필요)
		  .addObject("pdtList", productService.perfumePdtList(sort, pi))
		  .setViewName("product/productList");
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
	@GetMapping("alcoholPdtList.pr")
	public ModelAndView alcoholPdtList(ModelAndView mv,
								 	   @RequestParam(value="sort", defaultValue="New") String sort,
								 	   @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = productService.productCount("A");
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 12, 10);
		mv.addObject("pi", pi)
		  .addObject("sort", sort)
		  .addObject("pdtCteg", "A")
		  .addObject("pdtList", productService.alcoholPdtList(sort, pi))
		  .setViewName("product/productList");
		return mv;
	}
	
	
	/**
	 * 향수 디테일 조회   : 특정 향수상품 1개의 정보를 조회하는 메소드
	 * @param mv	: ModelAndView객체
	 * @param pdtNo : 상품의 번호(DB의 Primary Key)
	 * @return ModelAndView : 모델 영역에 페이지 표시에 필요한 정보(향수 이름, 설명 등)로 필드가 초기화된 객체가 담김
	 */
	@GetMapping("perfumePdtDetail.pr")
	public ModelAndView perfumePdtDetail(ModelAndView mv, @RequestParam(value="pdtNo", defaultValue="0") int pdtNo) {
		if(pdtNo > 0) {
			mv.addObject("pdtDetail", productService.perfumePdtDetail(pdtNo))
			  .setViewName("product/productDetail");
		} else {
			makeErrorMsg(mv, "상품 번호가 올바르지 않습니다!<br>나중에 다시 시도해주세요.");
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
	@GetMapping("alcoholPdtDetail.pr")
	public ModelAndView alcoholPdtDetail(ModelAndView mv, @RequestParam(value="pdtNo", defaultValue="0") int pdtNo) {
		
		if(pdtNo > 0) {
			mv.addObject("pdtDetail", productService.alcoholPdtDetail(pdtNo))
			  .setViewName("product/productDetail");
		} else {
			makeErrorMsg(mv, "상품 번호가 올바르지 않습니다!<br>나중에 다시 시도해주세요.");
		}
		return mv;
	}
	
	
	/* ------------------------------------------------------------------------------------- */
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
