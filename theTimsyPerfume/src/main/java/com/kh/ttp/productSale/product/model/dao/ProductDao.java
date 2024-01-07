package com.kh.ttp.productSale.product.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.productSale.cart.model.vo.CartMainVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.product.model.vo.ProductSelectVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;
import com.kh.ttp.productSale.wishlist.model.vo.WishlistVO;

@Repository
public class ProductDao {

	
	/**
	 * 전체상품 COUNT / 브랜드 주류 or 향수(판매중 상태Y)의 전체 개수
	 * @param pdtCteg : 상품카테고리(알콜 'A', 향수'F')
	 */
	public int productCount(SqlSessionTemplate sqlSession, String pdtCteg) {
		return sqlSession.selectOne("productMapper.productCount", pdtCteg);
	}


	

	


	
	
	/**
	 * 상품 메인 조회<br>
	 * 주류/향수 식별자(pdtCteg)를 받아 해당되는 상품을 각 정렬 기준별로 조회해 ArrayList(ProductSelectVO리터럴)로 반환한다<br>
	 * 최신순, 베스트셀러순, 위시리스트순으로 조회한다
	 * @param pMap	:<br>
	 * 주류/향수 식별자 key : "pdtCteg" & value : "A"(주류) "F"(향수)<br>
	 * 정렬기준 key : "sort" & value="BestSeller"(베스트셀러순) "Popular"(위시리스트순)<br>
	 * 미설정 시 최신순으로 조회되며, 가독성을 위해 "New"로 설정도 가능
	 * @param rowBounds : 페이지네이션을 위한 RowBounds객체
	 * @return
	 * 조회 결과가 담긴 ArrayList(ProductSelectVO리터럴)를 반환,<br>
	 * 초기화된 ProductSelectVO의 필드는 아래와 같다<br>
	 * int pdtNo(상품PK번호), String pdtName(상품명), String pdtManufac(브랜드 혹은 제조자명)<br>
	 * String pdtIntro(상품 간략 설명), String pdtDescription(상품 상세 설명),<br>
	 * String pdtImgSrc(제품 썸네일 이미지의 경로), float reviewAvg(제품 리뷰의 평균 별점)
	 */
	public ArrayList<ProductSelectVO> productMain(SqlSessionTemplate sqlSession,
													  Map<String, Object> pMap) {
		return (ArrayList)sqlSession.selectList("productMapper.productSelectList", pMap);
	}
	
	//향수 전체조회
	public ArrayList<ProductSelectVO> perfumePdtList(SqlSessionTemplate sqlSession, Map<String, Object> pMap, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("productMapper.productSelectList", pMap, rowBounds);
	}
	
	// 향수 디테일 조회
	public ProductSelectVO perfumePdtDetail(SqlSessionTemplate sqlSession, HashMap<String, Object> pMap) {
		return sqlSession.selectOne("productMapper.productDetail", pMap);
	}
	
	//주류 전체조회
	public ArrayList<ProductSelectVO> alcoholPdtList(SqlSessionTemplate sqlSession, Map<String, Object> pMap, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("productMapper.productSelectList", pMap, rowBounds);
	}
	
	
	// 주류 디테일조회
	public ProductSelectVO alcoholPdtDetail(SqlSessionTemplate sqlSession, Map<String, Object> pMap) {
		return sqlSession.selectOne("productMapper.productDetail", pMap);
	}
	
	

	












	public List<ProductOptionVO> selectPdtOptionOne(SqlSessionTemplate sqlSession, int pdtNo) {
		return (ArrayList)sqlSession.selectList("productMapper.selectPdtOptionOne", pdtNo);
	}
	
	// 최근 N개 리뷰 조회 (pdtNo, Rownum)
	public ArrayList<ReviewVO> selectRecentReviewWithRownum(SqlSessionTemplate sqlSession, HashMap<String, Integer> pMap) {
		return (ArrayList)sqlSession.selectList("productMapper.selectRecentReviewWithRownum", pMap);
	}






}