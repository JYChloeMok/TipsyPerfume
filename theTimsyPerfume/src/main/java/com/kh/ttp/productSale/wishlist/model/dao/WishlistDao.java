package com.kh.ttp.productSale.wishlist.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.wishlist.model.vo.WishlistVO;

@Repository
public class WishlistDao {
	
	
	/**
	 * 위시리스트 COUNT / 특정 유저가 한 상품에 위시리스트 추가한 내역이 있는지 조회
	 * @param wishlist : userNo(유저번호PK), pdtNo(상품번호PK)
	 */
	public int countWishOne(SqlSessionTemplate sqlSession, WishlistVO wishlist) {
		return sqlSession.selectOne("productMapper.countWishOne", wishlist);
	}
	
	
	/**
	 * 위시리스트 추가
	 */
	public int insertWishOne(SqlSessionTemplate sqlSession, WishlistVO wishlist) {
		return sqlSession.insert("productMapper.insertWishOne", wishlist);
	}
	
	
	/**
	 * 위시리스트 삭제
	 */
	public int deleteWishOne(SqlSessionTemplate sqlSession, WishlistVO wishlist) {
		return sqlSession.delete("productMapper.deleteWishOne", wishlist);
	}
	
	

}
