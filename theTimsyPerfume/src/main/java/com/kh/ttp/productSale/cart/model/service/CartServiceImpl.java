package com.kh.ttp.productSale.cart.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.cart.model.dao.CartDao;
import com.kh.ttp.productSale.cart.model.vo.CartMainVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

	/**
	 * DAO 클래스
	 */
	private final CartDao cartDao;
	
	/**
	 * sqlSessionTemplate 객체
	 */
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public int countCartOne(CartVO cart) {
		return cartDao.countCartOne(sqlSession, cart);
	}

	@Override
	public int selectStockWithOption(CartVO cart) {
		return cartDao.selectStockWithOption(sqlSession, cart);
	}

	@Override
	public ArrayList<CartMainVO> cartMain(int userNo) {
		return cartDao.cartMain(sqlSession, userNo);
	}

	@Override
	public int insertCartOne(CartVO cart) {
		return cartDao.insertCartOne(sqlSession, cart);
	}

	@Override
	public int updateCartAddUpOne(CartVO cart) {
		return cartDao.updateCartAddUpOne(sqlSession, cart);
	}

	@Override
	public int checkStockAddCart(CartVO cart) {
		if(selectStockWithOption(cart) > 0) {
			return (countCartOne(cart) == 0) ? insertCartOne(cart) : updateCartAddUpOne(cart);
		}																						 // 재고가 없음
		return -1;
	}

	
}
