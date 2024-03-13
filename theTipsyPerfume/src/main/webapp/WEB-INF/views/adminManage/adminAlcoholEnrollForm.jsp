<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>펀딩 주류 등록 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<style>
		.table-outer{
		width:700px;
		height:1000px;
		float:left;
		margin-left:50px;
		margin-top:50px;
		
		
		}
		
	</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<style>
    .content{
	    align:center;
	    width:1200px;
	    height:1800px;
	    margin:auto;
    }
    
    .form-control {
	    display: block;
	    width: 60%;
	    height: calc(1.5em + 0.75rem + 2px);
	    padding: 0.375rem 0.75rem;
	    font-size: 1rem;
	    font-weight: 400;
	    line-height: 1.5;
	    color: #495057;
	    background-color: #fff;
	    background-clip: padding-box;
	    border: 1px solid #ced4da;
	    border-radius: 0.25rem;
	    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
	}
	
	
    </style>
	
	<div class="content">
	<jsp:include page="../adminManage/adminSideBar.jsp" />
		
		<div class="table-outer">
		<br><br>
		<h1 id="enroll-title">주류 상품 등록</h1>
		<br><br>
		
		<form id="alcoholEnrollForm" method="post" id="enroll-form">
		<div class="form-group">
			상품명 : <input type="text" id="pdtName" name="pdtName" class="form-control" required>
			<br>
			
			판매 가격 : <input type="number" id="pdtPrice" name="pdtPrice" class="form-control" placeholder="숫자만 입력해주세요 "required>
			<br>
			
			재고 : <input type="number" id="pdtStock" name="pdtStock" class="form-control" placeholder="숫자만 입력해주세요 ">
			<br>
			
			상품 소개 : <input type="text" id="pdtIntro" name="pdtIntro" class="form-control" required>
			<br>
			
			상품 상세 설명 : <input type="text" id="pdtDescription" name="pdtDescription" class="form-control" required>
			<br>
			
			원료/재료 : <input type="text" id="pdtIngredient" name="pdtIngredient" class="form-control" required>
			<br>
			
			판매 노출 여부 : <br>
			<select name="pdtStatus" id="pdtStatus" name="pdtStatus" >
				<option value="Y">판매중</option>
				<option value="N">판매중이 아님</option>
			</select>
			<br><br>
			
			공구 가능 여부 : <br>
			<select name="pdtGpStatus" id="pdtGpStatus" name="pdtGpStatus" >
				<option value="Y">공구+일반판매</option>
				<option value="N">일반판매</option>
			</select>
			<br><br>
			
			배송 안내 : <input type="text" id="pdtShipping" name="pdtShipping" class="form-control" required>	
			<br>
			
			<hr>
			
			
			
			
			용량 : <input type="number" id="ml" name="pdtOptionFirst" class="form-control" placeholder="숫자만 입력하세요. 기준은 ml입니다.">
			<br>
			
			도수 : <input type="number" id="dosu" name="pdtOptionSecond" class="form-control" placeholder="숫자만 입력하세요. 기준은 도입니다.">
			<br>
			
			
			
			
			<!-- tb-product-사진 시작 -->
			상품 대표 사진 : <input type="file" id="thumbnail" name="upfile" required>
			<br><br>
			
			
			
			
			<!-- tb-product-category카테고리 시작 -->
			주류 향수 구분 : <select name="pdtCteg" required>
							<option value="A">주류</option>
							<option value="F">향수</option>
						</select>
			<br><br>
			
			기성제품/커스텀 구분 : <select name="pdtFamily" required>
						<option value="B">기성제품</option>
						<option value="C">커스텀</option>
					</select>
			<br><br><br>
			
			브랜드/제조자 이름 : <input type="text" id="pdtManufac" class="form-control"  >
			<br><br>
			
			제품군 분류 : <select name="pdtGroup">
						<option value="맥주">맥주</option>
						<option value="사케">사케</option>
						<option value="와인">와인</option>
						<option value="소주">소주</option>
						<option value="막걸리">막걸리</option>
					  </select>
			<br><br>
		</div>
		
	
	
		<div id="button-area">
			<button type="submit" class="btn btn-primary">등록하기</button>
			<button type="reset" class="btn btn-danger">초기화</button>
		</div>
		</form>
	
	
	
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
	
</body>
</html>