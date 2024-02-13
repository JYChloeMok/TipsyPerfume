package com.kh.ttp.productSale.order.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.cart.model.vo.CartVO;

@Repository
public class OrderDao {

	public ArrayList<CartVO> orderMain(SqlSessionTemplate sqlSession, List<Integer> cartNoList) {
		return (ArrayList)sqlSession.selectList("orderMain", cartNoList);
	}

}
