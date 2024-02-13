package com.kh.ttp.productSale.order.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.order.model.dao.OrderDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

	private final OrderDao orderDao;
	
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<CartVO> orderMain(List<Integer> cartNoList) {
		return orderDao.orderMain(sqlSession, cartNoList);
	}

}
