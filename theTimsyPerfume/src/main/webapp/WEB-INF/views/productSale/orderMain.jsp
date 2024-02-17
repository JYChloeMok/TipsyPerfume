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
					<div class="row order-content-block">
						<!-- 주문서 전송용 : 카트번호 -->
						<input type="hidden" value=${order.cart.cartNo }>
						
						<!-- 상품 이름, 옵션 정보 -->
						<div class="col-4 ps-5">
							<span class="cart-pdt-name">${order.pdtName}</span>
							&nbsp;
							<span>${order.productOption.pdtOptionFirst}</span>
						</div>
		
						<!-- 상품 수량 -->
						<div class="col-2">
							<input value="${order.cart.cartQuantity }" type="number" min="1" class="form-control" readOnly>
						</div>
						
						<!-- 상품 개당 가격 -->
						<div class="col-2">
							<input name="pdtOptionPrice" value="${order.productOption.pdtOptionPrice}" type="hidden" class="cart-pdt-option-price">
							<fmt:formatNumber value="${order.productOption.pdtOptionPrice}" pattern="#,###" />원
						</div>
						
						<!-- (상품 개당 가격 * 개수) -->
						<div class="col-2 item-amount-area">
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
				<div class="row">장바구니에 추가된 내역이 없습니다</div>
			</c:otherwise>
		</c:choose>
	</div>
	
	
	
<!-- 	<script>
		// x마크 누르면 오더페이지에 해당 상품 div remove()
		$(() => {
			$('.close-box-area').on('click', e => {
				//console.log($(e.target).closest('.cart-content-block'));
				if(confirm('해당 삭제하시겠습니까? (장바구니는 유지됩니다.)')) {
					$(e.target).closest('.cart-content-block').remove();
				}
			});
		});
		
		// pg, merchant_uid, email, name, tel, address, postcode
		
		// 결제하기 버튼 누르면 결제요청
		function requestPay() {
			$.ajax({
			
			});
			var IMP = window.IMP;
			IMP.init("imp77122200");
			IMP.request_pay(
				{
					pg: "kakaopay.TC0ONETIME",
					pay_method: "card",
					merchant_uid: "ORD20180131-0000011",   // 주문번호
					name: "노르웨이 회전 의자",
					amount: 64900,                         // 숫자 타입
					//
					buyer_email: "gildong@gmail.com",
					buyer_name: "홍길동",
					buyer_tel: "010-4242-4242",
					buyer_addr: "서울특별시 강남구 신사동",
					buyer_postcode: "01181"
				},
			function (response) { // callback
		            // callback
		            //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
		            
		            // 결제검증
					if (response.success) {
						verify(response.imp_uid); // verify필요
					}
		            
			});
		}
		
		function verifyAmount() {
			$.ajax({
				url : "https//api.iamport.kr/users/getToken".
				method : "post",
				headers : { "contentType" : "application/json"},
				data : {
					imp_key : '${API_KEY}',
					imp_secret : '${API_SECRET}'
				}
			})
			
		}
		
		$(() => {
			console.log(itemList);
		})
	</script>
	
	
	
	
	
		-------------------------------------------------------------------------------------------
		
		CART_NO,
		USER_NO,
		PDT_NO,
		PDT_OPTION_NO,
		CART_QUANTITY
		
		<script>
			// 주문버튼 클릭 시 
			$('#cartMainOrderBtn').on('click', () => {
				let $cartCheckedItems = $('.cart-check-box-one:checked');
				
				//if($cartCheckedItems.length > 0) {
					
				// totalAmount 비교용 토탈금액
				let $totalAmount = $('#cartTotalAmount').val();

				// itemCode배열 : 선택된 cartNo 배열로
				let itemCodeList = [];
				$cartCheckedItems.each((index, element) => {
					itemCodeList.push(element.value);
				});	
				console.log(itemCodeList);
				 // 체크된 상태면 어짜피 다른애들도 다 체크됐으니까 다른애들 가져와도 ㅇㅋ

				$.ajax({
					url : 'pay/kakao/ready',
					type : 'POST',
					data : JSON.stringify({
						totalAmount : $totalAmount,
						itemCodeList : itemCodeList,
						itemName : $('#cartItemName_0').text()
					}),
					contentType:"application/json; charset=utf-8",
					//dataType: 'json', // 받아올 때 타입 json parsing해서 객체로 써야함
					success : result => {
						console.log('성공')
						console.log(result);
						alert(result);
						location.href = result;
					},
					error : () => {
						console.log('에러발생');
					}
				});
			});
			//}
			//cart-item
			//$checkedItems = $('.cart-check-box-one:checked').closest('.cart-content-block');
			//cart-content-block
				
			
				
			
			// 재고 조회 ajax
			//function checkPdtStock() {
				
			//}
			//ProductOption
			//
		</script>
		<script>
			// 수량 변경 시 상품합계 업데이트(USER_NO, PDT_OPTION_NO, 상품합계(1개가격*개수) 상품번호
			//$('.cartQuantity').on('change', () => {
				//ajax
			//});
					
			// 모든 상품 체크 선택 시 (주문 취소하거나 페이지 재렌더링은 그냥 체크 다 해제된 상태)
			$('#cartCheckBoxAll').change(() => {
				let $cartCheckBoxAll = $('#cartCheckBoxAll');
				let $checkBoxOne = $('.cart-check-box-one');
				
				if($cartCheckBoxAll.prop('checked')) {
					$checkBoxOne.prop('checked', true);
				} else {
					$checkBoxOne.prop('checked', false);
				}
			});
		</script> -->
		
		
	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>	

</body>
</html>