package com.kh.ttp.productSale.common;

import java.nio.charset.Charset;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

@Component
public final class ProductSaleUtil {

	
	/**
	 * 매개변수로 들어온 pdtCteg(상품 카테고리)에 대한 값 체크
	 * 값에대한 null체크 먼저 수행 / "F"(향수) 혹은 "A"(주류)가 맞는지 체크함 
	 * 그 후 조건에 따라 boolean값을 반환함
	 */
	public boolean isPdtCtegValid(String pdtCteg) {
		if(null != pdtCteg && (pdtCteg.equals("F") || pdtCteg.equals("A"))) {
			return true;
		}
		return false;
	}
	
	
	/**
	 * 에러 발생 시 사용되는 ModelAndView객체를 설정하는 메소드
	 * @param errorMsg : 에러 시 출력할 메세지
	 * @return ModelAndView : 에러 메세지(Model)와 에러 페이지의 경로(View) 정보를 담음
	 */
	public ModelAndView makeErrorMsg(ModelAndView mv, String errorMsg) {
		mv.addObject("errorMsg", errorMsg)
		  .setViewName("common/errorPage");
		return mv;
	}
	
	
	public String makeErrorMsg(Model m, String errorMsg) {
		m.addAttribute("errorMsg", errorMsg);
		return "common/errorPage";
	}
	
	
	/***********************************/
	/**
	 * ResponseEntity를 위한 헤더 생성
	 * @param type : text, application 등
	 * @param subtype : html, json 등
	 * @param encoding : UTF-8 등
	 * @return HttpHeaders객체
	 */
	public HttpHeaders makeHeader(String type, String subtype, String encoding) {
		HttpHeaders header = new HttpHeaders();
		header.setContentType(new MediaType(type, subtype, Charset.forName(encoding)));
		return header;
	}
	/**********************************OK말고 다른거 해야하는데(코드 종류가 많음) */
	public ResponseEntity<String> makeAjaxErrorResult() {
		return new ResponseEntity<String>("ERROR", makeHeader("text", "html", "UTF-8"), HttpStatus.OK);
	}
	
	public ResponseEntity<String> makeAjaxErrorResult(String errorMsg) {
		return new ResponseEntity<String>(errorMsg, makeHeader("text", "html", "UTF-8"), HttpStatus.OK);
	}
	

}
