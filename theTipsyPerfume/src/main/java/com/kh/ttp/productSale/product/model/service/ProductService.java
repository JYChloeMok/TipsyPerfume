package com.kh.ttp.productSale.product.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.productSale.cart.model.vo.CartMainVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.product.model.vo.ProductSelectVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;
import com.kh.ttp.productSale.wishlist.model.vo.WishlistVO;

public interface ProductService {
	
	/**
	 * 판매중 상태의 주류 혹은 향수 상품의 전체 개수를 조회
	 * @param pdtCteg : 상품 카테고리 구분용 식별자 ("A" 주류 / "F" 향수)
	 * @return : 전체 상품의 개수 조회(COUNT) 개수를 반환
	 */
	int productCount(String pdtCteg);

	
	// 프로젝트 메인 조회 메소드(SELECT)
	/**
	 * 주류/향수 식별자(pdtCteg)를 받아 해당되는 상품을 각각 최신순, 베스트셀러순, 위시리스트순으로 조회한다
	 * @param pdtCteg   : 주류 향수 구분, 주류 = A, 향수 = F
	 * @param rowBounds : 페이지네이션을 위한 RowBounds객체
	 * @return
	 * 식별자(pdtCteg)에 따라 주류/향수를 각 정렬 기준별로, 즉 3회 조회한다<br> 
	 * 그 후 결과를 각각 ArrayList(ProductSelectVO리터럴)에 담은 후<br>
	 * 만들어진 3개의 ArrayList를 아래의 키값과 함께 HashMap<String, Object>에 담아 반환한다<br> 
	 * 최신순ArrayList	  : pMainListNew<br>
	 * 판매량순ArrayList    : pMainListBestSeller<br>
	 * 위시리스트순ArrayList : pMainListPopular<br>
	 */
	HashMap<String, Object> productMain(String pdtCteg);
	
	// 향수 전체조회 perfumePdtList
	ArrayList<ProductSelectVO> perfumeList(String sort, PageInfo pi);
	
	// 향수 디테일조회 perfumePdtDetail
	ProductSelectVO perfumeDetail(int pdtNo);
	
	// 주류 전체조회 alcoholPdtList
	ArrayList<ProductSelectVO> alcoholList(String sort, PageInfo pi);
	
	// 주류 디테일조회 alcoholPdtDetail
	ProductSelectVO alcoholDetail(int pdtNo);
	
	
	
	/***************** ajax 요청 *****************/
	
	/**
	 * 특정 상품의 옵션들을 선택해서 ArrayList로 반환
	 * @param pdtNo
	 * @return
	 * PDT_NO, PDT_NAME, PDT_OPTION_NO, PDT_OPTION_FIRST, PDT_OPTION_SECOND, PDT_STOCK
	 */
	List<ProductOptionVO> ajaxProductOption(int pdtNo);
	
	/**
	 * 상품 번호, 숫자N을 받아 최근순 리뷰 Top N개를 조회하는 메소드
	 * @param pMap : pdtNo, rowNum
	 * @return
	 */
	ArrayList<ReviewVO> selectRecentReviewWithRownum(HashMap<String, Integer> pMap);

}
