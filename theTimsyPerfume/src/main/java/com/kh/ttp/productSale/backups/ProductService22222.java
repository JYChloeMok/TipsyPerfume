/*
package com.kh.ttp.product.model.service;


import java.util.ArrayList;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.funding.model.vo.Funding;
import com.kh.ttp.orderKinds.model.vo.OrderDetailVO;
import com.kh.ttp.orderKinds.model.vo.OrderVO;
import com.kh.ttp.orderKinds.model.vo.PayVO;
import com.kh.ttp.orderKinds.model.vo.Receiver;
import com.kh.ttp.product.model.vo.CartSelectVO;
import com.kh.ttp.product.model.vo.CartVO;
import com.kh.ttp.product.model.vo.FundingSelectVO;
import com.kh.ttp.product.model.vo.ProductSelectVO;
import com.kh.ttp.product.model.vo.ProductVO;
import com.kh.ttp.productCategory.model.vo.ProductCategory;
import com.kh.ttp.productFile.model.vo.ProductFile;
import com.kh.ttp.productOption.model.vo.ProductOption;
import com.kh.ttp.user.model.vo.User;

public interface ProductService {
	
	int drinkFundingInsert(ProductVO product, ProductFile productFile, ProductOption productOption, Funding funding, ProductCategory productCategory);
	
	int updateDrinkFunding(ProductVO product, ProductFile productFile, ProductOption productOption, Funding funding, ProductCategory productCategory);

	public ArrayList<FundingSelectVO> selectNewFundingList();

	public int newDrinkFundingListCount();

	public ArrayList<FundingSelectVO> newDrinkFundingList(PageInfo pi);

	public FundingSelectVO newDrinkFundingDetail(int pdtNo);

	public int increaseCount(int pdtNo);

	public ArrayList<FundingSelectVO> selectHotFundingList();

	public ArrayList<FundingSelectVO> hotDrinkFundingList(PageInfo pi);

	public FundingSelectVO selectDrinkFundingList(int pdtNo);

	public int deleteDrinkFunding(int pdtNo);

	public int confirmFundingDrink(OrderDetailVO od, OrderVO o, User u, ProductVO p, PayVO pv,Funding f,Receiver r);

	public int insertReceiver(Receiver r);

	public int insertFundingBasket(CartVO cart);
	
	public ArrayList<CartSelectVO> selectFundingCart(int userNo);


}
*/