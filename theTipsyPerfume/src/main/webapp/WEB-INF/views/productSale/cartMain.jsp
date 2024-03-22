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
	<link rel="stylesheet" href="resources/css/productSale/cartMain.css">


	
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<script>
		$(() => {
			customData = [{cartNo:1,pdtOptionNo:57,orderQuantity:1},
						  {cartNo:15,pdtOptionNo:79,orderQuantity:2}];
			
			
			let orderMessage = {orderMessage : '배송 요청사항'};
			let sending = {	
				// 자바의 OrderVO객체 payment필드
				payment : {
					paidAmount : 1,
					applyNum : 12,
					impUid : '19547352',
					merchantUid : '20240321353317180685',
					pgTid : 'StdpayCARDINIpayTest20240321015136665144',
					pgProvider : 'html5_inicis',
					payMethod : 'card',
					paidAt : 1710953497,
					payStatus : 'paid',
					customData : JSON.stringify(customData)
					// 퍼블릭 프로젝트 카드 정보 저장x 개인정보
				},
				orderMessage : '메세지입니다^^'
			}
			
			$.ajax({
				url : 'order',
				method : 'POST',
				data : JSON.stringify(sending),
				contentType : 'application/json',
				success : result => {
					console.log('주문서 생성 성공!!!!!!!!');
					console.log(result);
					let str = '';
					
					if(result.payStatus == 'errorRefund') {
						alert('결제오류로 인해 취소가 필요하지만 문제가 발생했습니다. 관리자에게 문의해주세요.');
					};
					
					if(result == 'success') {
						str = '주문에 성공했습니다!';
					} else if(result.result == 'itemShortage') {
						// 재고 부족
						str = '재고가 부족하거나 판매가 중단된 상품이 있습니다. 장바구니 메인 화면으로 이동해 수량을 조정해주세요.';
						showRefundAlert(result.payStatus);
					} else if(result.result == 'wrongAmount') {
						// 금액 검증 실패
						str = '금액 정보가 일치하지 않습니다. 문제 발생 시 관리자에게 문의해주세요.';
						showRefundAlert(result.payStatus);
					} else {
						console.log('order 주문서 생성 로직 통신은 성공했으나 이상 발생');
					}

					/*
					 * 결제 성공 시 "success"			: 결제가 완료되었다 + 불필요한 div 지움
					 * 재고 부족 시 "itemShortage"		: 재고가 부족한 상품이 있다 카트메인으로 이동한다
					 * (+ payStatus)
					 * 금액 검증 실패 시 "wrongAmount"	: 금액 검증이 실패했다
					 * (+ payStatus)
					 * 
					 * payStatus
					 * 결제 취소 성공 시 "refunded"		: 결제 취소가 성공했다
					 * 결제 취소 실패 시 "errorRefund"	: 결제 취소가 필요하지만 실패했다 관리자에게 문의해달라
					*/
				},
				error : () => {
					console.log('order 주문서 생성 로직 실패');
				}
			});
		})
	</script>
	<div id="cartMainWrap" class="container">
	
		<div id="cartMainBar" class="row">
			<div class="cart-box-area">
				<label class="check-box-label">
					<!-- 전체선택 박스 -->
					<input id="cartCheckBoxAll" type="checkbox" checked>
				</label>
			</div>
			<div class="col ps-5">전체선택</div>
			<div class="col-2"><button onclick="deleteCart()" type="button" class="btn btn-danger">삭제</button></div>
			<div class="col-2"><button onclick="makeOrder()" type="button" class="btn btn-primary">주문</button></div>
		</div>
		
		<br/>
		<br/>
			
		<div id="cartContentBar" class="row">
			<div class="cart-box-area">
				<!-- 프레임 맞추기 공백 -->
			</div>
			<div class="col-4 ps-5">상품(옵션)</div>
			<div class="col">수량</div>
			<div class="col-2">가격</div>
			<div class="col-2">상품 합계</div>
			<div class="col-2">배송비</div>
		</div>

		<!-- 상품 출력부 -->
		<c:choose>
			<c:when test="${not empty cartList }">
				<!-- 물건값 총 합계 계산용 변수 (출력 시 포맷태그 사용) -->
				<%-- <c:set var="cartAmount" value="0" /> --%>
				<c:forEach var="cMain" items="${cartList}" varStatus="status">
					<%-- <c:set var="cartAmount" value="${cartAmount + cMain.totalPrice}" /> --%>
					<div class="row cart-content-block">
						<div class="cart-box-area">
							<label class="check-box-label">
								<!-- 주문서 전송용 : 카트번호 -->
								<input type="checkbox" value=${cMain.cart.cartNo } class="cart-check-box" checked>
							</label>
						</div>
						<div class="col-4 ps-5">
							<!-- 상품 이름 -->
							<input name="pdtName" type="hidden" value="${cMain.pdtName}">
							<span class="cart-pdt-name">${cMain.pdtName}</span>
							&nbsp;
							<!-- 상품 옵션 정보 -->
							<input name="pdtOptionFirst" type="hidden" value="${cMain.productOption.pdtOptionFirst}" class="cart-pdt-option-first">
							<span>${cMain.productOption.pdtOptionFirst}</span>
						</div>
		
						<div class="col">
							<!-- 상품 수량 -->
							<input name="cartQuantity" value="${cMain.cart.cartQuantity }" type="number" min="1" class="cart-quantity pdt-dt-input form-control" placeholder="1">
						</div>
						
						<div class="col-2">
							<!-- 상품 개당 가격 -->
							<input name="pdtOptionPrice" value="${cMain.productOption.pdtOptionPrice}" type="hidden" class="cart-pdt-option-price">
							<fmt:formatNumber value="${cMain.productOption.pdtOptionPrice}" pattern="#,###" />원
						</div>
						
						<div class="col-2 item-amount-area">
							<!-- (상품 개당 가격 * 개수) @@@@@@@@@@@@@@@@@@@ -->
							<input value="${cMain.totalPrice}" type="hidden" class="cart-total-price">
							<fmt:formatNumber value="${cMain.totalPrice }" pattern="#,###" />원
						</div>
						
						<div class="col-2 p-0 cart-extra-info-area">
							<input type="hidden" class="pdt-shipping" value="${cMain.pdtShipping}">
							<c:choose>
								<c:when test="${cMain.pdtShipping eq 0}">
									무료배송
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${cMain.pdtShipping}" pattern="#,###" />원
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
								<!-- 물건값 총 합계 (전체 상품 금액 총 합) @@@@@@@@@@@@@@@@@@@ -->
								<input id="cartAmount" value="${cartAmount }" type="hidden">
								
								<%-- <fmt:formatNumber value="${cartAmount }" pattern="#,###" />원
								<c:remove var="cartAmount" /> --%>
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
						<button id="cartMainOrderBtn" onclick="makeOrder()" type="button" class="btn btn-primary">주문하기</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div>장바구니에 추가된 내역이 없습니다</div>
			</c:otherwise>
		</c:choose>
	</div>
	
	
	
	<!-- -------------------------------------------------------------------------------------- -->
	<button id="testBtn">테스트입니당</button>
	<script>
		// 화살표 함수가 this를 바인딩 하는 방식이 다름
		// 자신의 this를 갖지 않고 외부 스코프의 this(여기서 전역스코프)를 가르키게 됨
		// 일반함수로 정의해야 자신만의 this를 가짐
		$('#testBtn').on('click', () => {
		});
	</script>
		
		
	
		
	<!-- 정규식 모음 -->
	<script src="resources/js/common/devValidation.js"></script>
	<!-- 구매관련(cart, order 등)페이지 객체 -->
	<script src="resources/js/productSale/common/cartObj.js"></script>
	<!-- cartMain페이지 script파일 -->
	<script src="resources/js/productSale/cartMain.js"></script>
	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>	
</body>
</html>