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
	
	
	/**
	 * 1개 상품(특정옵션 / 판매중 상태 Y)의 재고 개수 조회
	 */
	int selectStockWithOption(CartVO cart);

	/**
	 * 특정 유저가 한 상품에 위시리스트 추가한 내역이 있는지 조회(위시리스트 카운트)
	 */
	int countWishOne(WishlistVO wishlist);
	
	/**
	 * 장바구니 등록여부COUNT / 특정 유저가 한 상품(특정옵션)을 장바구니에 추가한 내역이 있는지 조회
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), pdtOptionNo(옵션번호PK)
	 * @return : 성공여부 int 반환, 성공 시 1 / 실패 시 0
	 */
	int countCartOne(CartVO cart);
	
	
	
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
	ArrayList<ProductSelectVO> perfumePdtList(String sort, PageInfo pi);
	
	// 향수 디테일조회 perfumePdtDetail
	ProductSelectVO perfumePdtDetail(int pdtNo);
	
	// 주류 전체조회 alcoholPdtList
	ArrayList<ProductSelectVO> alcoholPdtList(String sort, PageInfo pi);
	
	// 주류 디테일조회 alcoholPdtDetail
	ProductSelectVO alcoholPdtDetail(int pdtNo);
	
	// 장바구니 전체조회
	/**
	 * 장바구니 전체 조회
	 * @param userNo(유저번호PK)
	 * @return : 장바구니 정보가 담긴 ArrayList
	 */
	ArrayList<CartMainVO> cartMain(int userNo);
	
	
	/**
	 * 위시리스트 추가(INSERT)
	 */
	int insertWishOne(WishlistVO wishlist);
	
	/**
	 * 위시리스트 삭제(DELETE / 완전삭제)
	 */
	int deleteWishOne(WishlistVO wishlist);
	
	
	// 위시리스트 클릭 시 추가 혹은 삭제 ajaxChangeWishOne
	/**
	 * 유저의 위시리스트에 이미 추가되어있는 상품인지 체크 후<br>
	 * 없으면 추가(INSERT), 이미 있으면 위시리스트 취소(DELETE)
	 * @param wishlist : 상품번호 pdtNo(PK), 유저번호userNo(PK)가 담긴 WishlistVO 인스턴스
	 * @return : 위시리스트에 INSERT 혹은 DELETE구문 수행 후<br>
	 * 결과에 따라 위시리스트가 있는 상태로 표시해야하는지(true)<br>
	 * 비워진 상태로 표시해야하는지(false) boolean타입 반환<br>
	 */
	boolean ajaxChangeWishOne(WishlistVO wishlist);

	
	/**
	 * 장바구니 INSERT
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), cartAddingQuantity(추가하려는 수량)
	 * @return : 성공여부 int 반환, 성공 시 1 / 실패 시 0
	 */
	int insertCartOne(CartVO cart);
	
	/**
	 * 장바구니 기존 수량에 추가 UPDATE
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), cartAddingQuantity(추가하려는 수량)
	 * @return : 성공여부 int 반환, 성공 시 1 / 실패 시 0
	 */
	int updateCartAddUpOne(CartVO cart);
	
	
	/**
	 * 장바구니에 상품 추가 요청이 들어오면 재고 및 현재 장바구니에 있는 상품인지 체크 함
	 * 아직 추가되지 않은 상품은 cartQuantity만큼 INSERT, 이미 있는 경우 기존 수량에 더해 UPDATE 수행함
	 * @param cart : pdtNo(상품PK), pdtOptionNo(상품옵션PK), cartQuantity(카트에 추가할 수량)
	 * @return : INSERT 혹은 UPDATE 성공 시 1, 실패 시 0, 재고가 없을 시 -1 반환
	 */
	int checkStockAddCart(CartVO cart);
	
	
	/**
	 * 상품 번호, 숫자N을 받아 최근순 리뷰 Top N개를 조회하는 메소드
	 * @param pMap : pdtNo, rowNum
	 * @return
	 */
	ArrayList<ReviewVO> selectRecentReviewWithRownum(HashMap<String, Integer> pMap);
	
	/**
	 * 특정 상품의 옵션들을 선택해서 ArrayList로 반환
	 * @param pdtNo
	 * @return
	 * PDT_NO, PDT_NAME, PDT_OPTION_NO, PDT_OPTION_FIRST, PDT_OPTION_SECOND, PDT_STOCK
	 */
	List<ProductOptionVO> ajaxSelectPdtOptionOne(int pdtNo);
	
	
	
	
	
	
	
	
	
	
	
	

}
