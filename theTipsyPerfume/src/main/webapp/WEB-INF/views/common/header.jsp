<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <!-- header.html CSS파일 경로적기 -->
    <link href="resources/css/common/header.css" rel="stylesheet">
    <!-- <script src="resources/js/common/easy-scroll.js"></script> -->
    <style>
    #header_1_right_bottom {height: 30%; padding: 10px 140px 0px 0px;}
    #header_1_right_bottom form{width: 100%;}
    </style>
</head>
<body>
<header>
	<c:if test="${not empty alertMsg }">
		<script>
			$(() => {
				alert('${alertMsg}');
				location.href="loginForm.me";				
			});
		</script>
		<c:remove var="alertMsg"/>
	</c:if>

    <div id="headerWrap" class="container">
        <div id="header_1" class="full_width_divs">
            <div id="header_1_left" class="full_height_divs">
                <a class="logo-wrap" href="./"><img src="resources/image/common/logo.png"></a>
            </div>
            <div id="header_1_right" class="full_height_divs">
                <div id="header_1_right_top" class="full_width_divs">
                    <div id="header_inner_top_bannerline_1" class="full_height_divs">
                        <!-- 이벤트 대비 띠영역 -->
                    </div>
                    <!------------------- 비로그인  : 로그인   회원가입   장바구니(로그인 페이지로 연결) ----------->
                    <!------------------- 로그인    : 로그아웃 마이페이지 장바구니 -------------------------------->
                    <div id="header_inner_top_bannerline_2" class="full_height_divs">
                        <c:choose>
                            <c:when test="${empty loginUser }">
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="loginForm.me">로그인</a>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="logout.me">로그아웃</a>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    
                    <div id="header_inner_top_bannerline_3" class="full_height_divs">
                        <c:choose>
                            <c:when test="${ empty loginUser }">
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="enrollForm.me">회원가입</a>
                                </p>
                            </c:when>
                            <c:otherwise>
                            
                            <c:choose>
                            	<c:when test="${loginUser.memberType eq 'A'}">
                            	<p class="text-center fw-semibold">
                                    <a class="header-link" href="adminForm.me">관리자 페이지</a>
                                </p>
                            	</c:when>
                            	
                            	<c:otherwise>
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="myPage.me">마이페이지</a>
                                </p>
                                </c:otherwise>
                             </c:choose>
                                
                                
                                
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div id="header_inner_top_bannerline_4" class="full_height_divs">
                        <c:choose>
                            <c:when test="${not empty loginUser}">
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="cartMain.ca">장바구니</a>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="#" onclick="cartLoginConfirm();">장바구니</a>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div id="header_inner_top_bannerline_5" class="full_height_divs">
                        <c:choose>
                            <c:when test="${not empty loginUser}">
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="cartMain.f?userNo=${loginUser.userNo }">펀딩장바구니</a>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center fw-semibold">
                                    <a class="header-link" href="#" onclick="cartLoginConfirm();">펀딩 장바구니</a>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <!------------------------------------------------------------------------------------------>

                <div id="header_1_right_mid" class="full_width_divs">
                    <!-- 배너 이미지 or 여백 영역 -->
                </div>

                <div id="header_1_right_bottom" class="full_width_divs">
                    <form action="" method="get" class="d-flex" role="search">
                        <span id="header_search_inner_area_1">
                            <select class="search-select" name="condition">
                                <option selected value="allProduct">전체</option>
                                <option value="alcohol">주류</option>
                                <option value="perfume">향수</option>
                                <option value="groupBuying">공구</option>
                                <option value="crowdfunding">펀딩</option>
                            </select>
                        </span>
                        <span id="header_search_inner_area_2">
                            <input type="search" name="keyword" value="${ keyword }" class="search-bar" placeholder="Search" aria-label="Search">
                        </span>
                        <button type="submit" class="search-btn">
                            <i class="bi bi-search"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div id="header_2" class="full_width_divs">

            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    브랜드
                </p>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="productMain.pr?pdtCteg=A">주류</a></li>
                  <li><a class="dropdown-item" href="productMain.pr?pdtCteg=F">향수</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    공동구매
                </p>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">주류</a></li>
                  <li><a class="dropdown-item" href="#">향수</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    스페셜 펀딩
                </p>
                <ul class="dropdown-menu" >
                  <li><a class="dropdown-item" href="funding.list">커스텀 주류</a></li>
                  <li><a class="dropdown-item" href="#">커스텀 향수</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    커뮤니티
                </p>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="notice">공지</a></li>
                  <li><a class="dropdown-item" href="board?boardCtgy=RECIP">주류&페어링 추천</a></li>
                  <li><a class="dropdown-item" href="board?boardCtgy=FASHI">코디 추천</a></li>
                  <li><a class="dropdown-item" href="review">리뷰</a></li>
                  <c:if test="${not empty loginUser }"><li><a class="dropdown-item" href="pedia">도감 채우기</a></li></c:if>
                </ul>
            </div>
        </div>
    </div>
</header>

<style>
#header-bar-wrap{
	width: 100%;
	background-color: rgb(223, 190, 106);
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1000;
}
#header-bar{
	width: 1100px;
	height: 60px;
	margin: 0px auto;
	display: flex;
}
#header-bar-logo{width: 150px;}
.header-bar-middle{width: 660px;}
#header-bar-menu {
	display: flex;
	justify-content: center;
}
#header-bar-menu .dropdown {
    width: 20%;
    height: 100%;
    text-align: center;
    cursor: pointer;
}
#header-bar-menu .dropdown p {
    width: 90%;
    height: 100%;
    display: inline-block;
    margin: 0px;
    font-size: 22px;
    font-weight: 600;
    line-height: 60px;
    color: rgb(124 94 69);
}
#header-bar-toolbar{
	width: 200px;
	display: flex;
	justify-content: space-around;
	align-items: center;
}
</style>
<div id="header-bar-wrap" style="display:none;">
<div id="header-bar">
	<div>
		<a class="logo-wrap" href="./"><img id="header-bar-logo" src="resources/image/common/logo.png"></a>
	</div>
	<div id="header-bar-menu" class="header-bar-middle">
            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    브랜드
                </p>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="productMain.pr?pdtCteg=A">주류</a></li>
                  <li><a class="dropdown-item" href="productMain.pr?pdtCteg=F">향수</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    공동구매
                </p>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">주류</a></li>
                  <li><a class="dropdown-item" href="#">향수</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    스페셜 펀딩
                </p>
                <ul class="dropdown-menu" >
                  <li><a class="dropdown-item" href="funding.list">커스텀 주류</a></li>
                  <li><a class="dropdown-item" href="#">커스텀 향수</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <p data-bs-toggle="dropdown" aria-expanded="false">
                    커뮤니티
                </p>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="notice">공지</a></li>
                  <li><a class="dropdown-item" href="board?boardCtgy=RECIP">주류&페어링 추천</a></li>
                  <li><a class="dropdown-item" href="board?boardCtgy=FASHI">코디 추천</a></li>
                  <li><a class="dropdown-item" href="review">리뷰</a></li>
                  <c:if test="${not empty loginUser }"><li><a class="dropdown-item" href="pedia">도감 채우기</a></li></c:if>
                </ul>
            </div>
        </div>
        <div id="header-bar-toolbar">
        <c:choose>
        <c:when test="${empty loginUser }">
            <a class="header-link" href="loginForm.me"><i class="fa fa-sign-in" style="font-size:30px; color: rgb(124 94 69);"></i></a>
            <a class="header-link" href="enrollForm.me"><i class="material-icons" style="font-size:30px; color: rgb(124 94 69);">person_add</i></a>
            <a class="header-link" onclick="cartLoginConfirm();"><i class="fa fa-shopping-cart" style="font-size:30px; color: rgb(124 94 69);"></i></a>
        </c:when>
        <c:otherwise>
            <a class="header-link" href="logout.me"><i class="fa fa-sign-out" style="font-size:30px; color: rgb(124 94 69);"></i></a>
            <c:choose>
            <c:when test="${loginUser.memberType eq 'A'}">
            	<a class="header-link" href="adminForm.me"><i class="material-icons" style="font-size:30px; color: rgb(124 94 69);">person</i></a>
            </c:when>
                            	
            <c:otherwise>
            	<a class="header-link" href="myPage.me"><i class="material-icons" style="font-size:30px; color: rgb(124 94 69);">person</i></a>
            </c:otherwise>
            </c:choose>
            <a class="header-link" href="cartMain.ca"><i class="fa fa-shopping-cart" style="font-size:30px; color: rgb(124 94 69);"></i></a>
        </c:otherwise>
        </c:choose>
        </div>
</div>
</div>
<script>
$(()=>{
	$(window).scroll(()=>{
        if($(window).scrollTop()>280){
        	$("#header-bar-wrap").css("display","");
        }
        else{
        	$("#header-bar-wrap").css("display","none");
        }
    });
});
</script>

	<script src="resources/js/common/header.js"></script>
</body>
</html>