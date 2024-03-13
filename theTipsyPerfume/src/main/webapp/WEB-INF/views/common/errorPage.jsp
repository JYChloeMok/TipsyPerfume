<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ErrorPage</title>
   
    <!-- CSS파일 경로 -->
    <link href="resources/css/common/errorPage.css" rel="stylesheet">


</head>


<body>
    <div id="errorPageWrap">
        <div id="error_1" class="error">
            <h2>Oops...!</h2>
            <h2>Something went wrong</h2>
        </div>
        <div id="error_2" class="error">
            <div id="error_2_errorMsg">
	            <c:if test="${ not empty errorMsg }">
	            	<h2>${ errorMsg }</h2>
	            </c:if>
            </div>
            <div id="error_2_img">
                <img src="resources/image/common/errorPic.png" alt="오류 이미지">
            </div>
        </div>
    </div>
</body>

</html>