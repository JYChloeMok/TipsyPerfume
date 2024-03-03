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
	<link rel="stylesheet" href="resources/css/productSale/orderMain.css">
	
	<!-- 포트원 결제 v1 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
						<input class="cartNo" type="hidden" value=${order.cart.cartNo }>
						
						<!-- 상품 이름, 옵션 정보 -->
						<div class="col-4 ps-5">
							<input class="pdtName" type="hidden" value="${order.pdtName}">
							<span class="pdt-name">${order.pdtName}</span>
							&nbsp;
							<input id="pdtOptionFirst" type="hidden" value="${order.productOption.pdtOptionFirst}">
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

				<br/>
				<div class="row">
					<p>주문자 정보</p>
					<p>이름 : ${loginUser.userName}</p>
					<p>이메일 : ${loginUser.userEmail}</p>
					<p>전화번호 : ${loginUser.phone}</p>
					<p>주소 : ${loginUser.address}</p>
					<p>우편번호 : ${loginUser.postalCode}</p>
				</div>
				
				<div class="row order-address">
					<div class="col-9">
						<!-- 현재 선택된 배송지 띄워질 영역 -->
						<div class="row pl-3">현재 배송지</div>
						<div class="row">
							<div class="col-4">배송지 별명</div>
							<div class="col-8 or-recv-alias">집${receiver[0].placeAlias }</div>
						</div>
						<div class="row">
							<div class="col-4">수령인</div>
							<div class="col-8 or-recv-name">루잉구${receiver[0].receiverName }</div>
						</div>
						<div class="row">
							<div class="col-4">전화번호</div>
							<div class="col-8 or-recv-phone">010-1234-1423${receiver[0].phone }</div>
						</div>
						<div class="row">
							<div class="col-4">우편번호</div>
							<div class="col-8 or-recv-postal">130123${receiver[0].postalCode }</div>
						</div>
						<div class="row">
							<div class="col-4">주소</div>
							<div class="col-8 or-recv-addr">서울특별시 어디구 어짇거이 니ㅡ일 이ㅏㄹ ㅏ291-잋 ㅏ102 ㄷ${receiver[0].address }</div>
						</div>
						<div class="row">
							<div class="col-4">상세주소</div>
							<div class="col-8 or-recv-addr-detail">100호${receiver[0].addressDetail }</div>
						</div>
					</div>
					<div class="col-3">
						<!-- 배송지 입력 모달창 -->
						<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#orderAddrModal">
							배송지
							<br>
							수정
						</button>
					</div>
				</div>
				
				<br/>	
				<!-- 배송지 입력 모달 시작 -->
				<div class="modal fade" id="orderAddrModal" tabindex="-1" aria-labelledby="orderAddrModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="btn-close" data-bs-dismiss="modal" area-label="Close"></button>
							</div>
							<div class="modal-body">
								<jsp:include page="../frags/addressForm.jsp" />
							</div>
							<div>
								ㅇㅇ
							</div>
						</div>
					</div>
				</div>
				<!-- 배송지 입력 모달 끝 -->
				
				
				<!-- 체크된 상품 최종 정보  -->
				<div id="orderSummary" class="row">
					<div class="col-9">
						<div class="row ps-5">전체금액</div>
						<div class="row">
							<!-- 물건값 총 합계 (전체 상품 금액 총 합) -->
							<div id="orderMainCartAmountDiv" class="col summary-col">
								<input id="orderMainCartAmount" value="${orderMain.cartAmount }" type="hidden">
								<fmt:formatNumber value="${orderMain.cartAmount }" pattern="#,###" />원
							</div>
							<div class="col-1 summary-col">
							&nbsp;|&nbsp;
							</div>
							<!-- 배송비 금액 (상품 배송비 중 최소 배송비) 뜨는곳 @@@@@@@@@@@@@@@@@@@ -->
							<div id="orderMainShippingAmountDiv" class="col summary-col">
								<input id="orderMainShippingAmount" value="${orderMain.orderShipping }" type="hidden">
								<span>배송비&nbsp;</span>
								<fmt:formatNumber value="${orderMain.orderShipping }" pattern="#,###" />원 
							</div>
						</div>
						<!-- 최종 결제 금액 (할인, 배송비 등 전부 계산한 최종 금액) 뜨는곳 @@@@@@@@@@@@@@@@@@@ -->
						<div id="orderMainOrderAmountDiv" class="row ps-5">
							<input id="orderMainOrderAmount" value="${orderMain.orderAmount }" type="hidden">
							<span>
								<!-- '= 총 x,xxx원' 형식 -->
								&#61;&nbsp;총&nbsp;<fmt:formatNumber value="${orderMain.orderAmount }" pattern="#,###" />원
							</span>
							
						</div>
					</div>

					<div class="col-3">
						<button id="orderMainPayBtn" onclick="requestPay()" type="button" class="btn btn-primary">
							결제하기
						</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">장바구니에 추가된 내역이 없습니다</div>
			</c:otherwise>
		</c:choose>
	</div>





	

	

	
	<script>
		// 로딩 시 배송지 정보 불러옴
 		$(() => {
			$.ajax({
				url : 'receiver',
				method : 'GET',
				success : result => {
					console.log('배송지 정보 조회 성공!');
					console.log(result);
				},
				error : () => {
					console.log('배송지 정보 조회 에러발생');
				}
			});
		});
	</script>
	
	
	
	<script>
		// 통신 결과 값이 유효하지 않을 때 사용하는 함수
		function handleInvalidResult(result) {
			let str = '페이먼트 정보 불러오기 통신에 성공하였으나 result값이 유효하지 않습니다! 페이지를 새로고침합니다.';
			confirm(str) ? location.reload() : location.href = '/';
		};
		
		// 포트원 결제 요청에 필요한 parameter들
		function preparePortOneParam(result) { // 추후 PG사 추가 시 Param 추가
			let buyer = result.buyer;
			return {
				// 상점 아이디
		 		storeId : 'imp77122200',
				// PG사 (추후 조건에 따라 초기화)
				pg : 'kakaopay'
				     + '.'
				     + 'TC0ONETIME',
				// 상품이름 (xx 외 n개 / 16바이트 잘리는 것 신경 안씀)
				name : $('.pdtName').eq(0).val()
					   + ' 외 '
					   + $('.cartNo').length
					   + '개',
				// 최종 결제금액
				amount : (Number)($('#orderMainOrderAmount').val()),
				// 주문번호
				lmerchantUid : result.merchantUid,
				// 주문자(로그인 유저) 정보
				buyerName : buyer.userName,
				buyerTel : buyer.phone,
				buyerEmail : buyer.userEmail,
				buyerAddr : buyer.address
						    + ' '
						    + buyer.addressDetail,
				buyerPostCode : buyer.postalCode
			}
		};
	</script>
		
		
		
		
	<script>
	// 결제
	
	// 잠시대기
	// promise / async / await
	// 콜백지옥 -> promise / IE 호환성 문제(IE현재 ㅂㅇ)
	// pending(초기), fulfilled(비동기 동작 성공), rejected(비동기 동작 실패)
	// then() 메소드로 큐(FIFO)에 추가된 처리기들 호출 (promise의 상태와 상고나없이 처리기 호출됨)
	// Promise.prototype.then(), Promise.prototype.catch()의 반환값은 새로운 promise, 서로 연결 가능		
	
	// 문법 (then인자는 optional)
	// doSomething()
	//	.then(function (result) {수행 return result})
	//	.then(function (newResult {수행 return newResult}))
	//	.catch(failureCallback);
	
	// 반환값이 존재해야함 / 화살표함수 () => x는 () => {return x;}
	// doSomething()
	//	.then((result) => doSomethingElse(result))
	//	.then((newResult) => doThirdThing(newResult))
	//	.catch(faulureCallback);
	
	// 주의 : 체인연결 제대로 안되는 경우 체인이 끊어지거나 두개의 체인이 경쟁하는 등 문제 발생
	// 병렬로 실행되고 난리남 / 중첩에 주의 / catch로 종료 필수
	
	// 비동기작업 성공 시 resolve(), 실패 시 reject()호출
	
	
	// 결제
    function requestPay() {
		
		// Promise 객체 생성 / ajax 비동기통신으로 주문에 필요한 값 조회
		let paymentPromise = new Promise((resolve, reject) => {
			$.ajax({
				url : 'payment/prepare',
				type : 'GET',
				success : result => {
					// result는 UID번호, 로그인유저 정보(이메일, 이름, 전화번호, 주소, PO코드)
 					resolve(result);
				},
				error : () => {
					reject('error');
				}
			});
		});
		/* 코드 복잡해져서 여기서는 그냥 resolve호출하고 result넘기는 로직만 수행
		      나머지는 then, catch에서 처리
		      값이 falsy해도 통신 자체가 성공했다면 resolve()를 사용해야함 / reject()는 통신 성공 or 실패여부에 따라 사용 */
		
		
		// 통신 결과 값이 유효할 때 사용하는 함수 (포트원API에 결제요청)
		function proceedPayment(result) { // result는 결제에 필요한 정보
/* 	 		// 상점 아이디
	 		let storeId = 'imp77122200';
			// PG사
			let pg = 'kakaopay' // 추후 조건에 따라 초기화
				   + '.'
				   + 'TC0ONETIME'; // 추후 조건에 따라 초기화
			// 상품이름 (xx 외 n개)
			let name = $('.pdtName').eq(0).val()
					 + ' 외 '
					 + $('.cartNo').length
					 + '개';
			// 최종 결제금액
			let amount = (Number)($('#orderMainOrderAmount').val());
			// 주문번호
			let merchantUid = result.merchantUid;
			// 주문자(로그인 유저) 정보
			let buyer = result.buyer;
			let buyerEmail = buyer.userEmail;
			let buyerName = buyer.userName;
			let buyerTel = buyer.phone;
			let buyerAddr = buyer.address
						  + ' '
						  + buyer.addressDetail;
			let buyerPostCode = buyer.postalCode; */
			let payParam = preparePortOneParam(result);
			
			// 결제 API용 객체 초기화
			IMP = window.IMP;
			IMP.init(payParam.storeId);
			console.log(payParam)
			// 결제 API 요청 보내기
			IMP.request_pay({
				pg : payParam.pg,
				pay_method : "card",
				name : payParam.name,
				amount : payParam.amount,
				merchant_uid : payParam.merchantUid, // 서버에서
				buyer_name : payParam.buyerName, // 서버에서
				buyer_tel : payParam.buyerTel, // 서버에서
				buyer_email : payParam.buyerEmail, // 서버에서
				buyer_addr: payParam.buyerAddr, // 서버에서
				buyer_postcode: payParam.buyerPostCode, // 서버에서
			},
			function(rsp) {
				console.log('음')
				// callback
				//rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
				if(rsp.success) {
					console.log('결제성공ㅇㅇㅇ 이제 res값으로 주문정보를 넣어야함');
					console.log(rsp);
				}
				else {
					console.log('결제실패ㅐㅐㅐ');
					console.log(rsp);
				}
			});
		};
		      
		// 결제 이후 흐름 컨트롤하는 then(), catch()함수
		paymentPromise.then(result => {
		 	(!result) ? handleInvalidResult(result) : proceedPayment(result);
		 	/* return false 생략 안한 이유 : 코드 의도 이해할 수 있도록 & 명시적 프로그램 종료 보장
		 	   => 가독성을 위해 삼항연산자로 변경함 */
		})
	    .catch(result => {
	    	console.log('캐치캐치');
	    	console.log(result);
	    });
    };

	
	</script>
		
	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>	
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		// 최종배송비&주문금액  cartMain JS 재활용
		// => 불가 / id 선택자 사용해서 겹침
		// => service레이어에서 계산해서 값 가져옴 (장바구니 페이지와 달리 여기는 값update될 일 없으니까)
		// => class로 설정하거나 차라리 페이지를 전부 ajax로 가져오는게 편할듯
		// 일단 공통으로 사용하는 Obj종류나 CSS들 가능하면 class로 설정하자
		// (공통사용/나중에 확장 될 수도 있다고 생각하면 class 아이디는 의미가??? => 이렇게 쓰는게 X?? 공통:클래스/이벤트:아이디)
		// 태그가 유일해야할 일 많지 X => id 너무 남발한듯
	 -->
	 
	 
</body>
</html>