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
				<c:set var="cartPrevAmount" value="0" />
				<c:forEach var="cMain" items="${cartList}" varStatus="status">
					<c:set var="cartPrevAmount" value="${cartPrevAmount + cMain.totalPrice}" />
					<div class="row cart-content-block">
						
						<div class="cart-box-area">
							<label class="check-box-label">
								<!-- 주문서 전송용 인풋 : 상품 옵션 번호 -->
								<input name="OrderProductVO[${status.index }].pdtOptionNo" value=${cMain.productOption.pdtOptionNo } class="cart-check-box-one" type="checkbox">
							</label>
						</div>
						<div class="col-4 ps-5">${cMain.pdtName}&nbsp;${cart.productOption.pdtOptionFirst}</div>
						<div class="col">
							<!-- 주문서 전송용 인풋 : 상품수량 -->
							<input name="OrderProductVO[${status.index }].orderQuantity" value="${cMain.cart.cartQuantity }" type="number" min="1" class="cartQuantity pdt-dt-input form-control" name="#" placeholder="1">
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
							<input value="${cMain.totalPrice}" type="hidden">
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
						<button id="cartMainOrderBtn" type="submit" class="btn btn-primary">주문하기</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div>장바구니에 추가된 내역이 없습니다</div>
			</c:otherwise>
		</c:choose>
		
		<!-- 폼태그
		<input id="orderProductList" type="hidden" name="orderProductList"> -->
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
				// itemList : 선택된 productOptionNo 배열
				let $checkedItems = $('.cart-check-box-one:checked');
				let $checkedQuantities = $checkedItems.closest('.cart-content-block').find('.cartQuantity');
				let itemList = [];
				
				// 상품 선택이 안됐거나 / 상품 개수가 0이거나 / 상품배열.length != 수량배열.length일 경우 
				if($checkedItems.length == 0 || $checkedQuantities.val() == 0 || $checkedItems.length != $checkedQuantities.length) {
					alert('올바르지 않은 입력입니다!');
					return false;
				}
				// 조건에 맞는 경우 객체배열 생성 => 로컬스토리지에 저장 => 주문서 페이지로 포워딩
				else {
					$checkedItems.each((index, element) => {
						itemList.push({
							pdtOptionNo : element.value,
							orderQuantity : $checkedQuantities[index].value
						})
					});
					sessionStorage.setItem("jsonItemList", JSON.stringify(itemList));
					alert(localStorage.getItem("jsonItemList"));
					location.href = 'orderSheet';
				}
			});// 메소드끝
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