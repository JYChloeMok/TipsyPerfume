package com.kh.ttp.community.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttp.community.model.dao.NoticeDAO;
import com.kh.ttp.community.model.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDAO noticeDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int countNoticeList() {
		return 0;
	}
	@Override
	public ArrayList<NoticeVO> selectNoticeList(RowBounds rowBounds) {
		return null;
	}
}
