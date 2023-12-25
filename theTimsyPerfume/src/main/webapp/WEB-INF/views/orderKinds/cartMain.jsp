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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- CSS파일 적는곳 -->
	<link rel="stylesheet" href="resources/css/orderKinds/cartMain.css">

</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div id="cartMainWrap" class="container">
		
		
		<div id="cartMainBar" class="row">
			<div class="cart-box-area">
				<label class="check-box-label">
					<input id="cartCheckBoxAll" type="checkbox">
				</label>
			</div>
			<div class="col ps-5">전체선택</div>
			<div class="col-2"><button class="btn btn-danger">삭제</button></div>
			<div class="col-2"><button class="btn btn-primary">주문</button></div>
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
			<div class="col-2">배송</div>
			<div class="col-2">상품 합계</div>
		</div>
		<c:choose>
			<c:when test="${not empty cartList }">
				<c:forEach var="cart" items="${cartList}">
					<div class="row cart-content-block">
						<div class="cart-box-area">
							<label class="check-box-label">
								<!-- 상품 옵션 번호 -->
								<input value=${cart.pdtOptionNo } class="cart-check-box-one" type="checkbox">
							</label>
						</div>
						<div id="cartItemName_1" class="col-4 ps-5">${cart.pdtName}&nbsp;${cart.pdtOptionFirst}</div>
						<div class="col">
							<!-- 상품수량 -->
							<input id="cartQuantity_1" value="${cart.cartQuantity }" type="number" min="1" class="cartQuantity pdt-dt-input form-control" name="#" placeholder="1">
						</div>
						<div class="col-2">${cart.pdtOptionPrice}원</div>
						<div class="col-2 p-0 cart-extra-info-area">배송비 ${cart.pdtShipping}</div>
						<div class="col-2">${cart.totalPrice }(토탈가격)</div>
					</div>
				</c:forEach>
				
				<div class="row cart-content-block">
					<div class="cart-box-area">
						<label class="check-box-label">
							<!-- 상품번호 -->
							<input value="${cartList.pdtNo }" class="cart-check-box-one" type="checkbox">
						</label>
					</div>
					<!-- 상품이름 (요청에 첫번째 것만 필요) -->
					<div id="cartItemName_0" class="col-4 ps-5">향긋향수 50ML</div>
					<div class="col">
						<!-- 상품수량 -->
						<input id="cartQuantity_0" type="number" min="1" class="cartQuantity pdt-dt-input form-control" name="#">
					</div>
					<div class="col-2">100,000원</div>
					<div class="col-2 p-0 cart-extra-info-area">배송비 3,000</div>	
					<div class="col-2">98,000원</div>
				</div>
				

			
				<br/>
				<br/>	
				<br/>	
				
				<div id="cartSummary" class="row">
					<div class="col">
						<div class="row ps-5">전체금액</div>
						<div id="123" class="row">
							<input id="cartAmountBefore" value="400000" type="hidden"><!-- value .toLocaleString() 가공해서 띄움 -->
							<div class="col summary-col">400,000</div>
							<div class="col-1 summary-col"> | </div>
							<input id="cartPdtShipping" value="0" type="hidden">
							<div class="col summary-col">무료배송</div><!-- value 0이면 무료배송 -->
						</div>
						<input id="cartTotalAmount" value="392000" type="hidden">
						<div class="row ps-5">= 392,000원</div><!-- cartTotalAmount영역에 value .toLocaleString() 가공해서 띄움 -->
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