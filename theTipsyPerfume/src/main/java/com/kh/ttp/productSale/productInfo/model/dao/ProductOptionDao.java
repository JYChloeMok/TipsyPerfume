package com.kh.ttp.productSale.productInfo.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;

@Repository
public class ProductOptionDao {

	public int drinkFundingInsert(SqlSessionTemplate sqlSession, ProductOptionVO po) {
		return sqlSession.insert("productMapper.insertProductOption",po);
	}

	public int updateDrinkFundingPO(SqlSessionTemplate sqlSession, ProductOptionVO po) {
		return sqlSession.update("productMapper.updateDrinkFundingPO",po);
		
	}

}
