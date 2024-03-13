<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최신순 주류 펀딩</title>
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
		height : 1500px;
		margin-left : 350px;
	}
	#outer > div{
		width: 100%;
	}
	#normal-drink{
		height : 33%;
		margin-bottom : 100px;
	}
	#hot-drink,#rank-drink{
		height : 33%;
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
		margin-bottom:50px;
	}
	.fundingList-area{
		height : 80%;
		
	}
	h3:hover {
		font-size : 32px;
		cursor : pointer;
	}
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
		font-size : 15px;
	}
	
	#pagingArea {width:fit-content; margin:auto;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<h1 class="drinkFunding-title">주류 펀딩</h1>
	<div id="outer">
		<div id="normal-drink">
			<h3 class="subtitle">최신순 주류 펀딩</h3>
			<div class="fundingList-area">
			<c:forEach items="${totalNewDrinkFunding }" var="tdf">
				<div class="funding-list">
					<input type="hidden" value="${tdf.pdtNo}" class="pno"/>
					<img src="${tdf.pdtFileUpload}" alt="썸네일 이미지"/>
					<h6 class="cutting-date">마감 날짜 : ${tdf.cuttingDate }</h6>
					<h4 class="percent">달성률 : ${tdf.fundingFee} / ${tdf.cuttingPrice }원 </h4>
					
					<h6>${tdf.pdtName }</h6>
					
					<h6>${tdf.pdtIntro }</h6>
					<h5 class="wish-list">♡</h5>
				</div>
			</c:forEach>
			</div>
			
			</div>
		</div>
		
		
		
		
	
	<div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
	                	<c:when test="${pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
	                    </c:when>
	                    <c:otherwise>
	                    	<li class="page-item"><a class="page-link" href="newDrinkFunding.list?cPage=${pi.currentPage-1 }">Previous</a></li>
	                    </c:otherwise>
                    </c:choose>
                    <c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
                    	<li class="page-item"><a class="page-link" href="newDrinkFunding.list?cPage=${p }">${p }</a></li>
                    </c:forEach>
                    	<c:choose>
                    		<c:when test="${pi.currentPage eq pi.endPage }">
                    			<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li class="page-item "><a class="page-link" href="newDrinkFunding.list?cPage=${pi.currentPage+1 }">Next</a></li>
                    		</c:otherwise>
                    
                    	</c:choose>
                </ul>
            </div>
            
	<script>
		$(function(){
			$('.subtitle').click(function(){
				location.href = "newDrinkFunding.list";
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