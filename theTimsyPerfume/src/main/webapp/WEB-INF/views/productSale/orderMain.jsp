<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

		
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- CSS파일 적는곳 -->
	<!-- <link rel="stylesheet" href="resources/css/productSale/orderMain.css"> -->
	
	<!-- 포트원 결제 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

	<style>
		#orderMainWrap div {
			border: 1px solid black;
		}
	</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<h1>오더리스트</h1><br>
	
	
	<div id="orderMainWrap" class="container">

		<!-- 상품 출력부 -->
		<c:choose>
			<c:when test="${not empty orderMain}">
			
				<div id="orderContentBar" class="row">
					<div class="col-4 ps-5">상품(옵션)</div>
					<div class="col-2">수량</div>
					<div class="col-2">가격</div>
					<div class="col-2">상품 합계</div>
					<div class="col-2">배송비</div>
				</div>
				
				<c:forEach var="order" items="${orderMain.orderList}">
					<div class="row">
						<!-- 주문서 전송용 : 카트번호 -->
						<input type="hidden" value=${order.cart.cartNo }>
						
						<!-- 상품 이름, 옵션 정보 -->
						<div class="col-4 ps-5">
							<span class="order-pdt-name">${order.pdtName}</span>
							&nbsp;
							<span>${order.productOption.pdtOptionFirst}</span>
						</div>
		
						<!-- 상품 수량 -->
						<div class="col-2">
							<input value="${order.cart.cartQuantity }" type="number" min="1" class="form-control" readOnly>
						</div>
						
						<!-- 상품 개당 가격 -->
						<div class="col-2">
							<input name="pdtOptionPrice" value="${order.productOption.pdtOptionPrice}" type="hidden" class="order-pdt-option-price">
							<fmt:formatNumber value="${order.productOption.pdtOptionPrice}" pattern="#,###" />원
						</div>
						
						<!-- (상품 개당 가격 * 개수) -->
						<div class="col-2">
							<input value="${order.totalPrice}" type="hidden">
							<fmt:formatNumber value="${order.totalPrice }" pattern="#,###" />원
						</div>
						
						<!-- 배송비 -->
						<div class="col-2 p-0">
							<input type="hidden" class="pdt-shipping" value="${order.pdtShipping}">
							<c:choose>
								<c:when test="${order.pdtShipping eq 0}">
									무료배송
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${order.pdtShipping}" pattern="#,###" />원
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>

				<br/><br/><br/>	
				
				<!-- 체크된 상품 최종 정보  -->
				<div id="cartSummary" class="row">
					<div class="col">
						<div class="row ps-5">전체금액</div>
						<div id="123" class="row">
							<div id="cartAmountDiv" class="col summary-col">
								<!-- 물건값 총 합계 (전체 상품 금액 총 합) -->
								<input id="cartAmount" value="${cartAmount }" type="hidden">
							</div>
							<div class="col-1 summary-col"> | </div>
							<div id="shippingAmountDiv" class="col summary-col">
								<!-- 배송비 금액 (상품 배송비 중 최소 배송비) 뜨는곳 @@@@@@@@@@@@@@@@@@@ -->
							</div>
						</div>
						<div id="orderAmountDiv" class="row ps-5">
							<!-- 주문 최종 금액 (할인, 배송비 등 전부 계산한 최종 금액) 뜨는곳 @@@@@@@@@@@@@@@@@@@ -->
						</div>
					</div>
					<div class="col-4">
						<button id="orderMainPayBtn" onclick="requestPay()" type="button" class="btn btn-primary">결제하기</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">장바구니에 추가된 내역이 없습니다</div>
			</c:otherwise>
		</c:choose>
	</div>
	
	<script>
		// 최종 결제 금액
		// (디스플레이) 로딩 시 가격 계산해 띄워줌 (물건값 총 합계 / 배송비 / 최종 주문 금액)
		$(() => {
			cartStrUtilObj.makeAllAmountArea();
		});
	
	
		$(() => {
			// 배송지 정보
			$.ajax({
				url : 'receiver',
				method : 'GET',
				success : result => {
					console.log(result);
					console.log('배송지 정보 조회 성공!')
				},
				error : () => {
					console.log('배송지 정보 조회 에러발생');
				}
			});
		});
	</script>
		
	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>	

</body>
</html>