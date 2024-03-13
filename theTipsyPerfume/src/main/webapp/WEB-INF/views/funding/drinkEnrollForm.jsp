
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩 주류 등록 페이지</title>
	<style>
		#enroll-title{
			text-align : center;
			margin-top : 50px;
			font-weight : bold;
			margin-bottom : 50px;
		}
		#enroll-area{
			width : 800px;
			height : 1100px;
			background-color : lightgray;
			margin-bottom : 50px;
			margin-left : 600px;
			
		}
		#detailIntro,#shipping{
			height : 200px;
		}
		#button-area{
			margin-bottom:50px;
			margin-left : 1200px;
			
		}
		
		
	</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<h1 id="enroll-title">펀딩 등록</h1>
	<form id="fundingEnrollForm" method="post" action="insertDrink.fun" enctype="multipart/form-data">
	<div id="enroll-area">
		제품명 : <input type="text" id="productName" name="pdtName" class="form-control" required>
		
		제품 간단 소개 : <input type="text" id="simpleIntro" name="pdtIntro" class="form-control" required>
		
		제품 상세 설명 : <input type="text" id="detailIntro" name="pdtDescription" class="form-control" required>
		
		제품 대표 사진 : <input type="file" id="thumbnail" name="upfile" required>
		<br>
		배송 안내 : <input type="text" id="shipping" name="pdtShipping" class="form-control" required>	
		
		펀딩 목표 최소 가격 : <input type="number" id="min-price" name="cuttingPrice" class="form-control" placeholder="숫자만 입력해주세요 "required>
		
		가격 	: <input type="number" id="funding-price" name="pdtOptionPrice" class="form-control" placeholder="숫자만 입력해주세요" required>
		
		마감 날짜 : <input type="date" id="cutting-date" name="cuttingDate" required>
		
		제조자 이름 : <input type="text" id="maker" name="pdtManufac" value="${loginUser.userName }" readonly >
		
		제품군 분류 : <select name="pdtGroup">
					<option value="맥주">맥주</option>
					<option value="사케">사케</option>
					<option value="와인">와인</option>
					<option value="소주">소주</option>
					<option value="막걸리">막걸리</option>
				  </select>
				  <br>
		원료 재료 : <input type="text" id="ingredient" name="pdtIngredient" class="form-control">
		재고 : <input type="number" id="stock" name="pdtOptionStock" class="form-control">
		용량 : <input type="number" id="ml" name="pdtOptionFirst" class="form-control" placeholder="숫자만 입력하세요. 기준은 ml입니다.">
		도수 : <input type="number" id="dosu" name="pdtOptionSecond" class="form-control" placeholder="숫자만 입력하세요. 기준은 도입니다.">
	</div>
	<div id="button-area">
	<button type="submit" class="funding-btn">등록하기</button>
	<button type="reset" class="reset-btn">초기화</button>
	</div>
	</form>
	<jsp:include page="../common/footer.jsp" />
	
	
</body>
</html>