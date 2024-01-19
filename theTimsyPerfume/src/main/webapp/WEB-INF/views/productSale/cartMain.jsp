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
	
	<div id="cartMainWrap" class="container">
	
		<div id="cartMainBar" class="row">
			<div class="cart-box-area">
				<label class="check-box-label">
					<input id="cartCheckBoxAll" type="checkbox">
				</label>
			</div>
			<div class="col ps-5">전체선택</div>
			<div class="col-2"><button class="btn btn-danger">삭제</button></div>
			<div class="col-2"><button type="submit" class="btn btn-primary">주문</button></div>
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
				<c:set var="cartAmount" value="0" />
				<c:forEach var="cMain" items="${cartList}" varStatus="status">
					<c:set var="cartAmount" value="${cartAmount + cMain.totalPrice}" />
					<div class="row cart-content-block">
						<div class="cart-box-area">
							<label class="check-box-label">
								<!-- 주문서 전송용 : 카트번호 -->
								<input name="cartNo" value=${cMain.cart.cartNo } class="cart-check-box" type="checkbox">
							</label>
						</div>
						<div class="col-4 ps-5">
							<!-- 주문서 전송용 : 상품 이름 -->
							<input name="pdtName" type="hidden" value="${cMain.pdtName}">
							<span class="cart-pdt-name">${cMain.pdtName}</span>
							&nbsp;
							<!-- 주문서 전송용 : 상품 옵션 정보 -->
							<input name="pdtOptionFirst" type="hidden" value="${cMain.productOption.pdtOptionFirst}" class="cart-pdt-option-first">
							<span>${cMain.productOption.pdtOptionFirst}</span>
						</div>
		
						<div class="col">
							<!-- 주문서 전송용 : 상품 수량 -->
							<input name="cartQuantity" value="${cMain.cart.cartQuantity }" type="number" min="1" class="cart-quantity pdt-dt-input form-control" placeholder="1">
						</div>
						
						<div class="col-2">
							<!-- 주문서 전송용 : 상품 개당 가격 -->
							<input name="pdtOptionPrice" value="${cMain.productOption.pdtOptionPrice}" type="hidden" class="cart-pdt-option-price">
							<fmt:formatNumber value="${cMain.productOption.pdtOptionPrice}" pattern="#,###" />원
						</div>
						
						<div class="col-2">
							<!-- (상품 개당 가격 * 개수) -->
							<input value="${cMain.totalPrice}" type="hidden">
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

				<br/>
				<br/>	
				<br/>	
				
				
				<!-- 체크된 상품 최종 정보  -->
				<div id="cartSummary" class="row">
					<div class="col">
						<div class="row ps-5">전체금액</div>
						<div id="123" class="row">
							<div id="cartAmountDiv" class="col summary-col">
								<!-- 주문서 전송용 : 물건값 총 합계 (전체 상품 금액 총 합) -->
								<input id="cartAmount" value="${cartAmount }" type="hidden">
								<fmt:formatNumber value="${cartAmount }" pattern="#,###" />원
								<c:remove var="cartAmount" />
							</div>
							<div class="col-1 summary-col"> | </div>
							<div id="shippingAmountDiv" class="col summary-col">
								<!-- 주문서 전송용 : 배송비 금액 (상품 배송비 중 최소 배송비) 뜨는곳 -->
							</div>
						</div>
						<div id="orderAmountDiv" class="row ps-5">
							<!-- 주문서 전송용 : 주문 최종 금액 (할인, 배송비 등 전부 계산한 최종 금액) 뜨는곳 -->
						</div>
					</div>
					<div class="col-4">
						<button id="cartMainOrderBtn" onclick="makeOrder()" type="submit" class="btn btn-primary">주문하기</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div>장바구니에 추가된 내역이 없습니다</div>
			</c:otherwise>
		</c:choose>
	</div>
	<button id="testBtn">테스트입니당</button>
	
<!-- -------------------------------------------------------------------------------------- -->
		<script>
			// 숫자(정수) 검증 함수
			function isInteger(value) {
				return /^\d+$/.test(value);
			};
			
			
			// 카트 수량 변경 ajax
			$('.cart-quantity').on('change', e => {
				let $cartQuantity = $(e.target).val();
				let $cartNo = $(e.target).closest('.cart-content-block').find('.cart-check-box').val();
				// 정수 외 입력 시 오류 alert
				if(!(isInteger($cartNo)) || !(isInteger($cartQuantity))) {
					alert('올바른 값이 아닙니다! 페이지를 새로고침 해주세요.');
					return false;
				}
				// 정수 입력 시 ajax 장바구니 수량 update 요청
				$.ajax({
					url : 'cart/quantity/' + $cartNo,
					method : 'PUT',
					data : { cartQuantity : $cartQuantity },
					success : result => {
						console.log('카트 수량 변경 성공');
						console.log(result);
					},
					error : result => {
						console.log('카트 수량 변경 실패');
						console.log(result);
					}
				})
			});
			
			
			// 상품 전체 가격 등 계산하는 함수 호출
			$(() => {
				calcCartMoney();
			});
			
			/*시작****************************************************************/
			// 카트에서 사용되는 값 관련 객체
			let cartInfoObj = {
				// 물건값 총 합계
				getCartAmount : function() {
					return (Number)($('#cartAmount').val());
				},
				// 최종 배송비(최저 배송비) 가격
				getShippingFee : function() {
					let shippingInputArr = $('.pdt-shipping');
					let shippingFeeArr = [];
					$.each(shippingInputArr, (index, element) => {
						shippingFeeArr.push(element.value);
					});
					return Math.min(...shippingFeeArr);
				},
				// 동적생성용 문자열 (물건값 총 합계)
				getCartAmountStr : function() {
					let self = this;
					let cartAmount = self.getCartAmount();
					let str = '<input id="cartAmount" type="hidden" value="'
							+ cartAmount
							+ '">'
				  			+ cartAmount.toLocaleString()
				  			+ '원';
					return str;
				},
				// 물건값 총 합계 영역 동적생성
				setCartAmountArea : function() {
					
				},
				// 동적생성용 문자열 (최종 주문 금액)
				getOrderAmountStr : function() {
					let self = this;
					let orderAmount = (self.getCartAmount() + self.getShippingFee());
					let str = '<input id="orderAmount" type="hidden" value="'
							+ orderAmount +'">'
							+ '= 총 '
							+ orderAmount.toLocaleString()
							+ '원';
					return str;
				},
				// 최종 주문 금액 영역 동적생성
				setOrderAmountArea : function() {
					
				},
				// 동적생성용 문자열 (최종 배송비)
				getShippingFeeStr : function() {
					let self = this;
					let str = '<input id="shippingAmount" type="hidden" value="'
							+ self.getShippingFee()
							+'">';
					return str;
				},
				// 최종 배송비 영역 동적생성
				setShippingFeeArea : function() {
					
				}
			};
			
			// 화살표 함수가 this를 바인딩 하는 방식이 다름
			// 자신의 this를 갖지 않고 외부 스코프의 this(여기서 전역스코프)를 가르키게 됨
			// 일반함수로 정의해야 자신만의 this를 가짐
			$('#testBtn').on('click', () => {
				let quantityArr = $('.cartQuantity');
				let priceArr = $('.pdtOptionPrice');
				console.log(quantityArr);
				console.log(priceArr);
			});

	
			/*끝****************************************************************/
			
			

			// 상품 전체 가격 등 계산하는 함수 (구버전)
			// (상품 총 합계 금액 - 최소 배송비) = 결제할 최종 상품가격
			function calcCartMoney() {
				/*
				// 각 상품별 배송비 인풋요소 배열
				let $pdtShippingArr = $('.pdt-shipping');
				// 상품별 합계 금액 ((상품금액 * 수량) + 배송비)
				let $cartAmountBefore = $('#cartAmountBefore');
				// 최종 배송비
				let pdtShippingMin = 0;
				
				
				// 최소 배송비 계산용 임시 배열 sArr
				let sArr = [];
				// sArr 초기화 (배송비 인풋요소 배열의 value를 배열로 만듬)
				$.each($pdtShippingArr, (index, element) => {
					sArr.push(element.value);
				});
				// sArr의 최소값을 최종 배송비로 설정함
				pdtShippingMin = Math.min(...sArr);
				
				console.log(typeof $cartAmountBefore);
				*/
			/*	
				// 상품별 합계 금액 출력 및 히든타입 input요소 생성 (cartAmountDiv영역에 동적생성)
				$cartAmountBefore = (Number)($cartAmountBefore.val());
				let cartAmountStr = '<input id="cartAmount" type="hidden" value="'+ $cartAmountBefore +'">'
				//				  + $cartAmountBefore.toLocaleString() + '원';
				$('#cartAmountDiv').html(cartAmountStr);
				
				// 최종 배송비 출력 및 히든타입 input요소 생성 (0원일 시 '무료배송' 출력 / shippingAmountDiv영역에 동적생성)
				const $shippingAmountDiv = $('#shippingAmountDiv');
				//let shippingAmountStr = '<input id="shippingAmount" type="hidden" value="'+ pdtShippingMin +'">';
				if(pdtShippingMin == 0) {
					shippingAmountStr += '무료배송';
				} else {
					shippingAmountStr += (pdtShippingMin.toLocaleString() + '원');
				}
				$shippingAmountDiv.html(shippingAmountStr);
				
				// 주문 최종 합계 금액 출력 및 히든타입 input요소 생성  (orderAmountDiv 영역에 동적생성)
				let orderAmount = ($cartAmountBefore + pdtShippingMin);
				//let orderAmountStr = '<input id="orderAmount" type="hidden" value="'+ orderAmount +'">'
				//					+ '= 총 ' + orderAmount.toLocaleString() + '원';
				$('#orderAmountDiv').html(orderAmountStr);
			*/
			}

			
			
		</script>
		
		<script>
		</script>
		
		
		
		
		
		<script>
			//$('[name="cartNo[]"]').each((index, element) => {} 선택된 애만 사용 불가능
		
			// 주문버튼 클릭 시 수행되는 메소드
			function makeOrder() {
				// 선택된 상품번호(cartNo) 배열 // UUID??
				let $checkedArr = $('.cart-check-box:checked');
				// 선택된 상품 부모 Div 배열
				let $checkedParentArr = $checkedArr.closest('.cart-content-block');
				
				// 선택된 상품 이름 span요소 배열
				let $checkedNames = $checkedParentArr.find('.cart-pdt-name');
				// 선택된 상품 가격 인풋요소 배열
				let $checkedAmountArr = $checkedParentArr.find('.cart-pdt-option-price');
				// 선택된 옵션 내용(ML, 용량) span요소 배열
				$checkedOptionFirst = $checkedParentArr.find('.cart-pdt-option-first');
				// 선택된 상품 수량 인풋요소 배열
				let $checkedQuantityArr = $checkedParentArr.find('.cart-quantity');
				
				// 총 상품 합산 금액
				// 배송비
				// 최종 주문 가격				
				let orderAmountInfo = {
										cartAmount : $('#cartAmount').val(),
										shippingAmount : $('#shippingAmount').val(),
										orderAmount : $('#orderAmount').val()
									  };
				
				// 주문할 상품 정보 객체를 담을 배열
				let productList = [];
				// 상품 선택이 안됐거나 / 상품배열.length != 수량배열.length일 경우(길이가 일치하지 않을 경우) 리턴 false
				let checkedArrLength = $checkedArr.length;
				if(checkedArrLength == 0 ||
				   checkedArrLength != $checkedNames.length ||
				   checkedArrLength != $checkedAmountArr.length ||
				   checkedArrLength != $checkedQuantityArr.length ||
				   checkedArrLength != $checkedOptionFirst.length) {
 					console.log(checkedArrLength);
					console.log($checkedNames.length);
					console.log($checkedAmountArr.length);
					console.log($checkedQuantityArr.length);
					console.log($checkedOptionFirst.length);
					alert('올바르지 않은 입력입니다!');
					return false;
				}
				
				// 반복문 돌면서 상품 개수가 하나라도 0이면 리턴 false 그 외의 경우 객체배열 생성
				$checkedArr.each((index, element) => {
					let orderQuantity = $checkedQuantityArr[index].value;
					console.log(orderQuantity);
					console.log('dd');
					if(orderQuantity == 0) {
						alert('올바르지 않은 입력입니다!');
						return false;
					}
					productList.push({
						pdtOptionNo : element.value,
						orderQuantity : $checkedQuantityArr[index].value
					})
				})
				
				// JSON 문자열 형태 세션스토리지에 저장 => 주문서 페이지로 이동
				sessionStorage.setItem("jsonProductList", JSON.stringify(productList));
				sessionStorage.setItem("orderAmountInfo", JSON.stringify(orderAmountInfo));
				
				// 주문서 페이지로 이동
				/*
				location.href = 'orderMain';
				*/
			}; // 메소드끝
		</script>
		
		<script>
			// 모든 상품 체크 선택 시 (주문 취소하거나 페이지 재렌더링은 그냥 체크 다 해제된 상태)
			$('#cartCheckBoxAll').change(() => {
				let $cartCheckBoxAll = $('#cartCheckBoxAll');
				let $checkBoxOne = $('.cart-check-box');
				
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