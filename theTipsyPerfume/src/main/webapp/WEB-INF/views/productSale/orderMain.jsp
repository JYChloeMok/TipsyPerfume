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
			<c:when test="${not empty orderMain">
				<div id="orderContentBar" class="row">
					<div class="col-4 ps-5">상품(옵션)</div>
					<div class="col-2">수량</div>
					<div class="col-2">가격</div>
					<div class="col-2">상품 합계</div>
					<div class="col-2">배송비</div>
				</div>
				
				<c:forEach var="order" items="${orderMain.orderList}">
					<div class="order-items row order-content-block">
						<!-- 주문서 전송용 : 카트번호 -->
						<input class="cartNo" type="hidden" value=${order.cart.cartNo }>
						<input class="pdtOptionNo" type="hidden" value="${order.productOption.pdtOptionNo }">
					
						<!-- 상품 이름, 옵션 정보 -->
						<div class="col-4 ps-5">
							<input class="pdtName" type="hidden" value="${order.pdtName}">
							<span class="pdt-name">${order.pdtName}</span>
							&nbsp;
							<input class="pdtOptionFirst" type="hidden" value="${order.productOption.pdtOptionFirst}">
							<span>${order.productOption.pdtOptionFirst}</span>
						</div>
		
						<!-- 상품 수량 -->
						<div class="col-2">
							<input class="orderQuantity form-control" value="${order.cart.cartQuantity }" type="number" min="1" readOnly>
						</div>
						
						<!-- 상품 개당 가격 -->
						<div class="col-2">
							<input class="orderPrice" name="pdtOptionPrice" value="${order.productOption.pdtOptionPrice}" type="hidden">
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
								<!-- 외부 배송지 입력용 jsp페이지
								테스트 중 temp배송지 사용
								<jsp:include page="../frags/addressForm.jsp" />
							 	-->
								<!-- *** 여기부터 temp배송지 -->
								<div class="form-check">
									<input class="receiverStatus" type="hidden" value="Y">
									<input value="1" class="form-check-input" type="radio" id="receiver1" checked>
									<label class="form-check-label" for="receiver1">
										힝잉잉배송지
								  	</label>
									<div>
										수령인 : 관리자 | 전화번호 : 010-1111-2222
									</div>
									<div>
										우편번호 : 11111
										주소 : 서울특별시 중구
										상세주소 : 1층
									</div>
								</div>
								<br>
								<input class="orderMessage">
								<!-- *** 여기까지 temp배송지 -->
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
						<button id="orderMainPayBtn" onclick="requestPayment()" type="button" class="btn btn-primary">
							결제하기
						</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">장바구니에 추가된 내역이 없습니다.</div>
			</c:otherwise>
		</c:choose>
	</div>

	<script>
		// ****** 페이지 로딩 시점에 실행되는 메소드들 ******
		$(() => {
			// 배송지 정보 조회
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
			
			// 결제금액 사전검증 등록
			// [결제관련] 0. 페이지 로딩 시 포트원 결제금액 사전 등록
			/* 현재 orderAmount(총 주문 금액)
			   = 주문 페이지 로딩 당시 DB에서 계산 최신 금액
			   = 사용자가 본인이 결제할 것이라 알고있는 금액
			   = 결제되어야할 금액
			*/
			$.ajax({
				url : 'payment/prepare',
				method : 'post', // 외부 API는 POST니까 맞춰줌 + 추후 보낼 데이터 생길 수 있어서
				success : result => {
					console.log('사전금액 검증 ajax통신 통신 성공!');
					console.log(result);
					if(result.code == 0) {
						console.log('사전 검증 등록 성공!');
					}
					else {
						console.log('사전 검증 등록 실패!');
						console.log(result.message);
					}
				},
				error : () => {
					console.log('사전금액 검증 ajax통신 실패!');
				}
			});
		});
	</script>
	
	
	
	<script>
		// ****** 결제하기 버튼 클릭 시점에 실행되는 메소드들 ******
		
		// [결제관련] 결제 & 주문 로직
	 	function requestPayment() {
			// [결제관련] 1. 결제 파라미터 조회 통신(Promise 객체 생성)
			var paymentPromise = new Promise((resolve, reject) => {
				$.ajax({
					url : 'payment/paymentParam',
					type : 'GET',
					success : result => {
						// result는 UID번호, 로그인유저 정보(이메일, 이름, 전화번호, 주소, PO코드)
	 					resolve(result);
					},
					error : () => {
						// 실패 시 error문자열 넘김
						reject('error');
					}
				});
				/* 코드 복잡해져서 여기서는 그냥 resolve호출하고 result넘기는 로직만 수행
				      나머지는 then, catch에서 처리
				      값이 falsy해도 통신 자체가 성공했다면 resolve()를 사용해야함 / reject()는 통신 성공 or 실패여부에 따라 사용
				 */
			})
	 		.then(result => {
				// [결제관련] 2. 결과 falsy값일 경우 장바구니 메인으로, 그 외 결제진행
	 			if(!result) {
	 				orderMain.sendCartMain('결제 과정에서 이상이 발생했습니다.');
	 				return false;
	 			}
	 			else {
	 				orderMain.proceedPayment(result);
	 			}
			})
			.catch(result => {
		    	console.log('캐치캐치 paymentParam캐치캐치');
		    	console.log(result);
		    });
		};
	</script>
	
	

	<script>
		/*
		** 결제요청
		requestPayment()
			=> 준비 비동기요청 실패하면 장바구니 메인화면으로 이동
			paymentPreparationFail(paymentParam)
			=> 준비 비동기요청 성공하면 포트원 결제진행
			proceedPayment(paymentParam) (prepareParam(paymentParam) ajax통신 결과로 객체만들어줌)
	        	=> 포트원 결제 성공하면
	        	insertOrder(rsp)
		            => 주문생성 성공하면
		            orderSucess(rsp)
		            => 주문생성 실패하면
		            cancelPayment(rsp)
		        => 포트원 결제 실패하면
		        paymentFailResult(rsp)
		*/
	
		/*
		if(prepare) 	   ? proceedPayment : prepareFail; // prepareParam
		if(proceedPayment) ? insertOrder    : paymentFail;
		if(insertOrder)    ? orderSuccess   : cancelPayment;
		
			paymentObj
				.prepareFail
				
				.payment.prepareParam
				.payment.fail
				.payment.proceed
				
				.order.insertOrder
				.order.orderSuccess
				.order.cancelPayment
		*/
		
		let orderMain = {
			// [결제관련] 3_A. 카트 메인페이지로 보내기 (paymentParam ajax통신 실패)
			sendCartMain : function(reasonMsg) {
				console.log('sendCartMain수행');
				let second = 5000;
				let str = reasonMsg
						+ '\n'
						+ second/1000
						+ '초 후 자동으로 장바구니 화면으로 이동됩니다.';
				// n초 후 장바구니 메인으로
				setTimeout("location.href='cartMain.ca'", second);
				// 알림창 띄움
				alert(str);
			},
			// [결제관련] 3_B. 결제 요청 (paymentParam ajax통신 성공)
			proceedPayment : function(paymentParam) {
				let self = this;
				// 3_a) 결제요청 파라미터 가공
				let portOneParam = self.prepareParam(paymentParam);
				console.log('proceedPayment수행, portOneParam은 : ');
				console.log(portOneParam);
				
				// 결제 API용 객체 초기화
				var IMP = window.IMP;
				IMP.init(portOneParam.storeId);
				
				// 포트원API 결제 요청
				IMP.request_pay({
					pg : portOneParam.pg,
					pay_method : portOneParam.payMethod,
					name : portOneParam.name,
					// 결제금액 사전등록 API로 등록된 금액과 다르면 결제 요청 안감
					amount : portOneParam.amount, // 화면의 값으로 가공
					merchant_uid : portOneParam.merchantUid, // 서버에서
					buyer_name : portOneParam.buyerName, // 서버에서
					buyer_tel : portOneParam.buyerTel, // 서버에서
					buyer_email : portOneParam.buyerEmail, // 서버에서
					buyer_addr: portOneParam.buyerAddr, // 서버에서
					buyer_postcode: portOneParam.buyerPostCode, // 서버에서
					custom_data: portOneParam.customData // 화면의 값으로 가공
				},
				function(rsp) {
					// rsp.success ? (self.createOrder(rsp) ? self.orderSuccess(rsp) : self.cancelPayment(rsp)) : self.paymentFail(rsp);
					// 포트원 결제 성공
					if(rsp.success) {
						// 3_b) 서버 주문/결제 로직 요청
						if(self.createOrder(rsp) == 'success') {
							// 3_c) 서버 로직 성공 시 주문 성공 알림
							self.orderSuccess(rsp);
						}
						else {
							// 3_d) 서버 로직 실패 시
							// 식별값에 따라 수행
						}
					}
					else {
						// 3_e) 통신 실패 시 결제 실패 알림
						self.paymentFail(rsp);
					}
				});
			},
			// 3_a) 포트원 결제요청 파라미터 가공
			prepareParam : function(paymentParam) {
				// 주문자(로그인유저)
				let buyer = paymentParam.buyer;
				// 주문 페이지 상품정보 선택(배열)
				let customData = [];
				$orderArea = $('.order-items');
				let $cartNoArr = $orderArea.find('.cartNo');
				let $pdtOptionNoArr = $orderArea.find('.pdtOptionNo');
				let $orderQuantityArr = $orderArea.find('.orderQuantity');
				// 배열들 길이가 같다면
				if($cartNoArr.length == $pdtOptionNoArr.length
				&& $pdtOptionNoArr.length == $orderQuantityArr.length ) {
					// 객체배열화
					$($cartNoArr).each(index => {
		 				customData.push(
							{
								cartNo : $($cartNoArr[index]).val(),
								pdtOptionNo : $($pdtOptionNoArr[index]).val(),
								orderQuantity : $($orderQuantityArr[index]).val()
							}
						);
					});
				}
				// 반환할 객체 준비
				const portOneParam = {
					// 상점 아이디
			 		storeId : 'imp77122200',
					pg : 'html5_inicis.INIpayTest',
					// pg : 'kakaopay.TC0ONETIME', (카카오 <-> 이니시스 변경)
					payMethod : 'card',
					// 상품이름 (xx 외 n개 / 16바이트 잘리는 것 신경 안씀)
					name : $('.pdtName').eq(0).val()
						   + ' 외 '
						   + $('.cartNo').length
						   + '개',
					// 최종 결제금액(주문 페이지에서 선택됨)
					amount : (Number)($('#orderMainOrderAmount').val()),
					// 주문번호
					merchantUid : paymentParam.merchantUid,
					// 주문자(로그인 유저) 정보
					buyerName : buyer.userName,
					buyerTel : buyer.phone,
					buyerEmail : buyer.userEmail,
					buyerAddr : buyer.address
							    + ' '
							    + buyer.addressDetail,
					buyerPostCode : buyer.postalCode,
					customData : JSON.stringify(customData),
				};
				// 결제용 파라미터 반환
				return portOneParam;
			},
			// 3_b) 서버 주문/결제 로직 (포트원 결제 성공 시)
			createOrder : function(paymentResult) {
				console.log('결제성공ㅇㅇㅇ 이제 res값으로 주문정보를 넣어야함');
				console.log(paymentResult.paid_amount);
				console.log(typeof paymentResult.paid_amount);
				// 서버에서 받을 수 있게 가공
				let orderData = {
					orderMessage : '메세지입니다^^', // $('#addressContainer .orderMessage')
					receiver : {
						receiverNo : 1, // $('#addressContainer input[id^=receiver]:checked')
					},
					payment : {
						paidAmount : paymentResult.paid_amount,
						applyNum : paymentResult.apply_num,
						impUid : paymentResult.imp_uid,
						merchantUid : paymentResult.merchant_uid,
						pgTid : paymentResult.pg_tid,
						pgProvider : paymentResult.pg_provider,
						payMethod : paymentResult.pay_method,
						paidAt : paymentResult.paid_at,
						payStatus : paymentResult.status,
						customData : JSON.stringify(customData)
						// 퍼블릭 프로젝트 카드 정보 저장x 개인정보
					}
				};
				console.log('paymentData');
				console.log(paymentData);
				
				$.ajax({
					url : 'order',
					method : 'POST',
					data : JSON.stringify(orderData),
					contentType : 'application/json',
					success : result => {
						console.log('주문서 생성 성공!!!!!!!!');
						console.log(result);
						
						let str = '';
						if(result.payStatus == 'errorRefund') {
							str = '오류로 인해 결제를 취소하는 도중 문제가 발생했습니다.\n'
								  + '주문번호 : ' + result.merchantUid + '\n'
								  + '주문번호와 함께 최대한 빠른 시일 내에 관리자에게 문의해주세요.';
						if(result == 'success') {
							str = '주문에 성공했습니다!';
						} else if(result.result == 'itemShortage') {
							// 재고 부족
							str = '재고가 부족하거나 판매가 중단된 상품이 있습니다.\n'
								+ '장바구니 메인 화면으로 이동해 수량을 조정해주세요.';
							console.log(result.payStatus);
						} else if(result.result == 'wrongAmount') {
							// 금액 검증 실패
							str = '금액 정보가 일치하지 않습니다.\n'
								+ '새로고침 후에도 문제가 발생한다면 관리자에게 문의해주세요.';
							console.log(result.payStatus);
						} else {
							console.log('order 주문서 생성 로직 통신은 성공했으나 이상 발생');
						}
						// 주문 / 결제 결과 알림창 (orderResult.jsp보내기)
						alert(str);
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
						return result.result;
					},
					error : () => {
						console.log('주문서 생성 실패bbbbb');
					}
				});
			},
			// 3_c) 주문 성공 알림 (주문 생성 성공 시)
			orderSuccess : function(paymentResult) {
				console.log('주문성공알림');
			},
			// 3_d) 결제 취소 요청 (서버 로직 실패 시 / 디버깅용 취소내역 저장위해 오류 사유 저장)
			cancelPayment : function(paymentResult) {
				console.log('결제취소알림');
			}
			// 3_e) 결제 실패 알림 (결제 실패 시)
			paymentFail : function(paymentResult) {
				console.log('결제실패ㅐㅐㅐ');
				console.log(paymentResult);
			},
		}
    </script>
		


	<br/><br/><br/>
	<br/><br/><br/>	
	<br/><br/><br/>
	<script>
		// 결제 잠시대기
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
	</script>
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