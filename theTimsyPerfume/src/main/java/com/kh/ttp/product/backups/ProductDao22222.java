/*
package com.kh.ttp.product.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.orderKinds.model.vo.OrderDetailVO;
import com.kh.ttp.orderKinds.model.vo.OrderVO;
import com.kh.ttp.orderKinds.model.vo.PayVO;
import com.kh.ttp.product.model.vo.CartSelectVO;
import com.kh.ttp.product.model.vo.CartVO;
import com.kh.ttp.product.model.vo.FundingSelectVO;
import com.kh.ttp.product.model.vo.ProductVO;

@Repository
public class ProductDao {
	

	public int drinkFundingInsert(SqlSessionTemplate sqlSession, ProductVO product) {
		return sqlSession.insert("productMapper.insertProduct", product);
	}

	public int drinkFundingSelect(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("productMapper.selectProduct");
	}

	public ArrayList<ProductVO> selectNewFundingListP() {
		return null;
	}

	public ArrayList<FundingSelectVO> selectFundingList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("productMapper.selectFundingList");
		 
	}

	public int newDrinkFundingListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("productMapper.newDrinkFundingListCount");
	}

	public ArrayList<FundingSelectVO> newDrinkFundingList(SqlSessionTemplate sqlSession,RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("productMapper.newDrinkFundingList",null,rowBounds);
	}
	public ArrayList<FundingSelectVO> hotDrinkFundingList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("productMapper.hotDrinkFundingList",null,rowBounds);
	}

	public FundingSelectVO newDrinkFundingDetail(SqlSessionTemplate sqlSession, int pdtNo) {
		
		return sqlSession.selectOne("productMapper.newDrinkFundingDetail",pdtNo);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int pdtNo) {
		return sqlSession.update("productMapper.increaseCount", pdtNo);
	}

	public ArrayList<FundingSelectVO> selectHotFundingList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("productMapper.selectHotFundingList");
	}

	

	public FundingSelectVO selectDrinkFundingList(SqlSessionTemplate sqlSession, int pdtNo) {
		
		return sqlSession.selectOne("productMapper.selectDrinkFundingList",pdtNo);
	}

	public int updateDrinkFunding(SqlSessionTemplate sqlSession, ProductVO product) {
		return  sqlSession.update("productMapper.updateDrinkFundingP",product);
		
	}

	public int selectPdtNo(SqlSessionTemplate sqlSession, ProductVO product) {
		return sqlSession.selectOne("productMapper.selectPdtNo",product);
		 
	}

	public int deleteDrinkFunding(SqlSessionTemplate sqlSession, int pdtNo) {
		return sqlSession.update("productMapper.deleteDrinkFunding",pdtNo);
	}

	public int confirmFundingDrinkPV(SqlSessionTemplate sqlSession, PayVO pv) {
		return sqlSession.insert("productMapper.confirmFundingPV",pv);
	}

	public int confirmFundingDrinkO(SqlSessionTemplate sqlSession, OrderVO o) {
		return sqlSession.insert("productMapper.confirmFundingDrinkO",o);
	}

	public int selectOrderNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("productMapper.selectOrderNo");
	}

	public int confirmFundingDrinkOD(SqlSessionTemplate sqlSession, OrderDetailVO od) {
		return sqlSession.insert("productMapper.confirmFundingDrinkOD",od);
	}

	public int selectPayNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("productMapper.selectPayNo");
	}

	public int decreaseStock(SqlSessionTemplate sqlSession, ProductVO p) {
		return sqlSession.update("productMapper.decreaseStock",p);
	}

	public int insertFundingBasket(SqlSessionTemplate sqlSession, CartVO cart) {
		return sqlSession.insert("productMapper.insertFundingBasket",cart);
	}

	public ArrayList<CartSelectVO> selectFundingCart(int userNo,SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("productMapper.selectFundingCart",userNo);
	}
	

}
*/
