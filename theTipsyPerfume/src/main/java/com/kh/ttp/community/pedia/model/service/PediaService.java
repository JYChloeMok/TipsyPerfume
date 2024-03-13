package com.kh.ttp.community.pedia.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.ttp.community.pedia.model.vo.PediaVO;

public interface PediaService {
	public ArrayList<PediaVO> selectPediaList(HashMap map);
	public PediaVO selectPediaInfo(HashMap map);
}
