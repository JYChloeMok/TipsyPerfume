<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Product Detail</title>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

		
	<!-- Bootstrap v4 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

	<!-- CSS파일 경로적기 -->
	<link rel="stylesheet" href="resources/css/productSale/productDetail.css">
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="../common/header.jsp" />
	
	<div id="pdtDetailWrap">
		<c:choose>
			<c:when test="${not empty pdtDetail}">
				<input id="pdtNoDetail" type="hidden" value="${pdtDetail.pdtNo}">
				<input id="pdtCtegDetail" type="hidden" value="${pdtDetail.pdtCteg}">
				<div id="pdtDetailLeft" class="container pdt-detail-container">
					
					<div id="pdtDetailThumbnail" class="row pdt-dtl-mg-top-30">
						<img src="${pdtDetail.pdtImgSrc}">
					</div>
					
					<!-- 리뷰 미리보기 영역 ajax -->
					<div id="pdtDetailReviewArea">
					</div>

					
					<div id="pdtDetailReviewEnd" class="row detail-bg">
						<div class="col-3 pdt-dt-align-center">조회수 ${pdtDetail.pdtCount}</div>
						<div class="col-4 pdt-dt-align-center">평점 ★${pdtDetail.reviewAvg}/5</div>
						<div class="col-5 pdt-dt-align-center">리뷰 더보기 &gt;&gt;</div>
					</div>
				</div>
		
				<div id="pdtDetailRight" class="container pdt-detail-container">
				
					<div class="row pdt-section-tl pdt-dtl-mg-top-30">
						<h4 class="pdt-dt-align-center">${pdtDetail.pdtManufac } | ${pdtDetail.pdtGroup }</h4>
					</div>
					<div class="row pdt-section-tl">
						<h2 class="pdt-dt-align-center">${pdtDetail.pdtName }</h2>
					</div>
		
		
					<div id="pdtDetailIntro" class="row pdt-dt-pad pdt-dtl-mg-top-50">
						<h5 class="pdt-dt-align">${pdtDetail.pdtIntro }</h5>
					</div>
					<div id="pdtDetailDescription" class="row pdt-dt-align pdt-dt-pad detail-bg">
						<h6 class="pdt-dt-align">
							${pdtDetail.pdtDescription }
						</h6>
					</div>
		
		
					<div class="row pdt-section-su pdt-dt-align pdt-dt-pad pdt-dtl-mg-top-50 detail-bg">
						${pdtDetail.pdtPrice }
					</div>
					<div class="row pdt-section-su detail-bg">
						<div class="col-7 pdt-dt-align-center">용량 : 50ml 100ml 150ml</div>
						<div class="col-5 pdt-dt-align-center">배송비 : ${pdtDetail.pdtShipping }</div>
					</div>
		
		
					<div class="row pdt-section-or pdt-dtl-mg-top-50 detail-bg">
						<div id="pdtDetailClear" class="pdt-dt-align-center">
							<i class="bi bi-x"></i>
						</div>
						<div class="col pdt-dt-align-center">
							<select id="pdtDetailSelectInput" class="form-select form-select-sm pdt-dt-input">
								<!-- 옵션 띄워질 영역 -->
							</select>
							<div id="pdtDetailOptionInfo">
								<!-- 부가정보가 띄워질 영역 -->
							</div>
						</div>
						<div class="col-5 pdt-dt-align-center detail-bg">
							<input id="pdtDetailQuanInput" type="number" min="1" class="pdt-dt-input form-control" placeholder="수량선택">
						</div>
					</div>
					<div class="row pdt-section-or detail-bg">
						<div id="pdtDetailTotalPrice" class="col pdt-dt-align-center ">상품가격 * 선택개수 script로 200,000원</div>
						<div class="col-3 pdt-dt-align-center ">
							<button id="detailAddCartBtn" class="btn btn-sm btn-primary">장바구니</button>
						</div>
						<div class="col-3 pdt-dt-align-center ">
							<button onclick="location.href='productOrder.pr'" class="btn btn-sm btn-primary">주문하기</button>
						</div><!--  -->
						
					</div>
					
					<script>
					
					

					
					
					</script>
		
				</div>
			</c:when>
			<c:otherwise>
				<div class="pdt-dt-align-center">표시할 상품 정보가 없습니다</div>
			</c:otherwise>
		</c:choose>
	</div>

	
	
	<script>
		// 주문하기는 ㅈ아바구니랑 똑같은데 카카오결제 실패하면 장바구니에서 사라짐
		// 장바구니는 실패해도 유지
		

		// ajax요청으로 리뷰 조회 후
		/*
		$(() => {
			$.ajax({
				//url : 'ajaxSelectRecentTwoReview.pr/' + $('#pdtNoDetail').val(),
				type : 'GET',
				success : result => {
					let reviewValue = '';
					console.log('리뷰 통신성공');
					console.log(typeof(result));
					
					for(let i in result) {
						reviewValue += '<div class="row pdt-dt-rv-row pdt-dtl-mg-top-30">'
									 + '<div class="col-3">'
									 + '<img src="' + result[i].thumbnail + '">'
									 + '</div>'
									 + '<div class="col-9">'
									 + '<div class="row pdt-dt-rv-content pdt-dt-align detail-bg">' + result[i].reviewContent + '</div>'
									 + '</div>'
									 + '</div>'
					}
					$('#pdtDetailReviewArea').html(reviewValue);
					
					
					//for(let i in result){
					//	$('#reviewImg' + i).attr('src', result[i].thumbnail);
					//	$('#reviewContent' + i).html(result[i].reviewContent);
					//}
				},
				error : () => {
					console.log('리뷰 조회 에러발생')
				}
			})
		});
		*/
		// 옵션선택, 수량선택 변화가 일어날 시
		// 1. 수량선택 요소 포워딩 당시 stock개수로 제한 (실시간 재고 반영은 주문결제 시 & stock만 조회하는 ajax요청 인터벌 15분정도 줘도 좋을듯)
		// 2. 옵션별 가격 * 선택한 개수 = 상품금액 계산 업데이트 
		$('#pdtDetailQuanInput, #pdtDetailSelectInput').on('change', () => {
			console.log('체인지~');
			let $pdtStock = $('#pdtDetailSelectInput option:selected'); // .indexOf('pdtOptionStockIs');
			console.log($('#pdtOptionStock').val());
			//let $index = $pdtStock.indexOf('pdtOptionPriceIs');
			//console.log(($pdtStock).indexOf('pdtOptionPriceIs')); //replace(/^pdtOptionPriceIs/gi, ''));
			//console.log($pdtStock.slice($index, $pdtStock.length));	
		/*
			let $numberInput = $('#pdtDetailQuanInput');
			let $totalPriceArea = $('#pdtDetailTotalPrice');
			
			$numberInput.attr('max', $pdtStock); // 키업에는 의미 없음
			$totalPriceArea.html((Number($pdtStock) * Number($numberInput.val())) + '원');
			
			//console.log(typeof $pdtStock); 100부터 안됨 => 타입이 문자열이라
			//console.log(typeof $numberInput.val() + '넘버인풋 밸류');
			if((Number($pdtStock) > 0) && (Number($numberInput.val()) > $pdtStock)) {
				$numberInput.val($pdtStock);
				alert('재고가 충분하지 않습니다! 현재 재고는 ' + $pdtStock + '개 입니다');
				console.log('너무큰숫자');
			}
			*/
		});

	</script>
	
	
	
	
	
	
	
	
	
	
	
	<!-- 푸터 -->
	<jsp:include page="../common/footer.jsp" />
	
	<script src="resources/js/productSale/productDetail.js"></script>
	

</body>
</html>