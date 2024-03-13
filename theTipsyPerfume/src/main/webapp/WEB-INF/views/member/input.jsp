<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일인증</title>
</head>
<body>
	<h1>이메일을 입력해주세요. </h1>

	<form action="mail" method="POST">
		<input type="text" name="userEmail">
		<input type="submit" value="인증번호받기">
	
	</form>