package com.kh.ttp.productSale.cart.model.service;

import java.util.ArrayList;

import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.cart.model.vo.CartMainDTO;

public interface CartService {
	
	
	/**
	 * 장바구니 등록여부COUNT / 특정 유저가 한 상품(특정옵션)을 장바구니에 추가한 내역이 있는지 조회
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), pdtOptionNo(옵션번호PK)
	 * @return : 성공여부 int 반환, 성공 시 1 / 실패 시 0
	 */
	int countCartOne(CartDTO cart);

	
	/**
	 * 1개 상품(특정옵션 / 판매중 상태 Y)의 재고 개수 조회
	 */
	int selectStockWithOption(CartDTO cart);
	
	
	// 장바구니 전체조회
	/**
	 * 장바구니 전체 조회
	 * @param userNo(유저번호PK)
	 * @return : 장바구니 정보가 담긴 ArrayList
	 */
	ArrayList<CartMainDTO> cartMain(int userNo);
	
	
	/**
	 * 장바구니 INSERT
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), cartAddingQuantity(추가하려는 수량)
	 * @return : 성공여부 int 반환, 성공 시 1 / 실패 시 0
	 */
	int insertCartOne(CartDTO cart);
	
	
	/**
	 * 장바구니 기존 수량에 추가 UPDATE
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), cartAddingQuantity(추가하려는 수량)
	 * @return : 성공여부 int 반환, 성공 시 1 / 실패 시 0
	 */
	int updateCartAddUpOne(CartDTO cart);
	
	
	/**
	 * 장바구니에 상품 추가 요청이 들어오면 재고 및 현재 장바구니에 있는 상품인지 체크 함
	 * 아직 추가되지 않은 상품은 cartQuantity만큼 INSERT, 이미 있는 경우 기존 수량에 더해 UPDATE 수행함
	 * @param cart : pdtNo(상품PK), pdtOptionNo(상품옵션PK), cartQuantity(카트에 추가할 수량)
	 * @return : INSERT 혹은 UPDATE 성공 시 1, 실패 시 0, 재고가 없을 시 -1 반환
	 */
	int insertCartAjax(CartDTO cart);


	/**
	 * 장바구니 수량 업데이트 메소드
	 * @param cart : cartNo(장바구니 번호PK), userNo(유저 번호PK / 검증용), cartQuantity(수량)이 담긴 CartDTO타입 객체
	 * @return : 성공 시 1, 실패 시 0 반환
	 */
	int updateCartAjax(CartDTO cart);


	/**
	 * 장바구니 품목 삭제 메소드
	 * @param cart : cartNo(장바구니 번호PK), userNo(유저 번호PK / 검증용)이 담긴 CartDTO타입 객체
	 * @return : 성공 시 1, 실패 시 0반환
	 */
	int deleteCartAjax(CartDTO cart);

}
