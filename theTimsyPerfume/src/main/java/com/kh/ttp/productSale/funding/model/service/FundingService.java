package com.kh.ttp.productSale.funding.model.service;


import java.util.ArrayList;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.productSale.billing.order.model.vo.OrderDetailVO;
import com.kh.ttp.productSale.billing.order.model.vo.OrderVO;
import com.kh.ttp.productSale.billing.pay.model.vo.PayVO;
import com.kh.ttp.productSale.cart.model.vo.CartSelectVO;
import com.kh.ttp.productSale.cart.model.vo.CartVO;
import com.kh.ttp.productSale.funding.model.vo.FundingSelectVO;
import com.kh.ttp.productSale.funding.model.vo.FundingVO;
import com.kh.ttp.productSale.product.model.vo.ProductVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductCategoryVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductFileVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverVO;
import com.kh.ttp.user.model.vo.User;


public interface FundingService {
	
	int drinkFundingInsert(ProductVO product, ProductFileVO productFile, ProductOptionVO productOption, FundingVO funding, ProductCategoryVO productCategory);
	
	int updateDrinkFunding(ProductVO product, ProductFileVO productFile, ProductOptionVO productOption, FundingVO funding, ProductCategoryVO productCategory);

	public ArrayList<FundingSelectVO> selectNewFundingList();

	public int newDrinkFundingListCount();

	public ArrayList<FundingSelectVO> newDrinkFundingList(PageInfo pi);

	public FundingSelectVO newDrinkFundingDetail(int pdtNo);

	public int increaseCount(int pdtNo);

	public ArrayList<FundingSelectVO> selectHotFundingList();

	public ArrayList<FundingSelectVO> hotDrinkFundingList(PageInfo pi);

	public FundingSelectVO selectDrinkFundingList(int pdtNo);

	public int deleteDrinkFunding(int pdtNo);

	public int confirmFundingDrink(OrderDetailVO od, OrderVO o, User u, ProductVO p, PayVO pv,FundingVO f,ReceiverVO r);

	public int insertReceiver(ReceiverVO r);

	public int insertFundingBasket(CartVO cart);
	
	public ArrayList<CartSelectVO> selectFundingCart(int userNo);


}
