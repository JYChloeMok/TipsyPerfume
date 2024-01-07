package com.kh.ttp.productSale.order.model.service;

import com.kh.ttp.productSale.order.model.vo.ReceiverVO;

public interface ReceiverService {
	
	// 주소록 등록
	int ajaxInsertReceiver(ReceiverVO receiver);

}
