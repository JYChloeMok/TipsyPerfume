<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 공지 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<style>
    #notice-wrap{
        width: 900px;
        margin: 0 auto;
        overflow: hidden;
    }
    .content-title{
        font-size: 36px;
        font-weight: 600;
        text-align: center;
        margin: 40px 0;
    }
    .table-wrap{
        width: 900px;
        margin: 0 auto;
    }
    .table{
        text-align: center;
        border-collapse: collapse;
        background-color: #cccccc;
        --bs-table-bg: none;
    }
    .table tr{
        background-color: #cccccc;
    }
    .table td{
        vertical-align: middle;
        border-color: rgb(160, 160, 160);
    }
    tbody tr{
    	cursor: pointer;
    }
    .img{
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .notice-title-wrap{
        display: flex;
        align-items: center;
    }
    .thumbnail-wrap{
        width: 95px;
        height: 95px;
    }
    .notice-title{
        margin-left: 25px;
    }

    #paging-area{
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .notice-done{
        background-color: #ffffff !important;
    }
    .notice-done td{
        opacity: 0.4;
    }
</style>

<div id="notice-wrap">
<c:if test="${loginUser.memberType eq 'A' }">
<a href="noticeWrite">공지 작성하기</a>
</c:if>
    <div class="content-title">
        공지사항
    </div>
<div class="table-wrap">
    <table class="table">
        <thead class="thead-dark">
          <tr>
            <th>분류</th>
            <th>제목</th>
            <th>작성일</th>
          </tr>
        </thead>
        <tbody>
        	<c:forEach items="${list }" var="noti">
        		<tr <c:if test="${noti.noticeState eq 'N' }">class="notice-done"</c:if> onclick="location.href='noticeDetail?noticeNo=${noti.noticeNo}'">
            		<td>${noti.noticeCtgy }</td>
            		<td>
                		<div class="notice-title-wrap">
                    		<div class="thumbnail-wrap">
                        		<img class="img" src="${noti.noticeThumbnailFile }" alt="썸네일">
                    		</div>
                    		<div class="notice-title">
                    			${noti.noticeTitle }
                    		</div>
                		</div>
            		</td>
            		<td>${noti.noticeCreateDate }</td>
          		</tr>
        	</c:forEach>
        </tbody>
    </table>
</div>
<div id="paging-area">
    <ul class="pagination">
    	<c:choose>
	    	<c:when test="${pi.currentPage eq 1 }">
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
	    	<c:when test="${pi.currentPage eq pi.maxPage }">
	    		<li class="page-item disabled"><a class="page-link" href="#">&gt</a></li>
	    	</c:when>
	    	<c:otherwise>
        		<li class="page-item"><a class="page-link" href="review?page=${pi.currentPage+1 }">&gt</a></li>
	    	</c:otherwise>
    	</c:choose>
    </ul>
</div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>