package com.kh.ttp.community.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ttp.community.notice.model.vo.NoticeVO;

@Repository
public class NoticeDAO {

	public int countNoticeList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.countNoticeList");
	}

	public ArrayList<NoticeVO> selectNoticeList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("noticeMapper.selectNoticeList", null, rowBounds);
	}

	public int increaseNoticeCount(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.increaseNoticeCount", noticeNo);
	}
	
	public NoticeVO selectNoticeDetail(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectNoticeDetail", noticeNo);
	}

	public int insertNotice(SqlSessionTemplate sqlSession, NoticeVO no) {
		return sqlSession.insert("noticeMapper.insertNotice", no);
	}

	public int noticeEnd(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.noticeEnd", noticeNo);
	}

	public int noticeRestart(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.noticeRestart", noticeNo);
	}

	public int updateNotice(SqlSessionTemplate sqlSession, NoticeVO no) {
		return sqlSession.update("noticeMapper.updateNotice", no);
	}
}
