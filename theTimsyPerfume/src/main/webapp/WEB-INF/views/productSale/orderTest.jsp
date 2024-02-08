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
	<input id="name" type="text" value="밀맥주 라이트"><br>
	
	<input id="price" type="number" value="7000"><br>
	<input id="quantity" type="number" value="3"><br>
	
	<input id="buyer_email" value="admin@admin.com"><br>
	<input id="buyer_name" value="홍길동"><br>
	<input id="buyer_tel" value="010-4242-4242"><br>
	<input id="buyer_addr" type="text" value="서울특별시 강남구 신사동"><br>
	<input id="buyer_postcode" type="text" value="01181"><br>




	<script>
		let orderMainObj = {
			makeOrderNum : function() {
				
			},
			
		};
	</script>

	<script>
		function makePayment(data) {
			var IMP = window.IMP;
			IMP.init("impXXXXXXXXX");
			
			IMP.request_pay({
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
			function (result) {
				// callback
				//rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
				if(rsp.success) {
					// 결제 성공 로직
					data.impUid = rsp.imp_uid;
					data.merchant_uid = rsp.merchant_uid;
					paymentComplete(data);
				}
				else {
					// 결제 실패 로직
				}
			});
		};
	</script>



	


	const data = {
		payMethod : $("input[type='radio']:checked").val(),
		orderNum : $("#order_num").val(),
		name : $(".order_info li").eq(0).find(".food_name").text(),
		amount : Number($("#total").val()) - Number($(".point_input").val()),
		phone : $("input[name='phone']").val(),
		request : $("textarea[name='request']").val(),
		usedPoint : $("input[name='usedPoint']").val(),
		deliveryAddress1 : $("#deliveryAddress1").val(),
	 	deliveryAddress2 : $("#deliveryAddress2").val(),
	 	deliveryAddress3 : $("#deliveryAddress3").val(),
	 	totalPrice : $("#total").val()
	}

	
	
	
</body>
</html>