<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style>

	*{
		padding:0;
		margin:0;
		border:none;
	}
	
	.box{
		width:1200px;
		height:100px;
	}
	
	.login-wrapper{
	    width: 400px;
	    height: 250px;
	    padding: 40px;
	    box-sizing: border-box;
	}
	
	.login-wrapper > h2{
	    font-size: 24px;
	    color: #6A24FE;
	    margin-bottom: 20px;
	}
	
	#login-form > input{
	    width: 100%;
	    height: 48px;
	    padding: 0 10px;
	    box-sizing: border-box;
	    margin-bottom: 16px;
	    border-radius: 6px;
	    background-color: #F8F8F8;
	}
	
	#login-form > input::placeholder{
	    color: #D2D2D2;
	}
	
	#login-form > input[type="submit"]{
	    color: #fff;
	    font-size: 16px;
	    background-color: rgb(254, 218, 36);
	    margin-top: 20px;
	}
	
	#login-form > label{
	    color: #999999;
	}
	
	.enroll-wrapper{
	    width: 400px;
	    height: 250px;
	    padding: 40px;
	    box-sizing: border-box;
		margin-right: 80px;
	}
	
	.enroll-wrapper > input{
	    width: 100%;
	    height: 48px;
	    padding: 0 10px;
	    box-sizing: border-box;
	    margin-bottom: 16px;
	    border-radius: 6px;
	    background-color: #F8F8F8;
	}
	
	.enroll-wrapper > input::placeholder{
	    color: #D2D2D2;
	}
	
</style>

	<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"/></script>


<script>
$(document).ready(function(){
	var key = getCookie("idChk"); //user1
	if(key!=""){
		$("#userEmail").val(key); 
	}
	 
	if($("#userEmail").val() != ""){ 
		$("#idSaveCheck").attr("checked", true); 
	}
	 
	$("#idSaveCheck").change(function(){ 
		if($("#idSaveCheck").is(":checked")){ 
			setCookie("idChk", $("#userEmail").val(), 7); 
		}else{ 
			deleteCookie("idChk");
		}
	});
	 
	$("#userEmail").keyup(function(){ 
		if($("#idSaveCheck").is(":checked")){
			setCookie("idChk", $("#userEmail").val(), 7); 
		}
	});
});
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
	 
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if(start != -1){
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}
</script>












</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<div class="allouter">
	
	<div class="box"></div>
		<div class="header">
			<div class="title">
				<h4 class="title" align="center">로그인</h4>
			</div>
			
			<div class="center-wrapper" align="center">
				<div class="login-wrapper" >
					<form action="login.me" method="post"  id="login-form">
						<input type="hidden" name="referer" value="${referer}">
						<input type="text" id="userEmail" name="userEmail" placeholder="이메일을 입력해주세요." >
						<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력해주세요." >
						<input type="checkbox" id="idSaveCheck" style="font-size:small; height:10px;">
  						<label for="remember" style="font-size:small">아이디 저장</label><br>
						<input type="submit" value="Login">
						<br><br><br>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	<div class="box"></div>


<jsp:include page="../common/footer.jsp" />
</body>
</html>