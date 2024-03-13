<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Tipsy Perfume</title>
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

	<!-- 술 펀딩용 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



<style>
#alcohol{
			border-radius: 50%;
			margin:10px;
		}
		
.category1{
			border-radius: 50%;
			
}


.3_1_1{
	margin:30px;
}











</style>


</head>
<body>

	
	
	<jsp:include page="common/header.jsp" />
	
	<div style="width: 1200px; height: 1600px; margin: auto; text-align: center;">
		
		
		<div id="content_1">
			<!-- Slider main container -->
			<div class="swiper">
				<!-- Additional required wrapper -->
				<div class="swiper-wrapper">
					<!-- Slides -->
					<div class="swiper-slide"><img src="resources/image/common/main.jpg" width="1200" height="600" id="main"></div>
					<div class="swiper-slide"><img src="resources/image/common/main1.jpg" width="1200" height="600" id="main"></div>
					<div class="swiper-slide"><img src="resources/image/common/main2.jpg" width="1200" height="600" id="main"></div>
				</div>
			
				<!-- If we need pagination -->
				<div class="swiper-pagination"></div>
			
				<!-- If we need navigation buttons -->
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
			
				<!-- If we need scrollbar -->
				<div class="swiper-scrollbar"></div>
			</div>
		</div>
		
		<div id="content_2" style="width: 1200px; height: 300px; margin: auto; text-align: center; margin-top: 50px;">
			<div class="category1" >
				<a href="productMain.pr?pdtCteg=A"><img src="resources/image/common/alcohol.jpg" width="120" height="120" id="alcohol"></a>
				<a href="productMain.pr?pdtCteg=F"><img src="resources/image/common/perfume.jpg" width="120" height="120" id="alcohol"></a>
				<a href="funding.list"><img src="resources/image/common/alcohol2.jpg" width="120" height="120" id="alcohol"></a>
				<a href="funding.list"><img src="resources/image/common/perfume1.jpg" width="120" height="120" id="alcohol"></a>
			</div>
			<div class="category2">
				<br>
				<pre>  주류        |       향수        |     펀딩 주류     |     펀딩 향수</pre>
			</div>
		
		</div>
	
		<div id="content_3">
			<div class="title" style="margin-bottom:50px;">
				<h5>Promotion</h5>
				<h1>지금 핫한 펀딩</h1>
				<hr>
			</div>
			<div class="3_1" align="left" style="float:right; margin-right:50px;" >
				<div class="3_1_1">
					<a href="funding.list"><img src="resources/image/common/alcohol2.jpg" width="400" height="300" align="right" id="pro1" ></a>
				</div>
			</div>
			<div class="3_1_2" align="right" style="float:right; margin-right:60px;">
					<h2><b>기억에 남는 낭만</b><br></h2>
					<h2>		KH 와인</h2>
					<h5>
					포르투갈 북서부에 자리한 빈티지스러운 도시 포르토(Porto)에서 온,<br> 세상 달콤하고 높은 알콜 도수를 가진 두 얼굴의 와인, <br>포르투, 포트, 포르토 와인입니다.
					</h5>
				</div>
			
				
				
				
				
				
				
				
				
				
			
		
		</div>
		
		
		
		
		
		
	
	​
		
	</div><!-- 제일 겉 div -->
	<script>
			// 슬라이더 동작 정의
			const swiper = new Swiper('.swiper', {
				autoplay : {
					delay : 3000 // 3초마다 이미지 변경
				},
				loop : true, //반복 재생 여부
				slidesPerView : 1, // 이전, 이후 사진 미리보기 갯수
				pagination: { // 페이징 버튼 클릭 시 이미지 이동 가능
					el: '.swiper-pagination',
					clickable: true
				},
				navigation: { // 화살표 버튼 클릭 시 이미지 이동 가능
					prevEl: '.swiper-button-prev',
					nextEl: '.swiper-button-next'
				}
			}); 
		</script>
		<!--  <script type="text/javascript" src="resources/scripts/index/indexScript.js"></script>-->
	<jsp:include page="common/footer.jsp" />
	

</body>
</html>