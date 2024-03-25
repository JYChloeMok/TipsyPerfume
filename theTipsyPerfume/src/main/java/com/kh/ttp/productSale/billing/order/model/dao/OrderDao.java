package com.kh.ttp.productSale.billing.order.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.billing.order.model.vo.OrderDTO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderInfoDTO;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.cart.model.vo.SaleMainDTO;

@Repository
public class OrderDao {

	public ArrayList<SaleMainDTO> orderMain(SqlSessionTemplate sqlSession, CartDTO cart) {
		return (ArrayList)sqlSession.selectList("productMapper.orderMain", cart);
	}

	public int insertOrder(SqlSessionTemplate sqlSession, OrderDTO order) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int selectOrderAmount(SqlSessionTemplate sqlSession, ArrayList<OrderInfoDTO> orderInfoList) {
		return sqlSession.selectOne("productMapper.selectOrderAmount", orderInfoList);
	}

}
