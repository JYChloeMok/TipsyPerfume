<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 게시판</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
    #board-wrap{
        width: 900px;
        margin: 0 auto;
        overflow: hidden;
    }
    #content-title{
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
    }
    .table td{
        vertical-align: middle;
        border-color: rgb(214, 214, 214);
        border-bottom: 1px solid;
    }
    tbody>tr{
    	cursor: pointer;
    }
    tbody>tr>td:not(:nth-child(2n)){
        background-color: rgb(240, 240, 240);
    }

    .board-no{width: 12%;}
    .board-title{width: 39%;text-align: left;}
    .board-writer{width: 15%;}
    .board-date{width: 13%;}
    .board-count{ width: 11%;}
    .like-count{width: 10%;}
    .comment-count{
    	font-size: 15px;
    	color: rgb(223, 190, 106);
    }

    #paging-area{
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .board-btn{
    	font-size: 18px;
        font-weight: 600;
        border: 4px solid rgb(223, 190, 106);
        border-radius: 10px;
        background-color: rgb(255, 255, 255);
        color: rgb(223, 190, 106);
    }
    .board-btn:hover{
        background-color: rgb(223, 190, 106);
        color: rgb(255, 255, 255);
    }
    .modify-text{
    	color: rgb(110, 110, 110);
    	font-size: 10px;
    	vertical-align: top;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<section>
<div id="board-wrap">
    <div id="content-title">
        ${boardCtgyName } 게시판
    </div>
<div class="table-wrap">
    <c:if test="${not empty loginUser}">
        <button id="board-write" class="board-btn">글작성</button>
    </c:if>
    <table class="table table-hover">
        <thead class="thead-dark">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>좋아요</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
        <c:when test="${empty list }">
        	<tr><td colspan="6"><br><br>게시글이 없습니다!<br><br><br></td></tr>
        </c:when>
        <c:otherwise>
        <c:forEach items="${list }" var="board">
        	<tr onclick="location.href='boardDetail?boardNo=${board.boardNo }'">
                <td class="board-no">${board.boardNo }</td>
                <td class="board-title">${board.boardTitle }<c:if test="${not empty board.boardModifyDate }"><span class="modify-text"> *수정됨</span></c:if> <c:if test="${not empty board.commentCount }"><span class="comment-count">[${board.commentCount }]</span></c:if></td>
                <td class="board-writer">${board.boardWriter }</td>
                <td class="board-date">${board.boardCreateDate }</td>
                <td class="like-count">${board.likeCount }</td>
                <td class="board-count">${board.boardCount }</td>
            </tr>
        </c:forEach>
        </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<div id="paging-area">
    <ul class="pagination">
    	<c:choose>
	    	<c:when test="${pi.currentPage le 1 }">
	        	<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
	    	</c:when>
	    	<c:otherwise>
	        	<li class="page-item"><a class="page-link" href="board?boardCtgy=${boardCtgyCode}&page=${pi.currentPage-1 }">&lt;</a></li>
	    	</c:otherwise>
    	</c:choose>
    	
        <c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
			<c:choose>
				<c:when test="${p eq pi.currentPage }">
					<li class="page-item active"><a class="page-link" href="#">${p }</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="board?boardCtgy=${boardCtgyCode}&page=${p }">${p }</a></li>
				</c:otherwise>
			</c:choose>
        </c:forEach>
        
        <c:choose>
	    	<c:when test="${pi.currentPage ge pi.maxPage }">
	    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
	    	</c:when>
	    	<c:otherwise>
        		<li class="page-item"><a class="page-link" href="board?boardCtgy=${boardCtgyCode}&page=${pi.currentPage+1 }">&gt;</a></li>
	    	</c:otherwise>
    	</c:choose>
    </ul>
</div>
</div>
</section>
<script>
$(()=>{
	$("#board-write").click(()=>{
		location.href="boardWrite?boardCtgy=${boardCtgyCode}";
	})
})
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>