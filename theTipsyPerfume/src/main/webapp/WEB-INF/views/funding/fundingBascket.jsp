<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


<style>
	#cartMainWrap{
		width: 950px;
		margin-top: 80px;
		border: 1px solid black;
	}
	#cartMainWrap div{border: 1px solid black;}
	
	/* 장바구니 각 파트 상단 타이틀영역 */
	#cartMainBar {height: 50px;}
    #cartContentBar {height: 50px;}
	#cartMainWrap .cart-content-block{min-height: 100px; margin-top: 30px;}
	
	/* 각 파트 내부div 정렬 */
	#cartMainBar div,
	#cartContentBar div,
	#cartMainWrap .cart-content-block div,
	#cartSummary .col-4,
	#cartSummary .row {
		display: flex;
		align-items: center;
	}
	/* 중앙 정렬 요소들 */
	#cartMainWrap .cart-box-area, /* 체크박스 */
	#cartMainBar .col-2, /* 메인바 */
	#cartContentBar .col, .col-2, /* 콘텐트바 */
	#cartMainWrap .cart-content-block .col, /* 콘텐트블록 */
	.col-2,
	.cart-extra-info-area,
	.cart-extra-info-area .col-12,
	#cartSummary .col-4 /* 카트 서머리 */
	 { 
		justify-content: center;
		text-align: center;}
	/* 체크박스 */
	#cartMainWrap .cart-box-area {
		width: 30px;
	}
	/* 할인, 배송 정보 영역 */
	#cartMainWrap .cart-extra-info-area .row {
		width: 100%;
		height: 100%;
	}
	#cartMainWrap .cart-extra-info-area .ext-info-1 {height: 70%;}
	#cartMainWrap .cart-extra-info-area .ext-info-2 {height: 30%;}
	
	/* 총 합계, 주문버튼 */
	#cartSummary .row{min-height: 50px;}
	.product-img {
		width : 100px;
		height : 100px;
		margin-right : 20px;
		border : 1px solid black;
	}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div id="cartMainWrap" class="container">
		<div id="cartMainBar" class="row">
			<div class="cart-box-area"><input type="checkbox" id="check-all"></div>
			<div class="col ps-5" >전체선택</div>
			<div class="col-2"><button class="btn btn-danger">삭제</button></div>
			<div class="col-2"><button class="btn btn-primary">주문</button></div>
		</div>
		
		<br/>
		<br/>
			
		<div id="cartContentBar" class="row">
			<div class="cart-box-area"><input type="checkbox"></div>
			<div class="col-4 ps-5">상품(옵션)</div>
			<div class="col">수량</div>
			<div class="col-2">가격</div>
			<div class="col-2">펀딩 진행률</div>
			<div class="col-2">상품 합계</div>
		</div>
		
		<c:forEach items="${cartSelect }" var="cartSelect">
		<div class="row cart-content-block">
			<div class="cart-box-area"><input type="checkbox" class="cart-checked"></div>
			<div class="col-4 ps-5"><img alt="상품사진" src="${cartSelect.pdtFileUpload }" class="product-img">${cartSelect.pdtName }</div>
			<div class="col">${cartSelect.cartQuantity }</div>
			<div class="col-2">${cartSelect.pdtOptionPrice }</div>
			<div class="col-2 p-0 cart-extra-info-area">
				<div class="row">
					<div class="col-12 ext-info-1">${cartSelect.fundingFee }/${cartSelect.cuttingPrice }</div>
				</div>
			</div>
			<div class="col-2 total-price">${cartSelect.total }</div>
		</div>
		</c:forEach>
		
		
		
		<br/>
		<br/>	
		<br/>	
		
		<div id="cartSummary" class="row">
			<div class="col">
				<div class="row ps-5" >전체금액</div>
				<div class="row ps-5" id="funding-total1">0</div>
				<div class="row ps-5" id="funding-total2">0</div>
			</div>
			<div class="col-4">
				<button class="btn btn-primary">주문</button>
			</div>
		</div>
	</div>
	
	
	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>	
	
	<script>
	// 상품 왼쪽 체크박스 누를시 하단에 전체 금액이 바뀌게 하는 script
		$(function(){
			var a = ' ';
			$('.cart-checked').click(function() {
				if ($(this).is(':checked')){
					
					const total = Number($(this).parent().nextAll(".total-price").text());
					console.log(total);
					
					a =Number(a)+ total;
					$('#funding-total2').html(a);
					
				}
				else{
					
					const total = Number($(this).parent().nextAll(".total-price").text());
					a = Number(a) - total;	
					$('#funding-total2').html(a);
				}
			})
		})
		//전체 체크 해제 기능
		$(function(){
			$('#check-all').click(() => {
				let $all = $('#check-all').prop('checked');
				if($all){
					$('.cart-checked').prop('checked',true);
				}
				else{
					$('.cart-checked').prop('checked',false);
				}
			})
		});
	</script>

</body>
</html>