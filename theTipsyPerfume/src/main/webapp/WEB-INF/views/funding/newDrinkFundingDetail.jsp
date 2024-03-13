<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>디테일 뷰 </title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	div{
		box-sizing : border-box;
	}
	.detail-title{
		text-align : center;
		margin-top : 80px;
		margin-bottom : 100px;
		font-weight : bolder;
	}
	.wrapper{
		width : 1200px;
		height : 800px;
		margin-left : 350px;
	}
	.wrapper>div{
		height : 100%;
		float : left;
		
	}
	.product-img{
		width : 40%;
		
	}
	.product-info{
		width : 60%;
		
	}
	.product-img img{
		width : 100%;
		height : 50%;
	}
	.product-dinfo{
		text-align : center;
		margin-bottom : 20px;
	}
	#product-description{
		width : 500px;
		height : 250px;
		margin-left : 150px;
		resize : none;
		
	}
	#funding-delete{
		margin-top : 20px;
	}
	
	#back {
		margin-left : 50px;
		color : black;
		list-style: none;
		text-decoration: none;
	}
	#review-info{
		width : 1200px;
		height : 300px;
		margin-left : 350px;
		margin-bottom : 100px;
		
	}
	#review-info>div{
		height : 100%;
		float: left;
	}
	.review{
		width:18%;
		margin-left : 20px;
		margin-right : 20px;
	}
	.review>div{
		width:100%;
		
	}
	#review-img{
		height : 70%;
	}
	#review-content{
		height : 30%;
	}
	#review-img img{
		width : 100%;
		height : 100%;
	}
	.review > div{
		border : 1px solid black;
	}
	  .review-link{
        color: black;
    }
    .review-link:hover{
        color: rgb(223, 190, 106);
        text-decoration: none;
    }
    .review-title{
    	text-align : center;
    }
    .finish{
    	width : 400px;
    	height : 30px;
    	color : red;
    	margin-left: 200px;
    }
    .basket-button{
    	margin-top : 100px;
    	margin-left : 50px;
    	width : 200px;
    	background-color : brown;
    	color : white;
    }
    .cartQuantity{
    	width : 50px;
    }
    
	
	
	
	
	#pagingArea {width:fit-content; margin:auto;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
		<h4 class="detail-title">${fundingDetailList.pdtName }의 펀딩 정보</h4>
		<div class="wrapper">
			<div class="product-img">
				<img alt="사진" src="${fundingDetailList.pdtFileUpload }">
				<h6>review:${listCount}개            조회수:${fundingDetailList.pdtCount }</h6>
				<c:if test="${sessionScope.loginUser.memberType eq 'S'}">
					<form method="post" action="updateForm.fd">
						
						<input type="hidden" name="pno" value="${pno}"/>
						<button id="funding-update" type="submit">술 펀딩 수정</button>
					</form>
					<form method="post" action="delete.fd">
						<input type="hidden" name="pno" value="${pno }"/>
						<button id="funding-delete" type="submit">술 펀딩삭제</button>
					</form>
				</c:if>
			</div>
			<div class="product-info">
				
				<h5 class="product-dinfo">제품명 : ${fundingDetailList.pdtName }</h5>
				<h5 class="product-dinfo">가격 : ${fundingDetailList.pdtOptionPrice }</h5>
				<h5 class="product-dinfo">만든사람 : ${fundingDetailList.pdtManufac }</h5>
				<h5 class="product-dinfo">상품 설명  </h5> 
				<textarea id="product-description" readonly placeholder="${fundingDetailList.pdtDescription }
				용량 : ${fundingDetailList.pdtOptionFirst }ml
				도수 : ${fundingDetailList.pdtOptionSecond }도" ></textarea>
				<h5 class="product-dinfo">배송비 및 배송방법 : ${fundingDetailList.pdtShipping }</h5>
				<h5 class="product-dinfo">${fundingDetailList.fundingFee}/${fundingDetailList.cuttingPrice }</h5>
				<h6 class="product-dinfo">마감 날짜 : ${fundingDetailList.cuttingDate }</h6>
				<form id="fundingForm" method="post" action="purchase.fd">
					<input type="hidden" name="pno" value="${pno }">
					<input type="hidden" name="pdtName" value="${fundingDetailList.pdtName }">
					<input type="hidden" name="pdtOptionPrice" value=" ${fundingDetailList.pdtOptionPrice }">
					<input type="hidden" name="pdtShipping" value="${fundingDetailList.pdtShipping }">
					<input type="hidden" name="pdtFileUpload" value="${fundingDetailList.pdtFileUpload }">
					
					
						
							<c:choose>
								
									<c:when test="${cutting eq true}">
										
											<button type="submit">예약구매</button>
										
									</c:when>
								
								<c:otherwise>
									<button type="button" disabled class="finish">마감</button><br>
									
								</c:otherwise>
							</c:choose>
					
						
						
					
					<a href="funding.list" id="back">뒤로가기</a>
				</form>
					<form method="post" action="fundingBasket.insert">
						<button type="submit" class="basket-button">장바구니</button>
						<input type="number" class="cartQuantity" name="cartQuantity" value="1" min="1" max="10" required/>
						<input type="hidden" name="userNo" value="${loginUser.userNo }"/>
						<input type="hidden" name="pdtNo" value="${pno }"/>
						<input type="hidden" name="pdtOptionNo" value="${fundingDetailList.pdtOptionNo }" />
					</form>
				
					<c:if test="${cutting eq false}">
						<form action="reviewWrite">
							<button type="submit" class="finish">리뷰쓰기</button>
							<input type="hidden" name="pdtNo" value="${pno }">
							<input type="hidden" name="pdtName" value="${fundingDetailList.pdtName }">
						</form>
					</c:if>
				
				
				
					
					
				
			</div>
			
			
		</div>
		<div id="review-info">
			<h3 class="review-title">리뷰</h3>
			<div id="pagingArea">
				<ul class="pagination">
					<c:choose>
	                	<c:when test="${pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
	                    </c:when>
	                    <c:otherwise>
	                    	<li class="page-item"><a class="page-link" href="detail.fList">&lt;</a></li>
	                    </c:otherwise>
                    </c:choose>
                  </ul>
			</div>
			<c:forEach items="${reviewList }" var="reviewList">
				<div class="review">
					<a class="review-link" href="reviewViewer?reviewNo=${reviewList.reviewNo }">
						<div id="review-img">
							<img src="${reviewList.thumbnail }" alt="리뷰사진"/>
						</div>
						<div id="review-content">
							<h6>작성자 : ${reviewList.userNo }</h6>
							<h6>별점 : ${reviewList.reviewScore }</h6>
						</div>
					</a>
				</div>
			</c:forEach>
			
			<div id="pagingArea">
				<ul class="pagination">
					<c:choose>
	                	<c:when test="${pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
	                    </c:when>
	                    <c:otherwise>
	                    	<li class="page-item"><a class="page-link" href="detail.fList">&gt;</a></li>
	                    </c:otherwise>
                    </c:choose>
                  </ul>
			</div>
			
		</div>
	<jsp:include page="../common/footer.jsp"/>

</body>
</html>