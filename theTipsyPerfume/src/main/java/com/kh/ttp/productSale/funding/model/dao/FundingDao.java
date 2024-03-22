package com.kh.ttp.productSale.funding.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.productSale.billing.order.model.vo.OrderDTO;
import com.kh.ttp.productSale.billing.payment.model.vo.PaymentDTO;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.cart.model.vo.CartSelectDTO;
import com.kh.ttp.productSale.funding.model.vo.FundingDTO;
import com.kh.ttp.productSale.funding.model.vo.FundingSelectDTO;
import com.kh.ttp.productSale.product.model.vo.ProductDTO;

@Repository
public class FundingDao {
	
	/* ↓ 원래 있던 것 */
	public int drinkFundingInsert(SqlSessionTemplate sqlSession, FundingDTO f) {
		return sqlSession.insert("fundingMapper.insertFunding",f);
	}

	public int updateDrinkFundingF(SqlSessionTemplate sqlSession, FundingDTO f) {
		return sqlSession.update("fundingMapper.updateDrinkFundingF",f);
	}

	public int confirmFundingDrink(SqlSessionTemplate sqlSession,FundingDTO f) {
		return sqlSession.update("fundingMapper.updateFundingFee",f);
	}
	/* ↑ 원래 있던 것 */
	
	
	public int insertFundingProduct(SqlSessionTemplate sqlSession, ProductDTO product) {
		return sqlSession.insert("fundingMapper.insertFundingProduct", product);
	}

	public int drinkFundingSelect(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.selectProduct");
	}

	public ArrayList<ProductDTO> selectNewFundingListP() {
		return null;
	}

	public ArrayList<FundingSelectDTO> selectFundingList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("fundingMapper.selectFundingList");
		 
	}

	public int newDrinkFundingListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.newDrinkFundingListCount");
	}

	public ArrayList<FundingSelectDTO> newDrinkFundingList(SqlSessionTemplate sqlSession,RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("fundingMapper.newDrinkFundingList",null,rowBounds);
	}
	public ArrayList<FundingSelectDTO> hotDrinkFundingList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("fundingMapper.hotDrinkFundingList",null,rowBounds);
	}

	public FundingSelectDTO newDrinkFundingDetail(SqlSessionTemplate sqlSession, int pdtNo) {
		
		return sqlSession.selectOne("fundingMapper.newDrinkFundingDetail",pdtNo);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int pdtNo) {
		return sqlSession.update("fundingMapper.increaseCount", pdtNo);
	}

	public ArrayList<FundingSelectDTO> selectHotFundingList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("fundingMapper.selectHotFundingList");
	}

	

	public FundingSelectDTO selectDrinkFundingList(SqlSessionTemplate sqlSession, int pdtNo) {
		
		return sqlSession.selectOne("fundingMapper.selectDrinkFundingList",pdtNo);
	}

	public int updateDrinkFunding(SqlSessionTemplate sqlSession, ProductDTO product) {
		return  sqlSession.update("fundingMapper.updateDrinkFundingP",product);
		
	}

	public int selectPdtNo(SqlSessionTemplate sqlSession, ProductDTO product) {
		return sqlSession.selectOne("fundingMapper.selectPdtNo",product);
		 
	}

	public int deleteDrinkFunding(SqlSessionTemplate sqlSession, int pdtNo) {
		return sqlSession.update("fundingMapper.deleteDrinkFunding",pdtNo);
	}

	public int confirmFundingDrinkPV(SqlSessionTemplate sqlSession, PaymentDTO pv) {
		return sqlSession.insert("fundingMapper.confirmFundingPV",pv);
	}

	public int confirmFundingDrinkO(SqlSessionTemplate sqlSession, OrderDTO o) {
		return sqlSession.insert("fundingMapper.confirmFundingDrinkO",o);
	}

	public int selectOrderNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.selectOrderNo");
	}
	/*
	public int confirmFundingDrinkOD(SqlSessionTemplate sqlSession, OrderDetailDTO od) {
		return sqlSession.insert("fundingMapper.confirmFundingDrinkOD",od);
	}
	*/
	public int selectPayNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("fundingMapper.selectPayNo");
	}

	public int decreaseStock(SqlSessionTemplate sqlSession, ProductDTO p) {
		return sqlSession.update("fundingMapper.decreaseStock",p);
	}

	public int insertFundingBasket(SqlSessionTemplate sqlSession, CartDTO cart) {
		return sqlSession.insert("fundingMapper.insertFundingBasket",cart);
	}

	public ArrayList<CartSelectDTO> selectFundingCart(int userNo,SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("fundingMapper.selectFundingCart",userNo);
	}
	

}
