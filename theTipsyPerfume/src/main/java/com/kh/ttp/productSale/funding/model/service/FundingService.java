package com.kh.ttp.productSale.funding.model.service;


import java.util.ArrayList;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.productSale.cart.model.vo.CartDTO;
import com.kh.ttp.productSale.cart.model.vo.CartSelectDTO;
import com.kh.ttp.productSale.funding.model.vo.FundingDTO;
import com.kh.ttp.productSale.funding.model.vo.FundingSelectDTO;
import com.kh.ttp.productSale.product.model.vo.ProductDTO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductCategoryDTO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductFileDTO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionDTO;
import com.kh.ttp.productSale.receiver.model.vo.ReceiverDTO;


public interface FundingService {
	
	int drinkFundingInsert(ProductDTO product, ProductFileDTO productFile, ProductOptionDTO productOption, FundingDTO funding, ProductCategoryDTO productCategory);
	
	int updateDrinkFunding(ProductDTO product, ProductFileDTO productFile, ProductOptionDTO productOption, FundingDTO funding, ProductCategoryDTO productCategory);

	public ArrayList<FundingSelectDTO> selectNewFundingList();

	public int newDrinkFundingListCount();

	public ArrayList<FundingSelectDTO> newDrinkFundingList(PageInfo pi);

	public FundingSelectDTO newDrinkFundingDetail(int pdtNo);

	public int increaseCount(int pdtNo);

	public ArrayList<FundingSelectDTO> selectHotFundingList();

	public ArrayList<FundingSelectDTO> hotDrinkFundingList(PageInfo pi);

	public FundingSelectDTO selectDrinkFundingList(int pdtNo);

	public int deleteDrinkFunding(int pdtNo);

	//public int confirmFundingDrink(OrderDetailDTO od, OrderDTO o, User u, ProductDTO p, PaymentDTO pv,FundingDTO f,ReceiverDTO r);

	public int insertReceiver(ReceiverDTO r);

	public int insertFundingBasket(CartDTO cart);
	
	public ArrayList<CartSelectDTO> selectFundingCart(int userNo);


}
