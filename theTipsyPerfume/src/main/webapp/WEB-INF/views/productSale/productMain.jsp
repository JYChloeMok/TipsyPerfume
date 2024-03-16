<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 기본 메인</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- Bootstrap v4 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Swiper -->
	<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
	<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

	<!-- CSS파일 -->
    <link href="resources/css/productSale/productMain.css" rel="stylesheet">
    	
</head>

<body>

	<!-- 헤더 -->
	<jsp:include page="../common/header.jsp" />
	<!-- 로그인/회원가입 모달 -->
	<jsp:include page="../frags/loginJoinModal.jsp" />
	

    <div id="productMainWrap" class="container">
		<c:choose>
			<c:when test="${not empty pdtCteg and (pdtCteg eq 'A' or pdtCteg eq 'F')}">
				<!-- 식별자 pdtCteg의 값(A/F)따라 주류/향수 슬라이더 생성 -->
				<!-- 최신순 -->
	            <div class="pdt-main-inner-wrap">
	                <div class="pdt-mn-title-area">
	                	<c:if test="${pdtCteg eq 'A'}">
		                    <div class="pdt-mn-title-text pdt-mn-text1">NEW LIQUORS</div>
		                    <div id="productMainTextBottom" class="pdt-mn-title-text pdt-mn-text2">브랜드 주류 | 최신순</div>
	                	</c:if>
	                	<c:if test="${pdtCteg eq 'F'}">
	             	            <div class="pdt-mn-title-text pdt-mn-text1">NEW PERFUME</div>
		                    <div id="productMainTextBottom" class="pdt-mn-title-text pdt-mn-text2">브랜드 향수 | 최신순</div>
	                	</c:if>
	                </div>
	                <div div class="pdt-list-btn">
		               	<c:if test="${pdtCteg eq 'A'}">
		                    <button type="button" onclick="adultValidation('New');" class="btn btn-outline-info">더보기 &gt;</button>
		               	</c:if>
		               	<c:if test="${pdtCteg eq 'F' }">
		               		<button type="button" onclick="location.href='perfumeList.pr?sort=New'" class="btn btn-outline-info">더보기 &gt;</button>
		               	</c:if>
	                </div>
	                <!-- Slider main container -->
	                <div class="swiper">
	                    <!-- Additional required wrapper -->
	                    <div class="swiper-wrapper">
	                        <c:forEach var="product" items="${pMap.pMainListNew}">
		                        <c:if test="${pdtCteg eq 'A'}">
		                            <div class="swiper-slide" onclick="adultValidation('${product.pdtNo}');">
		                        </c:if>
		                        <c:if test="${pdtCteg eq 'F'}">
		                            <div class="swiper-slide" onclick="location.href='perfumeDetail.pr?pdtNo=${product.pdtNo}'">
		                        </c:if>
			                        <img src="${product.pdtImgSrc}">
			                        <div class="productBlockText1">${product.pdtManufac}</div>
			                        <div class="productBlockText2">${product.pdtName}</div>
			                        <div class="productBlockText3">${product.reviewAvg}/5</div>
			                        <div class="productBlockText4">${product.pdtIntro}</div>
	                            </div>
	                        </c:forEach>
	                    </div>
	                </div>
	            </div>

			
				<!-- 베스트셀러순 -->
				<div class="pdt-main-inner-wrap">
				    <div class="pdt-mn-title-area">
				    	<c:if test="${pdtCteg eq 'A'}">
				         <div class="pdt-mn-title-text pdt-mn-text1">BEST LIQUORS</div>
				         <div id="productMainTextBottom" class="pdt-mn-title-text pdt-mn-text2">브랜드 주류 | 베스트셀러</div>
				    	</c:if>
				    	<c:if test="${pdtCteg eq 'F'}">
				 	            <div class="pdt-mn-title-text pdt-mn-text1">BEST PERFUME</div>
				         <div id="productMainTextBottom" class="pdt-mn-title-text pdt-mn-text2">브랜드 향수 | 베스트셀러</div>
				    	</c:if>
				    </div>
				    <div div class="pdt-list-btn">
				    	<c:if test="${pdtCteg eq 'A'}">
				         <button type="button" onclick="adultValidation('BestSeller');" class="btn btn-outline-info">더보기 &gt;</button>
				    	</c:if>
				    	<c:if test="${pdtCteg eq 'F' }">
				    		<button type="button" onclick="location.href='perfumeList.pr?sort=BestSeller'" class="btn btn-outline-info">더보기 &gt;</button>
				    	</c:if>
				    </div>
				    <!-- Slider main container -->
				    <div class="swiper">
				        <!-- Additional required wrapper -->
				        <div class="swiper-wrapper">
				            <c:forEach var="product" items="${pMap.pMainListBestSeller}">
				             <c:if test="${pdtCteg eq 'A'}">
				                 <div class="swiper-slide" onclick="adultValidation('${product.pdtNo}');">
				             </c:if>
				             <c:if test="${pdtCteg eq 'F'}">
				                 <div class="swiper-slide" onclick="location.href='perfumeDetail.pr?pdtNo=${product.pdtNo}'">
				             </c:if>
				              <img src="${product.pdtImgSrc}">
				              <div class="productBlockText1">${product.pdtManufac}</div>
				              <div class="productBlockText2">${product.pdtName}</div>
				              <div class="productBlockText3">${product.reviewAvg}/5</div>
				              <div class="productBlockText4">${product.pdtIntro}</div>
				                </div>
				            </c:forEach>
				        </div>
				    </div>
				</div>
			
			
				<!-- 인기순 -->
	            <div class="pdt-main-inner-wrap">
	                <div class="pdt-mn-title-area">
		                	<c:if test="${pdtCteg eq 'A'}">
			                    <div class="pdt-mn-title-text pdt-mn-text1">POPULAR LIQUORS</div>
			                    <div id="productMainTextBottom" class="pdt-mn-title-text pdt-mn-text2">브랜드 주류 | 위시리스트</div>
		                	</c:if>
		                	<c:if test="${pdtCteg eq 'F'}">
	              	            <div class="pdt-mn-title-text pdt-mn-text1">POPULAR PERFUME</div>
			                    <div id="productMainTextBottom" class="pdt-mn-title-text pdt-mn-text2">브랜드 향수 | 위시리스트</div>
		                	</c:if>
	                </div>
	                <div div class="pdt-list-btn">
	                	<c:if test="${pdtCteg eq 'A'}">
		                    <button type="button" onclick="adultValidation('Popular');" class="btn btn-outline-info">더보기 &gt;</button>
	                	</c:if>
	                	<c:if test="${pdtCteg eq 'F' }">
	                		<button type="button" onclick="location.href='perfumeList.pr?sort=Popular'" class="btn btn-outline-info">더보기 &gt;</button>
	                	</c:if>
	                </div>
	                <!-- Slider main container -->
	                <div class="swiper">
	                    <!-- Additional required wrapper -->
	                    <div class="swiper-wrapper">
	                        <c:forEach var="product" items="${pMap.pMainListPopular}">
		                        <c:if test="${pdtCteg eq 'A'}">
		                            <div class="swiper-slide" onclick="adultValidation('${product.pdtNo}');">
		                        </c:if>
		                        <c:if test="${pdtCteg eq 'F'}">
		                            <div class="swiper-slide" onclick="location.href='perfumeDetail.pr?pdtNo=${product.pdtNo}'">
		                        </c:if>
			                        <img src="${product.pdtImgSrc}">
			                        <div class="productBlockText1">${product.pdtManufac}</div>
			                        <div class="productBlockText2">${product.pdtName}</div>
			                        <div class="productBlockText3">${product.reviewAvg}/5</div>
			                        <div class="productBlockText4">${product.pdtIntro}</div>
	                            </div>
	                        </c:forEach>
	                    </div>
	                </div>
	            </div>
			</c:when>
			<c:otherwise>
				<jsp:forward page="../common/errorPage.jsp" />
			</c:otherwise>
			
		</c:choose>
    </div>
    
    <!-- 푸터 -->
	<jsp:include page="../common/footer.jsp" />

	<!-- js파일 -->
	<script src="resources/js/productSale/productMain.js"></script>
	
	<script>
		console.log('${adultResult}' + ' <= 이전 결과');
		console.log('${loginUser}')
	</script>
	
	
	<!-- 성인이 아닌 유저의 경우 로그인창을 띄움 -->
	<c:if test="${adultResult eq 'N'}">
		<script>
			// 로그인 모달창
			$(() => {
				$('#pdtMainFirstModal').modal("show");
			});
		</script>
		<!-- adultResult의 값 삭제 -->
		<c:remove var="adultResult" scope="session" />
		<script>
			/*
			진행 흐름 : 주류 조회관련 요청 -> 성인인증 인터셉터
					 -> 성인은 요청 진행 그 외에는 adultResult에 "N"이라는 문자열과 함께 referer로 리다이렉팅
			adultResult : 성인인증 완료된 로그인 유저의 경우 아무 값도 존재하지 않음(null)
					    : 성인인증이 안된 유저의 경우 "N"이라는 문자열
			문제점		: 유저가 로그인을 먼저 하고 요청을 보내면 문제없이 실행되지만
						    로그인하지 않아 로그인 창으로 보내졌을 경우 세션에 "N"이 담기고
						    이 상태에서 로그인을 해도 세션의 "N"은 그대로 남아있게됨
						    그러므로 이 값을 지울 필요가 있음 (로그인한 성인유저에게도 계속 로그인창이 뜨게되기 때문)
						  p.s. loginUser와 겹쳐 의도치않은 동작이 일어나지 않도록 따로 키값을 배정
			*/
			console.log('알콜리스트/디테일 요청 시 성인 인터셉터');
			console.log('adultResult지운 후 => ' + '${adultResult}')
		</script>
	</c:if>
	

</body>

</html>