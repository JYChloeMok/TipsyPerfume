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
	<button onclick="cartItemObj.getCartAmount()">ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ테스트</button>
	
	
	<!-- -------------------------------------------------------------------------------------- -->
		
		
	<script>
	/* 시작 (검증, 단순 디스플레이, 기타 유틸 종류)*************************************************************** */
		// (검증) 숫자(정수) 검증 함수
		function isInteger(value) {
			return /^\d+$/.test(value);
		};
			
		
		// (디스플레이) 전체상품 체크박스 이벤트
		// 전체선택 & 전체 체크해제 (처음 페이지 진입 시에는 모두 checked상태)
		$('#cartCheckBoxAll').change(() => {
			cartCheckBoxObj.changeCheckBoxAll();
		});
		
		
		// (디스플레이) 개별상품 체크박스 이벤트
		// 모든 개별상품 체크 시 전체 선택에 checked & 하나라도 체크 안되어있으면 전체선택 체크해제
		$('.cart-check-box').change(() => {
			cartCheckBoxObj.changeCheckBoxOne();
		});
		
		
		// (디스플레이) 로딩 시 가격 계산해 띄워줌 (물건값 총 합계 / 배송비 / 최종 주문 금액)
		$(() => {
			cartStrUtilObj.makeAllAmountArea();
		});
	/* 끝 (검증, 단순 디스플레이, 기타 유틸 종류)*************************************************************** */
	</script>
		
		
	
	<script>
	/* 시작 (Obj종류)*************************************************************** */
		// 체크박스 관련 =================================================================
		const cartCheckBoxObj = {
			// 전체선택 체크박스
			boxAll : $('#cartCheckBoxAll'),
			// 상품 별 체크박스
			boxOne : $('.cart-check-box'),
			// 현재 체크된 체크박스
			boxOneChecked : $('.cart-check-box:checked'),
			// 전체선택 체크박스에 따라 => 상품 체크박스들도 checked/unchecked 변환
			changeCheckBoxAll : function() {
				let $boxAll = this.boxAll;
				let $boxOne = this.boxOne;
				if($boxAll.prop('checked')) {
					$boxOne.prop('checked', true);
				}
				else {
					$boxOne.prop('checked', false);
				}
			},
			// 상품이 모두 checked된 상태면 전체체크박스도 checked
			// 상품 하나라도 unchecked면 전체 체크박스도 해제
			changeCheckBoxOne : function() {
				let $boxAll = this.boxAll;
				let $boxOne = this.boxOne;
				let $boxOneChecked = $('.cart-check-box:checked');
				// 모든 박스 개수 == 선택된 박스 개수 => 전체 선택 박스 checked로
				if($boxOne.length == $boxOneChecked.length) {
					$boxAll.prop('checked', true);
				}
				// 그 외에는 전체 선택 박스 체크 해제
				else {
					$boxAll.prop('checked', false);
				}
			}
		};
		
	
		// 상품 CRUD(주문, 삭제 등)에 필요한 상품 관련 정보들  =================================================================
		const cartItemObj = {
			// 선택된 아이템 input배열
			getItemArr : function() {
				return $('.cart-check-box:checked');
			},
			// 선택된 상품 부모요소 div배열 (요소 선택용)
			getParentArr : function() {
				return this.getItemArr().closest('.cart-content-block');
			},
			// 선택자를 받아 부모요소에서 적절한 값(배열)을 찾는 함수 (요소 선택용)
			findWithSelector : function(selector) {
				return this.getParentArr().find(selector);
			},
			// 선택된 상품 개당 가격 input배열
			getPriceArr : function() {
				return this.findWithSelector('.cart-pdt-option-price');
			},
			// 선택된 상품 (개당가격 * 선택 수량) input배열
			getTotalPriceArr : function() {
				return this.findWithSelector('.cart-total-price');
			},
			// 선택된 상품 수량 input배열
			getQuantityArr : function() {
				return this.findWithSelector('.cart-quantity');
			},
			// 선택된 상품 배송비 input배열
			getShippingArr : function() {
				return this.findWithSelector('.cart-quantity');
			},
			// 주문 금액 관련 정보
			billingInfo : {
			  	cartAmount : $('#cartAmount').val(), // 전체 상품 금액
				shippingAmount : $('#shippingAmount').val(), // 배송비 금액
				orderAmount : $('#orderAmount').val() // 
			},
			// 선택된 아이템 (여러개) 총 금액 합산
			getCartAmount : function() {
				// 선택 상품 당 총가격 (낱개 가격 * 개수) 배열
				let $totalPriceArr = this.getTotalPriceArr();
				let cartAmount = 0;
				
				$totalPriceArr.each((index, element) => {
					cartAmount += Number(element.value);
				})
				
				return cartAmount;
			},
			// 최종 배송비(최저 배송비) 가격
			getShippingFee : function() {
				let $shippingArr = this.getShippingArr();
				let shippingFeeArr = [];

				$shippingArr.each((index, element) => {
					shippingFeeArr.push(element.value);
				})
				
				return Math.min(...shippingFeeArr);
			}
		};
		
		
		// 요소 생성용 문자열 & 요소 생성 =================================================================
		const cartStrUtilObj = {
			// 선택 물건(여러개) 합계용 문자열
			getCartAmountStr : function() {
				let cartAmount = cartItemObj.getCartAmount();
				let str = '<input id="cartAmount" type="hidden" value="'
						+ cartAmount
						+ '">'
			  			+ cartAmount.toLocaleString()
			  			+ '원';
				return str;
			},
			// 최종 배송비용 문자열
			getShippingFeeStr : function() {
				let shippingFee = cartItemObj.getShippingFee;
				let str = '';
				
				if(shippingFee > 0) {
					str = '<input id="shippingAmount" type="hidden" value="'
							+ shippingFee
							+'">';
				}
				else {
					str = '무료배송';
				}
				return str;
			},
			// 최종 주문 금액 용문자열 (상품금액 + 배송비)
			getOrderAmountStr : function() {
				let orderAmount = (cartItemObj.getCartAmount() + cartItemObj.getShippingFee());
				let str = '<input id="orderAmount" type="hidden" value="'
						+ orderAmount +'">'
						+ '= 총 '
						+ orderAmount.toLocaleString()
						+ '원';
				return str;
			},
			// 상품(한가지)의 가격 * 수량 @@@@@@@@@@@@@@@@@@@@@@@@@@@
			getItemAmountStr : function(amount) {
				let str = '<input value="'
						+ amount
						+ '" type="hidden" class="cart-total-price">'
						+ ((Number)(amount)).toLocaleString()
						+ '원';
				return str;
			},
			// 물건값 총 합계 영역 동적생성
			makeCartAmountArea : function() {
				$('#cartAmountDiv').html(this.getCartAmountStr());
			},
			// 최종 배송비 영역 동적생성
			makeShippingFeeArea : function() {
				$('#shippingAmountDiv').html(this.getShippingFeeStr());
			},
			// 최종 주문 금액 영역 동적생성
			makeOrderAmountArea : function() {
				$('#orderAmountDiv').html(this.getOrderAmountStr());
			},
			// 금액 영역 3파트 생성 (물건값 총 합계, 최종 배송비, 최종 주문 금액)
			makeAllAmountArea : function() {
				this.makeCartAmountArea();
				this.makeShippingFeeArea();
				this.makeOrderAmountArea();
			}
		};
	/* 끝 (Obj종류)*************************************************************** */
	</script>


	<script>
	/* 시작 (ajax 요청부)*************************************************************** */
		// 카트 수량 변경(UPDATE) ajax 요청
		$('.cart-quantity').on('change', e => {
			// 수량 인풋의 부모 div (요소 선택용)
			let $tempParentDiv = $(e.target).closest('.cart-content-block');
			// 카트 번호
			let $cartNo = $tempParentDiv.find('.cart-check-box').val();
			// 선택 아이템 가격
			let $itemPrice = $tempParentDiv.find('.cart-pdt-option-price').val();
			// 수량
			let $cartQuantity = $(e.target).val();
			
			// 해당 아이템의 카트 번호 / 수량이 정수 외 입력값이라면 오류 alert
 			if(!(isInteger($cartNo)) || !(isInteger($cartQuantity))) {
				alert('올바른 값이 아닙니다! 페이지를 새로고침 해주세요.');
				return false;
			}

			// 그 외 올바른 정수값이라면 수량 update 요청
			$.ajax({
				url : 'cart/quantity/' + $cartNo,
				method : 'PUT',
				data : { cartQuantity : $cartQuantity },
				success : result => {
					console.log('카트 수량 변경 성공');
					if(result === 'success') {
						// 수량 변경 후 아이템 토탈
						let itemAmount = ($itemPrice * $cartQuantity);
						// 요소 생성용 문자열
						let str = cartMainStr.getItemAmountStr(itemAmount);
						// 요소들이 생성될 div영역
						let $itemAmountArea = $tempParentDiv.find('.item-amount-area');
						
						// 요소 생성
						$itemAmountArea.html(str);
						cartMainObj.makeAllAmountArea();
					}
					else {
						confirm('수량 변경에 실패했습니다. 페이지를 새로고침 합니다.');
						location.reload();
					}
				},
				error : result => {
					console.log('카트 수량 변경 실패');
					console.log(result);
					confirm('알 수 없는 이유로 수량 변경에 실패했습니다. 나중에 다시 시도해주세요!');
					location.reload();
				}
			})
		});
		
		function deleteCart() {
			// 선택된 아이템 번호(cartNo)배열 추출
			let cartNoArr = [];
			$.each(cartItemObj.getItemArr(), (index, element) => {
				cartNoArr.push(element.value);
			})
			console.log(cartItemObj.getParentArr())
			// 아이템 삭제
			cartItemObj.getParentArr().remove()
			
			// 선택된 아이템 번호로 삭제 요청 ajax
			$.ajax({
				url : 'cart/delete/' + cartNoArr,
				method : 'DELETE',
				success : result => {
					console.log('아이템 삭제 통신 성공!');
					if(result === 'success') {
						// 아이템 div영역 삭제
						cartItemObj.getParentArr().remove();
						// 전체 선택 체크박스 해제
						cartCheckBoxObj.changeCheckBoxOne();
					}
					else {
						alert('아이템 삭제에 실패했습니다. 새로고침 후 다시 시도해주세요.');
					}
				},
				error : () => {
					alert('에러발생! 아이템 삭제에 실패했습니다. 나중에 다시 시도해주세요.');
				}
			});
		};
		// 카트 아이템 삭제 ajax요청
	/* 끝 (ajax 요청부)**************************************************************** */
	</script>
		<script>
	/* 시작 (주문 관련 cartOrderObj)*************************************************************** */
		//$('[name="cartNo[]"]').each((index, element) => {} 선택된 애만 사용 불가능
		// 선택된 상품 이름(span요소) 배열
		//let $checkedNames = $checkedParentArr.find('.cart-pdt-name');
	
		// 주문버튼 클릭 시 수행되는 메소드
		function makeOrder() {
			
			let c = checkedItemObj;
			// 체크된 상품
			$itemArr = c.getItemArr();
			// 개당 가격(input요소) 배열
			$priceArr = c.getPriceArr();
			// 상품 수량(input요소) 배열
			$quantiryArr = c.getQuantityArr();
			// 총 상품 합산 금액, 배송비, 최종 주문 가격
			
			// 주문할 상품 정보 객체를 담을 배열
			let orderItemList = [];
			
			// 상품 선택이 안됐거나 / 상품배열.length != 수량배열.length일 경우(길이가 일치하지 않을 경우) 리턴 false
			let itemArrLength = $itemArr.length;
			if(itemArrLength == 0 // 상품 선택이 안됐거나
			   || itemArrLength != $priceArr.length // 상품배열 != 가격정보 배열
			   || itemArrLength != $checkedQuantityArr.length) {
				console.log(checkedArr.length);
				console.log($checkedAmountArr.length);
				console.log($checkedQuantityArr.length);
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
		/* 끝 (주문 관련)*************************************************************** */
	</script>	
		

	<script>
	/* 		
	// 카트 메인 총금액 계산 관련 객체, 함수
	//const cartMainObj = {
	const calcCartInfo = {
/* 			// 선택한 아이템 전체 총 금액 합산
		getCartAmount : function() {
			$itemArr = checkedItemInfo.getItemArr();
			
			// 품목별 총 금액 (낱개 가격 * 선택한 개수) 배열
			let $cartTotalInputArr = $('.cart-total-price');
			let cartTotal = 0;
			// 선택된 품목 토탈 가격 더한 후 리턴
			$.each($cartTotalInputArr, (index, element) => {
				cartTotal += (Number)(element.value);
			});
			return cartTotal;
		}, */
/* 			// 최종 배송비(최저 배송비) 가격
		getShippingFee : function() {
			let shippingInputArr = $('.pdt-shipping');
			let shippingFeeArr = [];
			$.each(shippingInputArr, (index, element) => {
				shippingFeeArr.push(element.value);
			});
			return Math.min(...shippingFeeArr);
		}, */
		// 문자열 (물건값 총 합계)
		/* getCartAmountStr : function(param) {
			let self = this;
			let cartAmount = 0;
			console.log(param)
			// 파라미터가 0 초과면 cartAmount는 파라미터, 그 외의 경우 #cartAmount input요소의 밸류
			if(param > 0) {
				cartAmount = param;
			} else {
				cartAmount = self.getCartAmount();
			}
			
			let str = '<input id="cartAmount" type="hidden" value="'
					+ cartAmount
					+ '">'
		  			+ cartAmount.toLocaleString()
		  			+ '원';
			return str;
		}, */
		// 문자열 (최종 배송비)
		/* getShippingFeeStr : function() {
			let self = this;
			let shippingFee = self.getShippingFee();
			
			let str = '';
			if(shippingFee > 0) {
				str = '<input id="shippingAmount" type="hidden" value="'
						+ shippingFee
						+'">';
			}
			else {
				str = '무료배송';
			}
			return str;
		}, */
		// 문자열 (최종 주문 금액)
/* 			getOrderAmountStr : function() {
			let self = this;
			let orderAmount = (self.getCartAmount() + self.getShippingFee());
			let str = '<input id="orderAmount" type="hidden" value="'
					+ orderAmount +'">'
					+ '= 총 '
					+ orderAmount.toLocaleString()
					+ '원';
			return str;
		}, */
		// 문자열 (한가지 상품의 가격 * 수량)
/* 			getItemAmountStr : function(amount) {
			let str = '<input value="'
					+ amount
					+ '" type="hidden" class="cart-total-price">'
					+ ((Number)(amount)).toLocaleString()
					+ '원';
			return str;
		}, */
/* 		// 물건값 총 합계 영역 동적생성
		makeCartAmountArea : function() {
			let self = this;
			const str = self.getCartAmountStr();
			$('#cartAmountDiv').html(str);
		},
		// 최종 배송비 영역 동적생성
		makeShippingFeeArea : function() {
			let self = this;
			const str = self.getShippingFeeStr();
			$('#shippingAmountDiv').html(str);
		},
		// 최종 주문 금액 영역 동적생성
		makeOrderAmountArea : function() {
			let self = this;
			const str = self.getOrderAmountStr();
			$('#orderAmountDiv').html(str);
		},
		// 금액 영역 3파트 생성 (물건값 총 합계, 최종 배송비, 최종 주문 금액)
		makeAllAmountArea : function() {
			let self = this;
			self.makeCartAmountArea();
			self.makeShippingFeeArea();
			self.makeOrderAmountArea();
		}
	}; */
	</script>	
		
		
	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>	
</body>
</html>