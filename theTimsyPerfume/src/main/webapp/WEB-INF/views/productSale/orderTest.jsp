<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	
	<button onclick="orderPayment()">주문하기</button>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	
	<script>
		$(() => {
			console.log(sessionStorage.getItem('jsonItemList'));
			let itemList = JSON.parse(sessionStorage.getItem('jsonItemList'));
			console.log(itemList);
		})
	</script>
	
	<div id="test1"></div>
	

	<!--
	<script>
		function orderPayment() {
			preparePayment();
			preCheckAmount();
		};
		
	
		var orderProduct = [
			{pdtOptionNo : 2, orderQuantity : 15},
			{pdtOptionNo : 12, orderQuantity : 20}
		];

		// 결제 전 금액 등록 (사용자 화면에서 들어온 금액 == DB의 금액과 일치할 경우에만 결제 프로세스 진행)
		function preparePayment() {
			$.ajax({
				url : 'preparePayment',
				method : 'post', // get with body x / JSON형태로 주고받기 위해 post
				data : JSON.stringify(orderProduct),
				contentType : 'application/json; charset=UTF-8',
				success : result => {
					// merchantUid & amount 사전등록
					$.ajax({
						url: "https://api.iamport.kr/payments/prepare",
						method: "post",
						headers: { "Content-Type": "application/json" }, 
						data: {
							merchant_uid: result.merchantUid, // 가맹점 주문번호
							amount: result.amount // 결제 예정금액
						},
						success : result => {
							console.log('preAmountCheck 성공');
						},
						error : () => {
							console.log('preAmountCheck 에러발생');
						}
					})
				},
				error : () => {
					console.log('1. prepare과정 에러')	
				}
			});
		};
		
		
	</script>
	
	
	
	
	<script>
		// 결제 완료 후 로직
		function orderProduct {
			$.ajax({
				url: "{서버의 결제 정보를 받는 가맹점 endpoint}", 
		        method: "POST",
		        headers: { "Content-Type": "application/json" },
		        data: {
		            imp_uid: rsp.imp_uid,            // 결제 고유번호
		            merchant_uid: rsp.merchant_uid   // 주문번호
	        	},
	        	success : result => {
	        		console.log('주문서 발행 성공');
	        		console.log(result);
	        	},
	        	error : () => {
	        		console.log('주문서 발행 실패');
	        	}
			})
		};
	</script>
	
	<script>
		
		var orderData = [
							{pdtOptionNo : 2, orderQuantity : 15},
							{pdtOptionNo : 12, orderQuantity : 20}
						];
		var IMP = window.IMP;
      	IMP.init("impXXXXXXXXX");
	 
		function requestPay() {
			IMP.request_pay(
			    {
					pg: "kcp.{상점ID}",
					pay_method: "card",
					merchant_uid: "57008833-33004",
					name: "당근 10kg",
					amount: 1004,
					buyer_email: "Iamport@chai.finance",
					buyer_name: "포트원 기술지원팀",
					buyer_tel: "010-1234-5678",
					buyer_addr: "서울특별시 강남구 삼성동",
					buyer_postcode: "123-456",
			    },
			    rsp => {
			    	// callback
			    	//rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
			    	if (rsp.success) {
			    		// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우	
			    		// jQuery로 HTTP 요청
			    		orderProduct();
			    	}
			    }
			);
		};
	</script>
	-->

	
	
	
</body>
</html>