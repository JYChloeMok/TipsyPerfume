package com.kh.ttp.productSale.billing.order.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.cart.model.vo.CartMainVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;

@Repository
public class OrderDao {

	public ArrayList<CartMainVO> orderMain(SqlSessionTemplate sqlSession, CartVO cart) {
		return (ArrayList)sqlSession.selectList("productMapper.orderMain", cart);
	}

}
