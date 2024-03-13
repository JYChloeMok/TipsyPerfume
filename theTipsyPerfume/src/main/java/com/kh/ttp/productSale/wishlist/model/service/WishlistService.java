package com.kh.ttp.productSale.wishlist.model.service;

import com.kh.ttp.productSale.wishlist.model.vo.WishlistVO;

public interface WishlistService {

	
	/**
	 * 특정 유저가 한 상품에 위시리스트 추가한 내역이 있는지 조회(위시리스트 카운트)
	 */
	int countWishOne(WishlistVO wishlist);
	
	
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
	
	
}
