package com.kh.ttp.productSale.productInfo.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.productInfo.model.vo.ProductCategoryDTO;

@Repository
public class ProductCategoryDao {

	public int drinkFundingInsert(SqlSessionTemplate sqlSession, ProductCategoryDTO pc) {
		
		return sqlSession.insert("productMapper.insertProductCategory",pc); 
	}

	public int drinkFundingSelect(SqlSessionTemplate sqlSession) {
		
		 return sqlSession.selectOne("productMapper.selectProductCategory");
	}

	public int updateDrinkFunding(SqlSessionTemplate sqlSession, ProductCategoryDTO pc) {
		return sqlSession.update("productMapper.updateDrinkFunding",pc);
	}
	

}
