<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

</head>
<body>

	
	
	
	<button onclick="requestPay()">결제하기</button>
	
    <!-- PortOne SDK -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>

	<script>
		// 카트 -> 주문서화면
		// 주문하기 버튼 클릭 시
		// 카트화면 : 선택된 카트넘버들(productNo) pathVariable로 주문서 화면에 넘김
		// 주문서 화면 띄우기
		
		// 주문서화면
		// 결제 화면 클릭 시
		
		var IMP = window.IMP;
		IMP.init('imp77122200');
		function requestPay() {
			// orderInfo받아서 결제정보 만들기
			let order = getOrderInfo();
			console.log(order);
			/*
			IMP.request_pay({
				pg : "kakaopay.TC0ONETIME",
				pay_method : "card",
				merchant_uid : "57008833-33005",
				name : "당근 10kg",
				amount : 1,
				buyer_email : "Iamport@chai.finance",
				buyer_name : "포트원 기술지원팀",
				buyer_tel : "010-1234-5678",
				buyer_addr : "서울특별시 강남구 삼성동",
				buyer_postcode : "123-456",
				kcpProducts: "장바구니 상품 묶어서 결제 시 추가파라미터 객체배열로 전달",
				// PostMapping 넘긴 후
				// server측 트랜잭션 1개 : cart 비우기
				
			}, function(rsp) {
				// callback
				//rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
				
				if (rsp.success) { // success속성
					
					
					// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					// jQuery로 HTTP 요청
					console.log('성공!');
					jQuery.ajax({
						url : "payment/verify",
						method : "POST",
						headers : {
							"Content-Type" : "application/json"
						},
						data : {
							imp_uid : rsp.imp_uid, // 결제 고유번호
							merchant_uid : rsp.merchant_uid, // 주문번호
							
						}
					}).done(function(data) {
						// 가맹점 서버 결제 API 성공시 로직
						alert('결제성공!!!');
						console.log(data);
						if(data.paid_amount == data.) {
							
						}
						
						/*
						pay_method : rsp.pay_method,
						paid_amount : rsp.paid_amount,
						status : rsp.status, // paid만 성공
						name : rsp.name,
						pg_provider : rsp.pg_provider,
						emb_pg_provider : rsp.emb_pg_provider,
						
						pg_tid : rsp.pg_tid,
						buyer_name : rsp.buyer_name,
						buyer_email : rsp.buyer_email,
						buyer_tel : rsp.buyer_tel,
						buyer_addr : rsp.buyer_addr,
						buyer_postcode : rsp.buyer_postcode,
						custom_data : rsp.custom_data,
						paid_at : rsp.paid_at,
						success : rsp.success
						*/
						
				/*		
					})
				} else {
					alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
				}

			});
			*/
		}
	</script>


</body>
</html>