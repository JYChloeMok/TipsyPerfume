<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 리뷰 페이지</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
    #review-wrap{
        width: 900px;
        background-color: rgb(160, 149, 152);
        margin: 0 auto;
        overflow: hidden;
    }
    .content-title{
        font-size: 36px;
        font-weight: 600;
        text-align: center;
        color: rgb(255, 255, 255);
        margin: 40px 0;
    }
    #review-content{
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
    }
    .review-item-wrap:not(:nth-child(3n)){margin-right: 30px;}
    .review-item-wrap{
        width: 215px;
        height: 350px;
        color: rgb(223, 190, 106);
        background-color: rgb(35, 31, 32);
        padding: 4px 8px;
        border: 2px solid rgb(223, 190, 106);
        border-radius: 6px;
        box-sizing: border-box;
        float: left;
        margin-bottom: 30px;
    }
    .display-flex{display: flex;align-items: center;}
    .bottom-interval{margin-bottom: 3px}
    .img{
        height: 100%;
        width: 100%;
        object-fit: cover;
    }
    .profile{border-radius: 14px;}
    .profile-wrap{
        width: 28px;
        height: 28px;
        display: flex;
    }
    .name-wrap{
        font-size: 15px;
        margin-left: 5px;
    }
    .thumbnail-wrap{
        width: 175px;
        height: 175px;
        margin: 0 auto;
        border: 2px inset rgb(223, 190, 106);
    }
    .score-bg{
        width: 113px;
        height: 19px;
		background-image: url("resources/image/common/star-bg.svg");
        background-repeat: repeat-x;
        background-position: 0px 0px;
        background-size: auto 100%;
	}
    .score{
        height: 100%;
        background-image: url("resources/image/common/star.svg");
        background-repeat: repeat-x;
        background-position: 0px 0px;
        background-size: auto 100%;
    }
    .preview-wrap{
        height: 50px;
        font-size: 13px;
        overflow: hidden;
        text-overflow: ellipsis;
        word-wrap: break-word;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        line-height: 1.3;
    }
    .product-img-wrap{
        width: 50px;
        height: 50px;
        border: 1px solid rgb(223, 190, 106);
    }
    .price-wrap{
        margin-left: 10px;
        color: rgb(244, 235, 211);
    }

    #paging-area{
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }
    .review-link{
        color: rgb(223, 190, 106);
    }
    .review-link:hover{
        color: rgb(223, 190, 106);
        text-decoration: none;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<section>
<div id="review-wrap">
<div class="content-title">
    Review
</div>
<div id="review-content">
	<c:choose>
	<c:when test="${empty list }">
	<div class="content-title">
   		리뷰가 없습니다!
	</div>
	</c:when>
	<c:otherwise>
    <c:forEach items="${list }" var="review">
        <div class="review-item-wrap">
            <div class="display-flex bottom-interval">
                <div class="profile-wrap">
                	<c:choose>
                	<c:when test="${empty review.userProfile }">
                    	<img class="img profile" src="resources/image/common/blank-profile.png" alt="프로필사진">
                	</c:when>
                	<c:otherwise>
                    	<img class="img profile" src="${review.userProfile }" alt="프로필사진">
                	</c:otherwise>
                	</c:choose>
                </div>
                <div class="name-wrap">
                    ${review.userNo}
                </div>
            </div>
            <a class="review-link" href="reviewViewer?reviewNo=${review.reviewNo }">
            <div class="thumbnail-wrap bottom-interval">
                <img class="img" src="${review.thumbnail}" alt="썸네일">
            </div>
            <div class="review-score">
                <div class="score-bg"><div class="score" style="width: ${review.reviewScore*10}%;"></div></div>
            </div>
            <div class="preview-wrap bottom-interval">
                ${review.reviewContent}
            </div>
            </a>
            <div class="display-flex bottom-interval">
                <div class="product-img-wrap">
                    <img class="img" src="${review.productImg}" alt="상품이미지">
                </div>
                <div class="price-wrap">
                	${review.productPrice }
                </div>
            </div>
        </div>
    </c:forEach>
	</c:otherwise>
	</c:choose>
</div>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<div id="paging-area">
    <ul class="pagination">
    	<c:choose>
	    	<c:when test="${pi.currentPage le 1 }">
	        	<li class="page-item disabled"><a class="page-link" href="#">&lt</a></li>
	    	</c:when>
	    	<c:otherwise>
	        	<li class="page-item"><a class="page-link" href="review?page=${pi.currentPage-1 }">&lt</a></li>
	    	</c:otherwise>
    	</c:choose>
    	
        <c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
			<c:choose>
				<c:when test="${p eq pi.currentPage }">
					<li class="page-item active"><a class="page-link" href="#">${p }</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="review?page=${p }">${p }</a></li>
				</c:otherwise>
			</c:choose>
        </c:forEach>
        
        <c:choose>
	    	<c:when test="${pi.currentPage ge pi.maxPage }">
	    		<li class="page-item disabled"><a class="page-link" href="#">&gt</a></li>
	    	</c:when>
	    	<c:otherwise>
        		<li class="page-item"><a class="page-link" href="review?page=${pi.currentPage+1 }">&gt</a></li>
	    	</c:otherwise>
    	</c:choose>
    </ul>
</div>
</div>
</section>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>