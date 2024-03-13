<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 or 회원가입 선택 모달</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	
	<!-- Bootstrap v4 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

	<!-- CSS파일 경로적기 -->
    <link href="resources/css/frags/loginJoinModal.css" rel="stylesheet">
    	
</head>

<body>
    <!-- 모달1: 로그인 / 회원가입 선택 버튼 ~~~~~~~~~~~~~~~~~~~~ -->
    <div class="modal fade" id="pdtMainFirstModal" tabindex="-1" aria-labelledby="pdtMainFirstModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<div id="pdtMainFirstModalLabel" class="modal-title">
						로그인이 필요한 서비스입니다
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" align="center">
					<button type="button" id="pdtFirstModalLoginBtn" class="btn btn-primary">로그인하러 가기</button>
					<br><br>
					<button type="button" id="pdtFirstModalEnrollBtn" class="btn btn-info">회원가입하러 가기</button>
					<br><br><br>
				</div>
			</div>
		</div>
	</div>
	
	
	<script src="resources/js/frags/loginJoinModal.js"></script>

</body>

</html>