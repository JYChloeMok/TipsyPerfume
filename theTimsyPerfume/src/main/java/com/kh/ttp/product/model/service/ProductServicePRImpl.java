package com.kh.ttp.product.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.product.model.dao.ProductDaoPR;
import com.kh.ttp.product.model.vo.CartMain;
import com.kh.ttp.product.model.vo.CartVO;
import com.kh.ttp.product.model.vo.ProductSelectVO;
import com.kh.ttp.product.model.vo.WishlistVO;
import com.kh.ttp.productOption.model.vo.ProductOption;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServicePRImpl implements ProductServicePR {
	
	
	private final ProductDaoPR productDao;
	private final SqlSessionTemplate sqlSession;
	
	
	
	@Override
	public int selectProductCount(String pdtCteg) {
		return productDao.selectProductCount(sqlSession, pdtCteg);
	}

	
	@Override
	public int selectStockWithOption(CartVO cart) {
		return productDao.selectStockWithOption(sqlSession, cart);
	}
	
	@Override
	public int countWishOne(WishlistVO wishlist) {
		return productDao.countWishOne(sqlSession, wishlist);
	}
	
	@Override
	public int countCartOne(CartVO cart) {
		return productDao.countCartOne(sqlSession, cart);
	}
	
	
	@Override
	public HashMap<String, Object> productMain(String pdtCteg) {
		
		HashMap<String, Object> pMap = new HashMap();
		
		pMap.put("pdtCteg", pdtCteg); // 식별자
		
		pMap.put("pMainListNew", productDao.productMain(sqlSession, pMap)); // 최신순
				
		pMap.put("sort", "BestSeller");
		pMap.put("pMainListBestSeller", productDao.productMain(sqlSession, pMap)); // 판매량순
		
		pMap.put("sort", "Popular");
		pMap.put("pMainListPopular", productDao.productMain(sqlSession, pMap)); // 위시리스트순

		return pMap;
	}
	
	
	@Override
	public ArrayList<ProductSelectVO> perfumePdtList(String sort, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtCteg", "F");
		pMap.put("sort", sort);
		return productDao.perfumePdtList(sqlSession, pMap, rowBounds);
	}

	
	@Override
	public ProductSelectVO perfumePdtDetail(int pdtNo) {  // pdtNo, F
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtNo", pdtNo);
		pMap.put("pdtCteg", "F");
		return productDao.perfumePdtDetail(sqlSession, pMap);
	}

	
	@Override
	public ArrayList<ProductSelectVO> alcoholPdtList(String sort, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtCteg", "A");
		pMap.put("sort", sort);
		return productDao.alcoholPdtList(sqlSession, pMap, rowBounds);
	}

	
	@Override
	public ProductSelectVO alcoholPdtDetail(int pdtNo) {  // pdtNo, A
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtNo", pdtNo);
		pMap.put("pdtCteg", "A");
		return productDao.alcoholPdtDetail(sqlSession, pMap);
	}



	@Override
	public ArrayList<CartMain> cartMain(int userNo) {
		return productDao.cartMain(sqlSession, userNo);
	}


	@Override
	public int insertWishOne(WishlistVO wishlist) {
		return productDao.insertWishOne(sqlSession, wishlist);
	}


	@Override
	public int deleteWishOne(WishlistVO wishlist) {
		return productDao.deleteWishOne(sqlSession, wishlist);
	}
	

	@Override
	public int insertCartOne(CartVO cart) {
		return productDao.insertCartOne(sqlSession, cart);
	}

	
	
	@Override
	public int updateCartAddUpOne(CartVO cart) {
		return productDao.updateCartAddUpOne(sqlSession, cart);
	}
	
	
	// @@@ 여기서 장바구니에 SELECT할 때 현재 실 재고 개수가 DB에 즉각 반영되어야할 필요는 없음
	// => But 결제 시 현재 재고가 있는지 파악 + 재고 마이너스 + 돈을 빼고 넣는 작업은 => ACID보장되어야 
	// 최종 재고 반영은 주문&결제 시 UPDATE 트랜잭션 하나로
	
	
	
	
	
	
	
	
	////////////////
	
	@Override
	public int checkStockAddCart(CartVO cart) {
		if(selectStockWithOption(cart) > 0) {
			return (countCartOne(cart) == 0) ? insertCartOne(cart) : updateCartAddUpOne(cart);
		}																						 // 재고가 없음
		return -1;
	}


	
	
	
	
	
	
	
	
	
	@Override
	public List<ProductOption> ajaxSelectPdtOptionOne(int pdtNo) {
		return productDao.selectPdtOptionOne(sqlSession, pdtNo);
	}


	@Override
	public ArrayList<ReviewVO> selectRecentReviewWithRownum(HashMap<String, Integer> pMap) {
		return productDao.selectRecentReviewWithRownum(sqlSession, pMap);
	}
	
	
	
	/***************** ajax 요청 *****************/
	@Override
	public boolean ajaxChangeWishOne(WishlistVO wishlist) {
		// 카운트 후 INSERT or DELETE 수행 => (result > 0)로 성공1은 true, 실패0은 false반환
		boolean isFilledHeart = false;
		if(countWishOne(wishlist) == 0) { // count 0이었을 때? 위시리스트 없음 => insert 성공 시 : 하트채우기(true)
			isFilledHeart = (insertWishOne(wishlist) > 0) ? true : false;
		} else { // count 1이었을 때? 위시리스트 있음 => delete 성공 시 : 하트비우기(false)
			isFilledHeart = (deleteWishOne(wishlist) > 0) ? false : true;
		}
		return isFilledHeart;
	}





	/********************************************************/

	
	
	
	
	
	
	
	
	
	
	
	
	


}