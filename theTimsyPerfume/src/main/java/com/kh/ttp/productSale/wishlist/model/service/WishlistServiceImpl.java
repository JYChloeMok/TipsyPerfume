package com.kh.ttp.productSale.wishlist.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.wishlist.model.dao.WishlistDao;
import com.kh.ttp.productSale.wishlist.model.vo.WishlistVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WishlistServiceImpl implements WishlistService {

	
	/**
	 * DAO 클래스
	 */
	private final WishlistDao wishlistDao;
	
	/**
	 * sqlSessionTemplate 객체
	 */
	private final SqlSessionTemplate sqlSession;
	
	
	@Override
	public int countWishOne(WishlistVO wishlist) {
		return wishlistDao.countWishOne(sqlSession, wishlist);
	}

	@Override
	public int insertWishOne(WishlistVO wishlist) {
		return wishlistDao.insertWishOne(sqlSession, wishlist);
	}

	@Override
	public int deleteWishOne(WishlistVO wishlist) {
		return wishlistDao.deleteWishOne(sqlSession, wishlist);
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

}
