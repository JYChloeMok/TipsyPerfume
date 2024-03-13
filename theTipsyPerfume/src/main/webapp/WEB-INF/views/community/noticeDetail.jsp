<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 공지 페이지</title>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<style>
    #notice-wrap{
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
    .my-table{
        width: 100%;
        text-align: center;
        border-spacing: 0px;
        border-collapse: collapse;
        margin-bottom: 30px;
    }
    .my-table tr{
        border-style: solid;
        border-width: 2px 0px;
        border-color: rgb(165, 165, 165);
    }
    .my-table td{padding: 15px 0px;}
    .title-head{
        background-color: rgb(221, 221, 221);
        width: 350px;
        text-align: center;
    }
    .top-text{
        color: rgb(148, 148, 148);
        font-size: 14px;
    }
    .notice-content{
        text-align: center;
        font-size: 16px;
        white-space: pre-wrap;
    }
    .notice-content-image{
        width: 700px;
        margin: 0 auto;
        margin-bottom: 100px;
    }
    .img{
        width: 100%;
    }
</style>
<section>
<div id="notice-wrap">
<c:if test="${loginUser.memberType eq 'A' }">
<c:choose>
<c:when test="${notice.noticeState eq 'Y' }">
	<a href="noticeEnd?noticeNo=${notice.noticeNo }">공지 종료하기</a>
</c:when>
<c:otherwise>
	<a href="noticeRestart?noticeNo=${notice.noticeNo }">공지 재시작하기</a>
</c:otherwise>
</c:choose>
	<a href="noticeUpdate?noticeNo=${notice.noticeNo }">공지 수정하기</a>
</c:if>
    <div id="content-title">
        공지사항
    </div>
    <table class="my-table">
        <tr>
            <th class="title-head">제목</th>
            <td>${notice.noticeTitle }</td>
        </tr>
        <tr>
            <td>작성일 <span class="top-text">${notice.noticeCreateDate }</span>&nbsp;&nbsp;&nbsp;조회수 <span class="top-text">${notice.noticeCount }</span></td>
        </tr>
    </table>
    <pre class="notice-content">
${notice.noticeContent }
    </pre>
    <div class="notice-content-image">
        <img class="img" src="${notice.noticeFile }">
    </div>
</div>
</section>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>