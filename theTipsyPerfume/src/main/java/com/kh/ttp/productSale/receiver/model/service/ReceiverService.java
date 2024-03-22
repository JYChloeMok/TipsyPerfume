package com.kh.ttp.productSale.receiver.model.service;

import java.util.List;

import com.kh.ttp.productSale.receiver.model.vo.ReceiverDTO;

public interface ReceiverService {
	
	/**
	 * 현재 로그인한 유저가 보유한 주소록 목록 조회
	 * @param userNo : 유저 번호(PK)
	 * @return : 주소록 정보가 담긴 리스트
	 */
	List<ReceiverDTO> selectReceiver(int userNo);
	
	// 주소록 등록
	int ajaxInsertReceiver(ReceiverDTO receiver);
	

}
