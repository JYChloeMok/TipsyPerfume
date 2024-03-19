package com.kh.ttp.productSale.common;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

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
	
	
	private String[] shapeIntoStrArr(String str) {
		// [1, 2, 3,]형태 문자열 String[] 배열화
		return str.replace(" ", "")
				  .replace("[", "")
				  .replace("]", "")
				  .split(",");
	}
	
	public List<Integer> transIntoIntegerArr(String str) {
		
		// 문자열 형태 다듬기
		String[] strArr = shapeIntoStrArr(str);
		// strArr가 유효하지 않으면 null리턴
		if(strArr.length < 1) {
			return null;
		}
		// 숫자형태 배열로 변환
		ArrayList<Integer> integerArr = new ArrayList<Integer>();
		for(String strValue : strArr) {
			try {
				// 숫자형태 아닐 경우 exception
				integerArr.add(Integer.parseInt(strValue));
			} catch (NumberFormatException e) {
				e.getStackTrace();
				return null;
			}
		}
		return integerArr;
	}
	
	
	
	
	
	
	/**
	 * 에러 발생 시 사용되는 ModelAndView객체를 반환하는 메소드
	 * @param mv : 에러메세지와 errorPage경로를 담은 ModelAndView객체
	 * @param errorMsg : 에러 시 출력할 메세지
	 * @return 만들어진 ModelAndView객체 반환<br>
	 * 에러메세지의 키값은 "errorMsg"<br>
	 * view는 에러 시 보여줄 페이지 경로로 미리 지정되어있음
	 */
	public ModelAndView makeErrorMsg(ModelAndView mv, String errorMsg) {
		mv.addObject("errorMsg", errorMsg)
		  .setViewName("common/errorPage");
		return mv;
	}
	
	
	/**
	 * 에러 발생 시 사용될 Model객체를 설정하고 에러페이지 경로 문자열을 반환하는 메소드
	 * @param m : 에러메세지를 담은 Model객체
	 * @param errorMsg : 에러 시 출력할 메세지
	 * @return 에러 시 보여줄 페이지 경로 String을 반환<br>
	 * Model에 설정해준 에러메세지의 키값은 "errorMsg"<br>
	 */
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
	
	public HttpHeaders makeTextHtmlHeader() {
		HttpHeaders header = new HttpHeaders();
		header.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		return header;
	}
	
	public HttpHeaders makeApplicationJsonHeader() {
		HttpHeaders header = new HttpHeaders();
		header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
		return header;
	}
	
	
	/**********************************OK말고 다른거 해야하는데(코드 종류가 많음) */
	/**
	 * @return : badRequest 400코드, "ERROR"문자열과 함께 ResponseEntity객체 반환 
	 */
	public ResponseEntity<String> makeAjaxErrorResult() {
		return ResponseEntity.badRequest() // HTTP 상태 코드가 BadRequest(400)인 ResponseEntity / 제네릭 Object상태, 리턴 시 String
							 .headers(makeHeader("text", "html", "UTF-8"))
							 .body("ERROR");
		//return new ResponseEntity<String>("ERROR", makeHeader("text", "html", "UTF-8"), HttpStatus.OK);
	}
	
	
	/**
	 * @param errorMsg : 상세 에러메세지
	 * @return : badRequest 400코드, 상세 에러메세지 문자열과 함께 ResponseEntity객체 반환<br>
	 * 상세 에러 메세지는 ("ERROR," + errorMsg)형태로 구성됨
	 */
	public ResponseEntity<String> makeAjaxErrorResult(String errorMsg) {
		return ResponseEntity.badRequest()
				 			 .headers(makeHeader("text", "html", "UTF-8"))
				 			 .body("ERROR," + errorMsg);
		//return new ResponseEntity<String>(errorMsg, makeHeader("text", "html", "UTF-8"), HttpStatus.OK);
	}
	
	
	/**
	 * @param status : HttpStatus코드 (ex. HttpStatus.BAD_REQUEST 등)
	 * @param header : HttpHeaders, ProductUtil의 makeHeader() 메소드와 함께 사용
	 * @param resultObj : 반환할 값<br>
	 * 사용예)<br>
	 * makeAjaxResult(HttpStatus.BAD_REQUEST, makeHeader("text", "html", "UTF-8"), returnValue); 
	 * @return
	 * ResponseEntity객체 (제네릭 미설정)
	 */
	public ResponseEntity makeAjaxResult(HttpStatus status, HttpHeaders header, Object resultObj) {
		return ResponseEntity.status(status) // 파라미터로 받은 HttpStatus로 빌더객체 반환
				 			 .headers(header)
				 			 .body(resultObj);
	}
	// 이건 쓸까?

	
	
	
	
	
}
