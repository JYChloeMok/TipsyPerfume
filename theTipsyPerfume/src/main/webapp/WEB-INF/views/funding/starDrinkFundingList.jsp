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
	
	.funding-list1,.funding-list2,.funding-list3,.funding-list4{
		height : 100%;
		width : 25%;
		float:left;
	}
	.fundingList-area{
		height : 80%;
	}
	h3:hover {
		font-size : 32px;
		cursor : pointer;
	}
	#pagingArea {width:10%;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<h1 class="drinkFunding-title">주류 펀딩</h1>
	<div id="outer">
		<div id="normal-drink">
			<h3 class="subtitle">별점순 주류 펀딩</h3>
			<div class="fundingList-area">
				<div class="funding-list1">
				
				</div>
				<div class="funding-list2">
				
				</div>
				<div class="funding-list3">
				
				</div>
				<div class="funding-list4">
				
				</div>
			
			</div>
		</div>
		<div id="hot-drink">
			
			<div class="fundingList-area">
				<div class="funding-list1">
				
				</div>
				<div class="funding-list2">
				
				</div>
				<div class="funding-list3">
				
				</div>
				<div class="funding-list4">
				
				</div>
			</div>
		</div>
		<div id="rank-drink">
			
			<div class="fundingList-area">
				<div class="funding-list1">
				
				</div>
				<div class="funding-list2">
				
				</div>
				<div class="funding-list3">
				
				</div>
				<div class="funding-list4">
				
				</div>
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
	                    	<li class="page-item"><a class="page-link" href="starDrinkFunding.list?cPage=${pi.currentPage-1 }">Previous</a></li>
	                    </c:otherwise>
                    </c:choose>
                    <c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
                    	<li class="page-item"><a class="page-link" href="starDrinkFunding.list?cPage=${p }">${p }</a></li>
                    </c:forEach>
                    	<c:choose>
                    		<c:when test="${pi.currentPage eq pi.endPage }">
                    			<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li class="page-item "><a class="page-link" href="starDrinkFunding.list?cPage=${pi.currentPage+1 }">Next</a></li>
                    		</c:otherwise>
                    
                    	</c:choose>
                </ul>
            </div>
            
	<script>
		$(function(){
			$('.subtitle').click(function(){
				location.href = "starDrinkFunding.list";
			});
		})
		
	</script>
	
	<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>