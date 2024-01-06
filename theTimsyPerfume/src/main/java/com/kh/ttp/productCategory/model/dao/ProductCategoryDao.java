package com.kh.ttp.productCategory.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productCategory.model.vo.ProductCategory;

@Repository
public class ProductCategoryDao {

	public int drinkFundingInsert(SqlSessionTemplate sqlSession, ProductCategory pc) {
		
		return sqlSession.insert("productMapper.insertProductCategory",pc); 
	}

	public int drinkFundingSelect(SqlSessionTemplate sqlSession) {
		
		 return sqlSession.selectOne("productMapper.selectProductCategory");
	}

	public int updateDrinkFunding(SqlSessionTemplate sqlSession, ProductCategory pc) {
		return sqlSession.update("productMapper.updateDrinkFunding",pc);
	}
	

}
