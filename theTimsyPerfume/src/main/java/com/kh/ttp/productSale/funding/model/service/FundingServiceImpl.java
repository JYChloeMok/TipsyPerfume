package com.kh.ttp.productSale.funding.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.productSale.billing.order.model.vo.OrderDetailVO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderVO;
import com.kh.ttp.productSale.billing.pay.model.vo.PayVO;
import com.kh.ttp.productSale.cart.model.vo.CartSelectVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.funding.model.dao.FundingDao;
import com.kh.ttp.productSale.funding.model.vo.FundingSelectVO;
import com.kh.ttp.productSale.funding.model.vo.FundingVO;
import com.kh.ttp.productSale.product.model.vo.ProductVO;
import com.kh.ttp.productSale.productInfo.model.dao.ProductCategoryDao;
import com.kh.ttp.productSale.productInfo.model.dao.ProductFileDao;
import com.kh.ttp.productSale.productInfo.model.dao.ProductOptionDao;
import com.kh.ttp.productSale.productInfo.model.vo.ProductCategoryVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductFileVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;
import com.kh.ttp.productSale.receiver.model.dao.ReceiverDao;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverVO;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@EnableTransactionManagement
public class FundingServiceImpl implements FundingService {

	private final SqlSessionTemplate sqlSession;

	private final FundingDao fundingDao;
	private final ReceiverDao receiverDao;
	private final ProductFileDao productFileDao;
	private final ProductOptionDao productOptionDao;
	private final ProductCategoryDao productCategoryDao;
	
	@Override
	@Transactional
	public int drinkFundingInsert(ProductVO product, ProductFileVO productFile, ProductOptionVO productOption, FundingVO funding,
			ProductCategoryVO productCategory) {
		    if(productCategoryDao.drinkFundingInsert(sqlSession,productCategory)>0) {
				int result=productCategoryDao.drinkFundingSelect(sqlSession);
				product.setPdtCategNo(result);
				//System.out.println(p);
				if(fundingDao.insertFundingProduct(sqlSession,product)>0) {
					int pdtNo = fundingDao.drinkFundingSelect(sqlSession);
					productFile.setPdtNo(pdtNo);
					productOption.setPdtNo(pdtNo);
					funding.setPdtNo(pdtNo);
					
					productOptionDao.drinkFundingInsert(sqlSession,productOption);
					productFileDao.drinkFundingInsert(sqlSession,productFile);
					fundingDao.drinkFundingInsert(sqlSession,funding);
			}
		}
		    return 1;
		    
		   
		
		
	}
	@Override @Transactional
	public int updateDrinkFunding(ProductVO product, ProductFileVO productFile, ProductOptionVO productOption, FundingVO funding, 
			ProductCategoryVO productCategory) {
		if(fundingDao.updateDrinkFunding(sqlSession,product)>0) {
			int categNo = fundingDao.selectPdtNo(sqlSession,product);
			//System.out.println(categNo);
			productCategory.setPdtCategNo(categNo);
			productCategoryDao.updateDrinkFunding(sqlSession,productCategory);
			productOptionDao.updateDrinkFundingPO(sqlSession,productOption);
			fundingDao.updateDrinkFundingF(sqlSession,funding);
			productFileDao.updateDrinkFundingPF(sqlSession,productFile);
			
		}else {
			
		}
		return 1;
		
		
	}
	
	@Override
	public ArrayList<FundingSelectVO> selectNewFundingList() {
		return fundingDao.selectFundingList(sqlSession);
		
	}

	@Override
	public int newDrinkFundingListCount() {
		return fundingDao.newDrinkFundingListCount(sqlSession);
	}

	@Override
	public ArrayList<FundingSelectVO> newDrinkFundingList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return fundingDao.newDrinkFundingList(sqlSession,rowBounds);
	}

	@Override
	public FundingSelectVO newDrinkFundingDetail(int pdtNo) {
		return fundingDao.newDrinkFundingDetail(sqlSession,pdtNo);
	}

	@Override
	public int increaseCount(int pdtNo) {
		return fundingDao.increaseCount(sqlSession,pdtNo);
		
	}

	@Override
	public ArrayList<FundingSelectVO> selectHotFundingList() {
		return fundingDao.selectHotFundingList(sqlSession);
	}

	@Override
	public ArrayList<FundingSelectVO> hotDrinkFundingList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return fundingDao.hotDrinkFundingList(sqlSession,rowBounds);
	}

	@Override 
	public FundingSelectVO selectDrinkFundingList(int pdtNo) {
		return fundingDao.selectDrinkFundingList(sqlSession,pdtNo);
	}
	@Override @Transactional
	public int deleteDrinkFunding(int pdtNo) {
		return fundingDao.deleteDrinkFunding(sqlSession,pdtNo);
	}
	@Override @Transactional
	public int confirmFundingDrink(OrderDetailVO orderDetail, OrderVO order, User user, ProductVO product, 
			PayVO pay,FundingVO funding,ReceiverVO receiver) {
		if(fundingDao.confirmFundingDrink(sqlSession,funding)>0) {
			int result1= fundingDao.confirmFundingDrinkPV(sqlSession,pay);
			int result  = receiverDao.selectReceiverNo(sqlSession,receiver);
			int payNo = fundingDao.selectPayNo(sqlSession);
			order.setReceiverNo(result);
			int result2=fundingDao.confirmFundingDrinkO(sqlSession,order);
			int orderNo = fundingDao.selectOrderNo(sqlSession);
			orderDetail.setOrderNo(orderNo);
			orderDetail.setPayNo(payNo);
			int result3 = fundingDao.confirmFundingDrinkOD(sqlSession,orderDetail);
			int result4 = fundingDao.decreaseStock(sqlSession,product);
			if(result1*result*result2*result3*result4 > 0) {
				return 1;
			}
			
		};
		return 0;
	}
	@Override @Transactional
	public int insertReceiver(ReceiverVO r) {
		receiverDao.insertReceiver(sqlSession,r);
		return 0;
	}
	@Override @Transactional
	public int insertFundingBasket(CartVO cart) {
		fundingDao.insertFundingBasket(sqlSession,cart);
		return 0;
	}
	@Override
	public ArrayList<CartSelectVO> selectFundingCart(int userNo) {
		return fundingDao.selectFundingCart(userNo,sqlSession);
	}
	
	

	

	

}
