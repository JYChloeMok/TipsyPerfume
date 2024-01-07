package com.kh.ttp.productSale.funding.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.pay.model.vo.PayVO;
import com.kh.ttp.productSale.cart.model.vo.CartSelectVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.funding.model.vo.FundingSelectVO;
import com.kh.ttp.productSale.funding.model.vo.FundingVO;
import com.kh.ttp.productSale.order.model.vo.OrderDetailVO;
import com.kh.ttp.productSale.order.model.vo.OrderVO;
import com.kh.ttp.productSale.product.model.vo.ProductVO;

@Repository
public class FundingDao {
	
	/* ↓ 원래 있던 것 */
	public int drinkFundingInsert(SqlSessionTemplate sqlSession, FundingVO f) {
		return sqlSession.insert("fundingMapper.insertFunding",f);
	}

	public int updateDrinkFundingF(SqlSessionTemplate sqlSession, FundingVO f) {
		return sqlSession.update("fundingMapper.updateDrinkFundingF",f);
	}

	public int confirmFundingDrink(SqlSessionTemplate sqlSession,FundingVO f) {
		return sqlSession.update("fundingMapper.updateFundingFee",f);
	}
	/* ↑ 원래 있던 것 */
	
	
	public int insertFundingProduct(SqlSessionTemplate sqlSession, ProductVO product) {
		return sqlSession.insert("fundingMapper.insertFundingProduct", product);
	}

	public int drinkFundingSelect(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.selectProduct");
	}

	public ArrayList<ProductVO> selectNewFundingListP() {
		return null;
	}

	public ArrayList<FundingSelectVO> selectFundingList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("fundingMapper.selectFundingList");
		 
	}

	public int newDrinkFundingListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.newDrinkFundingListCount");
	}

	public ArrayList<FundingSelectVO> newDrinkFundingList(SqlSessionTemplate sqlSession,RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("fundingMapper.newDrinkFundingList",null,rowBounds);
	}
	public ArrayList<FundingSelectVO> hotDrinkFundingList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("fundingMapper.hotDrinkFundingList",null,rowBounds);
	}

	public FundingSelectVO newDrinkFundingDetail(SqlSessionTemplate sqlSession, int pdtNo) {
		
		return sqlSession.selectOne("fundingMapper.newDrinkFundingDetail",pdtNo);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int pdtNo) {
		return sqlSession.update("fundingMapper.increaseCount", pdtNo);
	}

	public ArrayList<FundingSelectVO> selectHotFundingList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("fundingMapper.selectHotFundingList");
	}

	

	public FundingSelectVO selectDrinkFundingList(SqlSessionTemplate sqlSession, int pdtNo) {
		
		return sqlSession.selectOne("fundingMapper.selectDrinkFundingList",pdtNo);
	}

	public int updateDrinkFunding(SqlSessionTemplate sqlSession, ProductVO product) {
		return  sqlSession.update("fundingMapper.updateDrinkFundingP",product);
		
	}

	public int selectPdtNo(SqlSessionTemplate sqlSession, ProductVO product) {
		return sqlSession.selectOne("fundingMapper.selectPdtNo",product);
		 
	}

	public int deleteDrinkFunding(SqlSessionTemplate sqlSession, int pdtNo) {
		return sqlSession.update("fundingMapper.deleteDrinkFunding",pdtNo);
	}

	public int confirmFundingDrinkPV(SqlSessionTemplate sqlSession, PayVO pv) {
		return sqlSession.insert("fundingMapper.confirmFundingPV",pv);
	}

	public int confirmFundingDrinkO(SqlSessionTemplate sqlSession, OrderVO o) {
		return sqlSession.insert("fundingMapper.confirmFundingDrinkO",o);
	}

	public int selectOrderNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.selectOrderNo");
	}

	public int confirmFundingDrinkOD(SqlSessionTemplate sqlSession, OrderDetailVO od) {
		return sqlSession.insert("fundingMapper.confirmFundingDrinkOD",od);
	}

	public int selectPayNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.selectPayNo");
	}

	public int decreaseStock(SqlSessionTemplate sqlSession, ProductVO p) {
		return sqlSession.update("fundingMapper.decreaseStock",p);
	}

	public int insertFundingBasket(SqlSessionTemplate sqlSession, CartVO cart) {
		return sqlSession.insert("fundingMapper.insertFundingBasket",cart);
	}

	public ArrayList<CartSelectVO> selectFundingCart(int userNo,SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("fundingMapper.selectFundingCart",userNo);
	}
	

}
