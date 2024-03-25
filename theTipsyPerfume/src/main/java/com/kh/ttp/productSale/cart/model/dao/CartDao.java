package com.kh.ttp.productSale.cart.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.cart.model.vo.SaleMainDTO;

@Repository
public class CartDao {

	
	/**
	 * 장바구니 등록여부COUNT / 특정 유저가 한 상품(특정 옵션)을 장바구니에 추가한 내역이 있는지 조회
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), pdtOptionNo(옵션번호PK)
	 */
	public int countCartOne(SqlSessionTemplate sqlSession, CartDTO cart) {
		return sqlSession.selectOne("productMapper.countCartOne", cart);
	}
	
	
	/**
	 * 1개 상품(특정옵션 / 판매중 상태 Y)의 재고 COUNT
	 * @param pdtNo
	 */
	public int selectStockWithOption(SqlSessionTemplate sqlSession, CartDTO cart) {
		return sqlSession.selectOne("productMapper.selectStockWithOption", cart);
	}
	
	
	/**
	 * 장바구니 전체조회
	 */
	public ArrayList<SaleMainDTO> cartMain(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("productMapper.cartMain", userNo);
	}
	
	
	// 장바구니 상품 추가
	/**
	 * 장바구니에 특정 상품 추가
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), pdtOptionNo(상품옵션PK), cartAddingQuantity(추가하려는 수량)
	 */
	public int insertCartOne(SqlSessionTemplate sqlSession, CartDTO cart) {
		return sqlSession.insert("productMapper.insertCartOne", cart);
	}
	
	
	/**
	 * 장바구니 기존 수량에 추가 수량 UPDATE
	 * @param cart : userNo(유저번호PK), pdtNo(상품번호PK), pdtOptionNo(상품옵션PK), cartAddingQuantity(추가하려는 수량)
	 */
	public int updateCartAddUpOne(SqlSessionTemplate sqlSession, CartDTO cart) {
		return sqlSession.update("productMapper.updateCartAddUpOne", cart);
	}


	public int updateCart(SqlSessionTemplate sqlSession, CartDTO cart) {
		return sqlSession.update("productMapper.updateCart", cart);
	}


	public int deleteCart(SqlSessionTemplate sqlSession, CartDTO cart) {
		return sqlSession.delete("productMapper.deleteCart", cart);
	}
	
	
}
