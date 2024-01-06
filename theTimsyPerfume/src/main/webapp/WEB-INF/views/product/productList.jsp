<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 전체조회</title>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	
	<!-- Bootstrap v4 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <!-- CSS파일 경로적기 -->
    <link href="resources/css/product/productList.css" rel="stylesheet">

</head>

<body>
	<!-- 헤더 include -->
	<jsp:include page="../common/header.jsp" />
	
    <!-- 카트 include -->
    <jsp:include page="../frags/cartQuickAddModal.jsp" />
    
    
    <div id="productListWrap">
    	<c:choose>
    		<c:when test="${not empty pdtList and (pdtCteg eq 'A' or pdtCteg eq 'F')}">
		    	<input id="pdtListCteg" type="hidden" value="${pdtCteg}">
		        <div id="pdtListOuterLeft">
		            <jsp:include page="productSideBar.jsp" />
		        </div>
		
		
		        <div id="pdtListOuterRight" class="container">
				
		            <div id="pdtListTitleArea" class="row">
		            	<c:choose>
		            		<c:when test="${pdtCteg eq 'A'}">
		            			<div class="pdt-list-main-title" style="font-size:50px;">LIQUORS</div>
		               			<div class="pdt-list-sub-title" style="font-size:30px;">브랜드 | 주류</div>
		            		</c:when>
		            		<c:otherwise>
				                <div class="pdt-list-main-title" style="font-size:50px;">PERFUME</div>
				                <div class="pdt-list-sub-title" style="font-size:30px;">브랜드 | 향수</div>
		            		</c:otherwise>
		            	</c:choose>
		            </div>
		
		     		<div id="pdtListContentArea" class="row row-cols-3">
						<c:forEach var="pdt" begin="1" end="12"> <!-- 마지막 페이지 상품정보 없어도 정렬 깨지지 않도록 1 ~ 12로 12번 반복 / @@@마지막페이지 예쁘게 하려면 반복횟수 제한, 반복횟수는 = 3 * (floor((배열길이 - 1) / 3)) + 1) 일단 넘어가기 -->
							<div class="container col pdt-list-container-col">
								<c:if test="${not empty pdtList[(pdt - 1)]}">
									<!-- <input type="hidden" value="${pdtList[(pdt - 1)].pdtNo}" class="${pdtCteg}"> -->
									<input type="hidden" value="${pdtList[(pdt - 1)].pdtNo}" class="${pdtCteg}"> <!-- @@@사용자가 보내는 요청이 조작되지 않은 pdtNo인걸 어떻게 검증하지? => 일단 돌리고 나중에 -->
									<div class="bi bi-suit-heart container pdt-list-icon-area pdt-list-heart" onclick="ajaxChangeWishOne(this);"></div>
									<div class="bi bi-cart-plus  container pdt-list-icon-area pdt-list-cart" onclick="ajaxAddCartOne(this);"></div>
									<div class="row pdt-list-pdtImgSrc pdt-detail"><img src="${pdtList[(pdt - 1)].pdtImgSrc}"></div>
					                <div class="row pdt-list-pdtManufac pdt-detail">${pdtList[(pdt - 1)].pdtManufac}</div>
					                <div class="row pdt-name pdt-list-pdtName pdt-detail">${pdtList[(pdt - 1)].pdtName}</div>
					                <div class="row pdt-list-reviewAvg">
					                	<c:if test="${not empty pdtList[(pdt - 1)]}">★리뷰 ${pdtList[(pdt - 1)].reviewAvg}/5</c:if><!-- 마지막페이지 상품 없을 때 별점0.0뜨지 않도록 -->
					                </div>
					                <div class="row pdt-list-pdtIntro pdt-detail">${pdtList[(pdt - 1)].pdtIntro}</div>
					                <div class="row pdt-list-pdtDescription pdt-detail">${pdtList[(pdt - 1)].pdtDescription}${pdtList[(pdt - 1)].pdtDescription}</div>
								</c:if>
							</div>
						</c:forEach>
					</div>
					
			        <div id="pdtListPaginationArea" class="row">
		       		<c:set var="hrefPage" value="${pdtCteg eq 'A' ? 'selectAlcoholPdtList.pr' : 'perfumePdtList.pr'}" />
			        	<ul class="pagination">
		   				    <li class="page-item">
			        			<c:choose>
				        			<c:when test="${pi.currentPage eq 1}"> <!-- 앞 화살표 / 현재페이지 1이면 disabled -->
								        <a class="page-link disabled" aria-label="Previous">
								      		<span aria-hidden="true">&laquo;</span>
								        </a>
				        			</c:when>
				        			<c:otherwise> <!-- 앞 화살표 / 그 외에는 일반 li(a링크 curentPage - 1) -->
								        <a class="page-link" href="${hrefPage}?currentPage=${pi.currentPage - 1}" aria-label="Previous">
								      		<span aria-hidden="true">&laquo;</span>
								        </a>
				        			</c:otherwise>
			        			</c:choose>
						    </li>
			        		
			        		<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}"> <!-- 페이지버튼영역 / 시작페이지 ~ 끝페이지만큼 반복 -->
			        			<li class="page-item"><a class="page-link" href="${hrefPage}?currentPage=${i}">${i}</a></li>
			        		</c:forEach>
			        		
							<li class="page-item">
			        			<c:choose>
				        			<c:when test="${pi.currentPage eq pi.maxPage}"> <!-- 뒤 화살표 : 현재페이지 eq 전체 페이지개수면 disabled -->
										<a class="page-link disabled" aria-label="Next">
											<span aria-hidden="true">&raquo;</span>
										</a>
				        			</c:when>
				        			<c:otherwise> <!-- 뒤 화살표 / 그 외에는 일반li(a링크 currentPage + 1) -->
										<a class="page-link" href="${hrefPage}?currentPage=${pi.currentPage + 1}" aria-label="Next">
											<span aria-hidden="true">&raquo;</span>
										</a>
				        			</c:otherwise>
			        			</c:choose>
							</li>	
			        	</ul>
			        </div>
		        </div>
        
        
     		</c:when>
    		<c:otherwise>
    			<div class="pdt-dt-align-center">표시할 상품 정보가 없습니다</div>
    		</c:otherwise>
    	</c:choose>
    </div>
    
    <!-- 푸터 -->
    <jsp:include page="../common/footer.jsp" />
	
	
	<script>
	let $pdtListImgArea = $('.pdt-list-pdtImgSrc');

	// 마우스enter 시 하트와 장바구니 아이콘 보이게
	$pdtListImgArea.on('mouseenter', e => {
	    $(e.target).parent().find('.pdt-list-icon-area').addClass('pdt-list-max-opacity');
	});

	// 마우스leave 시 하트와 장바구니 아이콘 안보이게
	$pdtListImgArea.on('mouseleave', e => {
		$(e.target).parent().find('.pdt-list-icon-area').removeClass('pdt-list-max-opacity');
	});
	/* @@@처음에 event.stopPropagation();나 pointer-events: none;같은걸 활용했다면 더 좋았을까? */


	// 장바구니 빠른추가 모달창 생성 후 띄우기
	function ajaxAddCartOne(e) {
		if('${loginUser}' != '') {
			let $pdtNo = $(e).siblings('input[type=hidden]').val();
			let $pdtName = $(e).siblings('.pdt-name').text();
			ajaxCreateCartQuickAddModal($pdtNo, $pdtName);
			//console.log('스코프 밖 / pdtNo : ' + $pdtNo + ' / pdtName : ' + $pdtName);
		}
		else {
			alert('로그인이 필요한 서비스입니다!');
		}
	};
		    
		    
	// 장바구니 빠른 추가 (모달창의 장바구니 담기 버튼 클릭 시 선택된 옵션의 상품 1개 추가)
	$('#cartQuickAddBtn').click(() => {
		let $pdtNo = $('#cartSelectedPdtNo').attr('class');
		let $pdtOptionNo = $('#cartModalSelectInput').attr('option', 'selected').val();
		$.ajax({
			method : 'POST',
			url : 'ajaxCheckStockAddCart.ca',
			data : {
					pdtNo : $pdtNo,
					pdtOptionNo : $pdtOptionNo,
					pdtCteg : $('#pdtListCteg').val(),
					cartAddingQuantity : 1
			},
			success : result => {
				hideCartQuickAddModal();
				console.log('e다녀는오나');
				if(result === '1') {
					// 쇼핑 계속하기버튼 or 장바구니 가기버튼 팝업
					if(pdtListConfirmRemaining()) {
						location.href = "cartMain.ca";
					}
				}
				else if(result === '-1') {
					alert('재고가 없는 상품입니다!');
				}
				else {
					alert('잠시 후 다시 시도해주세요!');
				}
			},
			error : () => {
				alert('요청 실패');
			}
		});
	});

		
	// 상품 추가 후 장바구니로 이동할지 여부 체크
	function pdtListConfirmRemaining(){
		return confirm('상품 1개가 장바구니에 추가되었습니다! 장바구니로 이동하시겠습니까?');
	};
		    
		    
	// 하트 추가or삭제!(온클릭 시 호출 / 기존 위시리스트에 있는지 체크 후 변경함)
	function ajaxChangeWishOne(e) {
		if('${loginUser}' != '') {
			$.ajax({
				url : 'ajaxChangeWishOne.pa',
				method : 'POST',
				data : { pdtNo : $(e).siblings('input[type=hidden]').val() },
				success : result => {
					if(result === 'true') {
						$(e).removeClass('bi-suit-heart').addClass('bi-suit-heart-fill');
					}
					else if(result === 'false') {
						$(e).removeClass('bi-suit-heart-fill').addClass('bi-suit-heart');
					}
					else {
						alert('잠시 후 다시 시도해주세요');
					}
				},
				error : () => {
					alert('요청 실패');
				}
			});
		}
	};


	// 디테일 조회 요청
	$('.pdt-detail, .pdt-detail-img').on('click', e => {
		let $pdtHiddenInput = $(e.target).closest('.pdt-list-container-col').find('input[type=hidden]');
		let $pdtNo = $pdtHiddenInput.val();
		let $pdtCteg = $pdtHiddenInput.attr('class');
		if($pdtCteg === 'A') {
			location.href='alcoholPdtDetail.pr?pdtNo=' + $pdtNo;
		}
		else if($pdtCteg === 'F') {
			location.href='perfumePdtDetail.pr?pdtNo=' + $pdtNo;
		}
		else {
			alert('잘못된 요청입니다!')
		}
	});

	</script>

	    
	<script>
		// 페이지 온로드 시 상품 여러개 하트 조회 ajax 요청!
		// 온로드 시점에 좋아요여부 체크 => 하트클래스 변경
		// 채운하트 bi bi-suit-heart-fill 안채운하트 bi bi-suit-heart
		// pdtNo 배열 만들어 넘김
		// list 받아 반복문으로 각 (pdtNo요소).parent().find(.pdt-list-heart) 하트아이콘 선택
	    
		// 이건 후순위!! 하트 채워주는건 필수, 장바구니는 아이콘은 선택
		/*
		$pdtListCart.click(() => {
			console.log('장바구니');
			// ajax 요청 후 장바구니 담은게 있으면 장바구니fill / 아니면 빈장바구니
		});
		*/
    </script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- <script src="resources/js/product/productList.js"></script> -->

</body>

</html>