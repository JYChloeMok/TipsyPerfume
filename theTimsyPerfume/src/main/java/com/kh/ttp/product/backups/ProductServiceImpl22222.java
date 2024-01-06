/*
package com.kh.ttp.product.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.funding.model.dao.FundingDao;
import com.kh.ttp.funding.model.vo.Funding;
import com.kh.ttp.orderKinds.model.dao.ReceiverDao;
import com.kh.ttp.orderKinds.model.vo.OrderDetailVO;
import com.kh.ttp.orderKinds.model.vo.OrderVO;
import com.kh.ttp.orderKinds.model.vo.PayVO;
import com.kh.ttp.orderKinds.model.vo.Receiver;
import com.kh.ttp.product.model.dao.ProductDao;
import com.kh.ttp.product.model.vo.CartSelectVO;
import com.kh.ttp.product.model.vo.CartVO;
import com.kh.ttp.product.model.vo.FundingSelectVO;
import com.kh.ttp.product.model.vo.ProductSelectVO;
import com.kh.ttp.product.model.vo.ProductVO;
import com.kh.ttp.productCategory.model.dao.ProductCategoryDao;
import com.kh.ttp.productCategory.model.vo.ProductCategory;
import com.kh.ttp.productFile.model.dao.ProductFileDao;
import com.kh.ttp.productFile.model.vo.ProductFile;
import com.kh.ttp.productOption.model.dao.ProductOptionDao;
import com.kh.ttp.productOption.model.vo.ProductOption;
import com.kh.ttp.user.model.vo.User;


@Service @EnableTransactionManagement
public class ProductServiceImpl implements ProductService {
	@Autowired
	private FundingDao fundingDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private ProductCategoryDao productCategoryDao;
	@Autowired
	private ProductFileDao productFileDao;
	@Autowired
	private ProductOptionDao productOptionDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private ReceiverDao receiverDao;
	@Override @Transactional
	public int drinkFundingInsert(ProductVO product, ProductFile productFile, ProductOption productOption, Funding funding,
			ProductCategory productCategory) {
		    if(productCategoryDao.drinkFundingInsert(sqlSession,productCategory)>0) {
				int result=productCategoryDao.drinkFundingSelect(sqlSession);
				product.setPdtCategNo(result);
				//System.out.println(p);
				if(productDao.drinkFundingInsert(sqlSession,product)>0) {
					int pdtNo = productDao.drinkFundingSelect(sqlSession);
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
	public int updateDrinkFunding(ProductVO product, ProductFile productFile, ProductOption productOption, Funding funding, 
			ProductCategory productCategory) {
		if(productDao.updateDrinkFunding(sqlSession,product)>0) {
			int categNo = productDao.selectPdtNo(sqlSession,product);
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
		return productDao.selectFundingList(sqlSession);
		
	}

	@Override
	public int newDrinkFundingListCount() {
		return productDao.newDrinkFundingListCount(sqlSession);
	}

	@Override
	public ArrayList<FundingSelectVO> newDrinkFundingList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return productDao.newDrinkFundingList(sqlSession,rowBounds);
	}

	@Override
	public FundingSelectVO newDrinkFundingDetail(int pdtNo) {
		return productDao.newDrinkFundingDetail(sqlSession,pdtNo);
	}

	@Override
	public int increaseCount(int pdtNo) {
		return productDao.increaseCount(sqlSession,pdtNo);
		
	}

	@Override
	public ArrayList<FundingSelectVO> selectHotFundingList() {
		return productDao.selectHotFundingList(sqlSession);
	}

	@Override
	public ArrayList<FundingSelectVO> hotDrinkFundingList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return productDao.hotDrinkFundingList(sqlSession,rowBounds);
	}

	@Override 
	public FundingSelectVO selectDrinkFundingList(int pdtNo) {
		return productDao.selectDrinkFundingList(sqlSession,pdtNo);
	}
	@Override @Transactional
	public int deleteDrinkFunding(int pdtNo) {
		return productDao.deleteDrinkFunding(sqlSession,pdtNo);
	}
	@Override @Transactional
	public int confirmFundingDrink(OrderDetailVO orderDetail, OrderVO order, User user, ProductVO product, 
			PayVO pay,Funding funding,Receiver receiver) {
		if(fundingDao.confirmFundingDrink(sqlSession,funding)>0) {
			int result1= productDao.confirmFundingDrinkPV(sqlSession,pay);
			int result  = receiverDao.selectReceiverNo(sqlSession,receiver);
			int payNo = productDao.selectPayNo(sqlSession);
			order.setReceiverNo(result);
			int result2=productDao.confirmFundingDrinkO(sqlSession,order);
			int orderNo = productDao.selectOrderNo(sqlSession);
			orderDetail.setOrderNo(orderNo);
			orderDetail.setPayNo(payNo);
			int result3 = productDao.confirmFundingDrinkOD(sqlSession,orderDetail);
			int result4 = productDao.decreaseStock(sqlSession,product);
			if(result1*result*result2*result3*result4 > 0) {
				return 1;
			}
			
		};
		return 0;
	}
	@Override @Transactional
	public int insertReceiver(Receiver r) {
		receiverDao.insertReceiver(sqlSession,r);
		return 0;
	}
	@Override @Transactional
	public int insertFundingBasket(CartVO cart) {
		productDao.insertFundingBasket(sqlSession,cart);
		return 0;
	}
	@Override
	public ArrayList<CartSelectVO> selectFundingCart(int userNo) {
		return productDao.selectFundingCart(userNo,sqlSession);
	}
	

	

	

}
*/