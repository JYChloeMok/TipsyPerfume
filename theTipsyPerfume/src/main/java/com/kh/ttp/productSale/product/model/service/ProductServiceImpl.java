package com.kh.ttp.productSale.product.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ttp.common.model.vo.PageInfo;
import com.kh.ttp.community.review.model.vo.ReviewVO;
import com.kh.ttp.productSale.product.model.dao.ProductDao;
import com.kh.ttp.productSale.product.model.vo.ProductSelectVO;
import com.kh.ttp.productSale.productInfo.model.vo.ProductOptionVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
	
	
	private final ProductDao productDao;
	private final SqlSessionTemplate sqlSession;
	
	
	
	@Override
	public int productCount(String pdtCteg) {
		return productDao.productCount(sqlSession, pdtCteg);
	}

	
	@Override
	public HashMap<String, Object> productMain(String pdtCteg) {
		
		HashMap<String, Object> pMap = new HashMap();
		
		pMap.put("pdtCteg", pdtCteg); // 식별자
		
		pMap.put("pMainListNew", productDao.productMain(sqlSession, pMap)); // 최신순
				
		pMap.put("sort", "BestSeller");
		pMap.put("pMainListBestSeller", productDao.productMain(sqlSession, pMap)); // 판매량순
		
		pMap.put("sort", "Popular");
		pMap.put("pMainListPopular", productDao.productMain(sqlSession, pMap)); // 위시리스트순

		return pMap;
	}
	
	
	@Override
	public ArrayList<ProductSelectVO> perfumeList(String sort, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtCteg", "F");
		pMap.put("sort", sort);
		return productDao.perfumePdtList(sqlSession, pMap, rowBounds);
	}

	
	@Override
	public ProductSelectVO perfumeDetail(int pdtNo) {  // pdtNo, F
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtNo", pdtNo);
		pMap.put("pdtCteg", "F");
		return productDao.perfumePdtDetail(sqlSession, pMap);
	}

	
	@Override
	public ArrayList<ProductSelectVO> alcoholList(String sort, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtCteg", "A");
		pMap.put("sort", sort);
		return productDao.alcoholPdtList(sqlSession, pMap, rowBounds);
	}

	
	@Override
	public ProductSelectVO alcoholDetail(int pdtNo) {  // pdtNo, A
		HashMap<String, Object> pMap = new HashMap();
		pMap.put("pdtNo", pdtNo);
		pMap.put("pdtCteg", "A");
		return productDao.alcoholPdtDetail(sqlSession, pMap);
	}
	
	// @@@ 여기서 장바구니에 SELECT할 때 현재 실 재고 개수가 DB에 즉각 반영되어야할 필요는 없음
	// => But 결제 시 현재 재고가 있는지 파악 + 재고 마이너스 + 돈을 빼고 넣는 작업은 => ACID보장되어야 
	// 최종 재고 반영은 주문&결제 시 UPDATE 트랜잭션 하나로
	
	
	/***************** ajax 요청 *****************/
	
	
	@Override
	public List<ProductOptionVO> ajaxProductOption(int pdtNo) {
		return productDao.selectPdtOptionOne(sqlSession, pdtNo);
	}


	@Override
	public ArrayList<ReviewVO> selectRecentReviewWithRownum(HashMap<String, Integer> pMap) {
		return productDao.selectRecentReviewWithRownum(sqlSession, pMap);
	}
	
	
	
	
	


}