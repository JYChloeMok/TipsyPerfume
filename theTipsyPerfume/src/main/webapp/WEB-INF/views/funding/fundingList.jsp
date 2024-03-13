<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주류 펀딩</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	div{
		box-sizing : border-box;
		
	}
	.drinkFunding-title{
		text-align : center;
		margin-top : 50px;
		color : rgb(223, 190, 106);
	}
	#outer{
		margin-top : 50px;
		width : 1200px;
		height : 1700px;
		margin-left : 350px;
	}
	#outer > div{
		width: 100%;
	}
	#normal-drink{
		height : 30%;
	}
	#hot-drink,#rank-drink{
		height : 35%;
	}
	h3{
		margin-left : 475px;
	}
	#hot-drink >h3{
		color : red;
	}
	#rank-drink > h3{
		color : rgb(223, 190, 106);
	}
	
	
	.funding-list{
		height : 100%;
		width : 25%;
		float:left;
	}
	.fundingList-area{
		height : 80%;
	}
	.fundingList-area > div {
		float : left;
	}
	h3:hover {
		font-size : 32px;
		cursor : pointer;
	}
	#funding-enroll{
		float:right;
	}
	#pagingArea {width:fit-content; margin:auto;}
	.fundingList-area img{
		width : 90%;
		height : 60%;
	}
	h6{
		text-align : center;
		
	}
	.fundingList-area img:hover{
		cursor : pointer;
	}
	.percent{
		color : green;
		font-weight : bolder;
	}
	.wish-list{
		text-align : left;
		font-weight : bolder;
	}
	.wish-list:hover{
		cursor : pointer;
	}
	.cutting-date{
		color: red;
		font-size : 20px;
	}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<h1 class="drinkFunding-title">주류 펀딩</h1>
	<c:if test="${not empty alertMsg }">
		<script>
			alertify.alert('축하축하~~~', '${alertMsg}',function(){alertify.success('이용')});
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>
	
	<div id="outer">
	<!-- 판매자만 술 펀딩 제품 등록하기 태그가 보이게 한다 -->
	<c:if test="${sessionScope.loginUser.memberType eq 'S'}">
	<a id="funding-enroll" href="drinkEnrollForm.funding">술 펀딩 제품 등록</a>
	</c:if>
		<div id="normal-drink">
			<h3 class="subtitle">최신순 주류 펀딩</h3>
			<div class="fundingList-area">
				<c:forEach items="${drinkFundingList }" var="drinkFundingList">
					<div class="funding-list">
						<input type="hidden" value="${ drinkFundingList.pdtNo}" class="pno"/>
						<img src="${drinkFundingList.pdtFileUpload}" alt="썸네일 이미지"/>
						<h6 class="cutting-date">마감 날짜 : ${drinkFundingList.cuttingDate }</h6>
						<h4 class="percent">달성률 : ${drinkFundingList.fundingFee} / ${drinkFundingList.cuttingPrice }원 </h4>
						<h6>${drinkFundingList.pdtName }</h6>
						<h6>${drinkFundingList.pdtIntro }</h6>
						<h5 class="wish-list">♡</h5>
					</div>
				</c:forEach>
			</div>
			</div>
			<div id="hot-drink">
			<h3 class="subtitle2">hot 주류 펀딩</h3>
			<div class="fundingList-area">
				
					<c:forEach items="${drinkHotFundingList }" var="drinkHotFundingList">
						<div class="funding-list">
							<input type="hidden" value="${ drinkHotFundingList.pdtNo}" class="pno"/>
							<img src="${drinkHotFundingList.pdtFileUpload}" alt="썸네일 이미지"/>
							<h6 class="cutting-date">마감 날짜 : ${drinkHotFundingList.cuttingDate }</h6>
							<h4 class="percent">달성률 : ${drinkHotFundingList.fundingFee} / ${drinkHotFundingList.cuttingPrice }원 </h4>
							
							<h6>${drinkHotFundingList.pdtName }</h6>
							
							<h6>${drinkHotFundingList.pdtIntro }</h6>
							<h5 class="wish-list">♡</h5>
						</div>
					</c:forEach>
				
				
			</div>
		</div>
		<div id="rank-drink">
			<h3 class="subtitle3">별점 순 주류 펀딩</h3>
			<div class="fundingList-area">
				<div class="funding-list">
				
				</div>
				<div class="funding-list">
				
				</div>
				<div class="funding-list">
				
				</div>
				<div class="funding-list">
				
				</div>
			</div>
		</div>
			
		</div>
		
	
	<script>
	
		$(function(){
			$('.subtitle').click(function(){
				location.href = "newDrinkFunding.list";
			});
		})
		$(function(){
			$('.subtitle2').click(function(){
				location.href = "hotDrinkFunding.list";
			});
		})
		$(function(){
			$('.subtitle3').click(function(){
				location.href = "starDrinkFunding.list";
			});
		})
		$(function(){
			$('.funding-list>img').click(function(){
				
				location.href="detail.fList?pno=" + $(this).prev().val();
				
			})
		})
	</script>
	
	<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>