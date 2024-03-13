<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 공지 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	#writer-wrap{
		width: 900px;
		margin: 0 auto;
	}
	#sub-title{
        font-size: 36px;
        font-weight: 600;
        text-align: center;
        margin: 40px 0;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div id="writer-wrap">
<div id="sub-title">
	공지 수정
</div>
<form id="enrollForm" method="post" action="noticeUpdate.do" enctype="multipart/form-data">
	<input type="hidden" name="noticeNo" value="${notice.noticeNo }">
	<table class="table">
		<tr>
			<th><label for="thumbnailFile">썸네일</label></th>
			<td><input type="file" id="thumbnailFile" class="form-control-file border" name="thumbnailFile" accept="image/gif, image/jpeg, image/png" required></td>
			<td>
				<a href="${notice.noticeThumbnailFile }" download="thumnail${board.noticeNo }">썸네일 이미지</a>
				<input type="hidden" name="noticeThumbnailFile" value="${notice.noticeThumbnailFile }"/>
			</td>
		</tr>
		<tr>
			<th><label>카테고리</label></th>
			<td>
				<select class="custom-select" name="noticeCtgy">
					<option>공지</option>
					<option>이벤트</option>
				</select>
			</td>
		</tr>
		<tr>
			<th><label for="noticeTitle">제목</label></th>
			<td colspan="2"><input type="text" id="noticeTitle" class="form-control" name="noticeTitle" value="${notice.noticeTitle }" required></td>
		</tr>
		<tr>
			<th><label for="noticeContent">내용</label></th>
			<td colspan="2"><textarea id="noticeContent" class="form-control" rows="20" style="resize:none;" name="noticeContent" required>${notice.noticeContent }</textarea></td>
		</tr>
		<tr>
			<th><label for="imgFile">이미지파일</label></th>
			<td><input type="file" id="imgFile" class="form-control-file border" name="imgFile" value="${notice.noticeFile }" accept="image/gif, image/jpeg, image/png" required></td>
			<td>
				<a href="${notice.noticeFile }" download="notice${board.noticeNo }">공지 이미지</a>
				<input type="hidden" name="noticeFile" value="${notice.noticeFile }"/>
			</td>
		</tr>
	</table>
	<br>
​
	<div align="center">
		<button type="submit" class="btn btn-primary">수정하기</button>
		<button type="reset" class="btn btn-danger">취소하기</button>
	</div>
</form>
</div>
</body>
</html>