package com.kh.ttp.community.notice.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttp.community.notice.model.dao.NoticeDAO;
import com.kh.ttp.community.notice.model.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class NoticeServiceImpl implements NoticeService {
	
	private final NoticeDAO noticeDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public int countNoticeList() {
		return noticeDao.countNoticeList(sqlSession);
	}
	@Override
	public ArrayList<NoticeVO> selectNoticeList(RowBounds rowBounds) {
		return noticeDao.selectNoticeList(sqlSession, rowBounds);
	}
	@Override
	public int increaseNoticeCount(int noticeNo) {
		return noticeDao.increaseNoticeCount(sqlSession, noticeNo);
	}
	@Override
	public NoticeVO selectNoticeDetail(int noticeNo) {
		return noticeDao.selectNoticeDetail(sqlSession, noticeNo);
	}
	@Override
	public int insertNotice(NoticeVO no) {
		return noticeDao.insertNotice(sqlSession, no);
	}
	@Override
	public int noticeEnd(int noticeNo) {
		return noticeDao.noticeEnd(sqlSession, noticeNo);
	}
	@Override
	public int noticeRestart(int noticeNo) {
		return noticeDao.noticeRestart(sqlSession, noticeNo);
	}
	@Override
	public int updateNotice(NoticeVO no) {
		return noticeDao.updateNotice(sqlSession, no);
	}
}
