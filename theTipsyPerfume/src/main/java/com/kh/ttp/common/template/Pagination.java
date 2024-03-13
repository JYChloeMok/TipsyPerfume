package com.kh.ttp.common.template;

import com.kh.ttp.common.model.vo.PageInfo;

public class Pagination {
	public static PageInfo getPageInfo(int listCount, int currentPage,
			  int boardLimit, int pageLimit) {
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) endPage = maxPage;
		
		return new PageInfo(listCount, currentPage,boardLimit,pageLimit,maxPage,startPage,endPage);
		}

}
