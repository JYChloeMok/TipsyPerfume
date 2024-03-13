package com.kh.ttp.productSale.productInfo.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.productInfo.model.vo.ProductFileVO;

@Repository
public class ProductFileDao {

	public int drinkFundingInsert(SqlSessionTemplate sqlSession, ProductFileVO pf) {
		return sqlSession.insert("productMapper.insertProductFile",pf);
	}

	public int updateDrinkFundingPF(SqlSessionTemplate sqlSession, ProductFileVO pf) {
		return sqlSession.update("productMapper.updateDrinkFundingPF",pf);
	}

}
