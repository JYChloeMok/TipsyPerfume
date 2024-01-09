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
	<link rel="stylesheet" href="resources/css/orderKinds/cartMain.css">

</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div id="cartMainWrap" class="container">
		
		
		

		
		
		
		
		
		
		
		
		
		
		
		

		
		<br/>
		<br/>
			
		<div id="cartContentBar" class="row">
			<div class="cart-box-area">
				<!-- 프레임 맞추기 공백 -->
			</div>
			<div class="col-4 ps-5">상품(옵션)</div>
			
			<div class="col">수량</div>
			<div class="col-2">가격</div>
			<div class="col-2">배송</div>
			<div class="col-2">상품 합계</div>
		</div>


		<c:choose>
			<c:when test="${not empty cartList }">
				<c:set var="cartPrevAmount" value="0" />
				<c:forEach var="cMain" items="${cartList}">
					<c:set var="cartPrevAmount" value="${cartPrevAmount + cMain.totalPrice}" />
					<div class="row cart-content-block">
						<div class="bi bi-x-square cart-box-area">
							<i class="bi bi-x-square"></i>
							 <!-- 상품 옵션 번호 -->
							<input value=${cMain.productOption.pdtOptionNo } class="bi bi-x-square" type="hidden">
						</div>
						<div id="cartItemName_1" class="col-4 ps-5">${cMain.pdtName}&nbsp;${cart.productOption.pdtOptionFirst}</div>
						<div class="col">
							<!-- 상품수량 -->
							<input id="cartQuantity_1" value="${cMain.cart.cartQuantity }" type="number" min="1" class="cartQuantity pdt-dt-input form-control" name="#" placeholder="1">
						</div>
						<div class="col-2">
							<fmt:formatNumber value="${cMain.productOption.pdtOptionPrice}" pattern="#,###" />원
						</div>
						<div class="col-2 p-0 cart-extra-info-area">
							<input type="hidden" class="last-shipping" value="${cMain.pdtShipping}">
							<c:choose>
								<c:when test="${cMain.pdtShipping eq 0}">
									무료배송
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${cMain.pdtShipping}" pattern="#,###" />원
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col-2">
							<fmt:formatNumber value="${cMain.totalPrice }" pattern="#,###" />원
						</div>
					</div>
				</c:forEach>
				<script>
					$(() => {
						let $shippingArr = $('.last-shipping');
						
						let $prevAmount = $('#cartPrevAmount');
						let lastShipping = 0;
						let lastAmount = 0;
						
						let sArr = [];
						$.each($shippingArr, (index, element) => {
							sArr.push(element.value);
						});
						
						lastShipping = Math.min(...sArr);
						
						// 인풋요소들
						$('#cartLastShipping').val(lastShipping);
						$('#cartLastAmount').val();
						console.log(typeof $prevAmount);
						
						// 상품 합계 div
						$prevAmount = (Number)($prevAmount.val());
						$('#cartAmountDiv1').html($prevAmount.toLocaleString() + '원');
						// 최종 배송비 div
						const $lastShippingDiv = $('#cartAmountDiv2');
						if(lastShipping == 0) {
							$lastShippingDiv.html('무료배송');
						} else {
							$lastShippingDiv.html(lastShipping.toLocaleString() + '원');
						}
						// 최종 합계 div
						$('#cartAmountDiv3').html('= 총 ' + ($prevAmount - lastShipping).toLocaleString() + '원');
					});
				</script>
				<br/>
				<br/>	
				<br/>	
				
				
				<div class="accordion row" id="addressAccordion">
					<div class="accordion-item">
						<h2 class="accordion-header">
							<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								배송지 선택
							</button>
						</h2>
						<div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#addressAccordion">
							<div class="accordion-body">
								<jsp:include page="../frags/addressForm.jsp" />
							</div>
						</div>
					</div>
				</div>
				
				
				<div id="cartSummary" class="row">
					<div class="col">
						<div class="row ps-5">전체금액</div>
						<div id="123" class="row">
							<input id="cartPrevAmount" value="${cartPrevAmount }" type="hidden"><!-- value .toLocaleString() 가공해서 띄움 -->
							<input id="cartLastShipping" value="" type="hidden">
							<input id="cartLastAmount" value="" type="hidden">
							<c:remove var="cartPrevAmount" />

							<div id="cartAmountDiv1" class="col summary-col">
								<!-- 상품 총 합계 뜨는곳 -->
							</div>
							<div class="col-1 summary-col"> | </div>
							<div id="cartAmountDiv2" class="col summary-col">
								<!-- 배송비 뜨는곳 -->
							</div>
						</div>
						<div id="cartAmountDiv3" class="row ps-5">
							<!-- 최종 금액 뜨는곳 -->
						</div><!-- cartTotalAmount영역에 value .toLocaleString() 가공해서 띄움 -->
					</div>
					<div class="col-4">
						<button id="cartMainOrderBtn" class="btn btn-primary">주문하기</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div>장바구니에 추가된 내역이 없습니다</div>
			</c:otherwise>
		</c:choose>
	</div>
	
		<!--
		CART_NO,
		USER_NO,
		PDT_NO,
		PDT_OPTION_NO,
		CART_QUANTITY
		-->
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
		</script>
		
		
	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>	

</body>
</html>