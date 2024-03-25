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
	<!-- <link rel="stylesheet" href=""> -->
<style>
	#orderResultWrap .or-re-btn-none {
		display : none;
	}

</style>

</head>

<body>

	<div id="orderResultWrap">
		<input id="orderResult" type="hidden" value="${orderResult}">
		<div id="orderResultArea" class="row"></div>
	</div>
	
	<script>
		// 근데 이런 세세한 정보를 노출시킬 필요가 있을까 이건 백단 하고 정리
		$(() => {
			console.log($('#orderResult'));
			switch($('#orderResult')) {
				case 'NNSTOCK' :
					notEnoughStock();
					break;
				case 'NNROW' :
					noRowFound();
					break;
				case 'FFPREP' :
					paymentPrepFailure();
				default : sendMain();
			}
		});
		
		let orderResult = {
			makeOrderResultArea : function(msg) {
				 $('#orderResultArea').html(msg);
			},
			sendMain : function(){
				let self = this;
				msg = '알 수 없는 이유로 정보를 표시할 수 없습니다.\n'
					+ '문제가 지속될 시 관리자에게 문의해주세요.\n'
					+ '잠시 후 메인 화면으로 이동됩니다.';
				self.makeOrderResultArea(msg);
				setTimeOut(() => {location.href='/'}, 10000);
			},
			getSendBtnStr : function(url, btnMsg) {
				let self = this;
				if(url && btnMsg) {
					msg = '<div class="row">'
						+ '<button onclick="location.href=\''+ url +'\'">'
						+ btnMsg
						+ '</button>'
						+ '</div>';
				}
				else {
					msg = '버튼 생성 오류발생';
					console.log('orderResult.jsp : getBtnStr()은 2개의 파라미터가 모두 필요합니다!');
				}
				return msg;
			},
			getSendCartBtnStr : function() {
				let self = this;
				msg = this.getSendBtnStr('cartMain.ca', '장바구니로 이동');
				return msg;
			},
			notEnoughStock : function(){
				let self = this;
				msg = '상품 개수가 부족합니다.\n'
					+ '장바구니 화면에서 수량을 확인해주세요.\n'
					+ '아래의 버튼을 클릭하면 장바구니 화면으로 이동합니다.';
				msg += this.getSendBtnStr('cartMain.ca', '장바구니로 이동');
				self.makeOrderResultArea(msg);
			},
			noRowFound : function() {
				let self = this;
				msg = '조회된 결과가 없습니다.';
				self.makeOrderResultArea(msg);
			},
			paymentPrepFailure : function() {
				let self = this;
				msg = '사전 준비 과정에서 오류가 발생했습니다.\n'
					+ '장바구니에서 다시 시도해주세요.';
				msg += getSendCartBtnStr();
				self.makeOrderResultArea(msg);
			}
		}
		
	</script>
	
</body>
</html>