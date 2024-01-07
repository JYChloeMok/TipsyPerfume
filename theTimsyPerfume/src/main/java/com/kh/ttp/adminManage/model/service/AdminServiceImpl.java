package com.kh.ttp.adminManage.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttp.adminManage.model.dao.AdminDao;
import com.kh.ttp.adminManage.model.vo.AdminVo;
import com.kh.ttp.common.model.vo.PageInfo;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		return adminDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<AdminVo> selectList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return adminDao.selectList(sqlSession, rowBounds);
	}

	/*
	@Override
	public int insertAlcohol(AdminVo a) {
		
		return adminDao.insertAlcohol(sqlSession, a);
	}
	*/
	
	
	
	
	
	
}
