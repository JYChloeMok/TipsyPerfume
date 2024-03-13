<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	<style>
	div{
		box-sizing : border-box;
	}
	.buy-title{
		text-align : center;
		margin-top : 80px;
		margin-bottom : 100px;
		font-weight : bolder;
	}
	.wrapper{
		width : 1200px;
		height : 1000px;
		margin-left : 350px;
	}
	.wrapper>div{
		height : 100%;
		float : left;
		
	}
	.product-img{
		width : 40%;
		
	}
	.product-info{
		width : 60%;
		
		
	}
	.product-img img{
		width : 100%;
		height : 50%;
	}
	.buy-info {
		
		margin-bottom : 20px;
		margin-left : 20px;
	}
	.order-info{
		width : 100px;
		border : none;
		margin-left : 20px;
		margin-bottom : 50px;
		margin-top : 50px;
	}
	.form-control{
		width : 400px;
		margin-bottom : 10px;
		
	}
	#receiver{
		margin-bottom : 50px;
	}
	
	}
	#funding-drink:hover{
		color : black;
	}
	.modal-form:hover{
		cursor : pointer;
		
	}
	.modal-form{
		text-decoration : none;
		font-size : 25px;
		margin-left : 200px;
		
	}
	
	
	
	
	
	
	
</style>
	
	
	
	

<meta charset="UTF-8">
<title>구매 페이지</title>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<h2 class="buy-title">${pdtName} 펀딩 창</h2>
	<div class="wrapper">
			<div class="product-img">
				<img alt="사진" src="${pdtFileUpload }">
						
			</div>
			
			<div class="product-info">
			<form method="post" action="funding.fd">
			<input type="hidden" name="pdtNo" value="${pdtNo }"/>
			<input type="hidden" name="userNo" value="${loginUser.userNo }"/>
				가격 : <input class="order-info" type="text" name="pdtOptionPrice" value="${pdtOptionPrice}  " readonly>
				
				개수 : <select name="orderQuantity" id="order" required>
					<option value="1" selected>1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
				<hr>
				<h5 class="buy-info">총 가격 : 0원</h5>
				<hr>
				후원하실 금액(숫자로만 입력해주세용) : <input type="text" name="fundingFee" value="0"/>
				<br>
				배송 안내 : <input class="order-info" type="text" name="pdtShipping" value="${pdtShipping}" readonly> <br>
				
				주소 선택 : <select id="selectAddress" name="selectAddress">
					<option selected id="oldAddress" value="1">회원 가입 시 입력했던 주소</option>
					<option value="2" id="newAddress">새로운 주소</option>
					
					
				</select>
				<input type="text" class="form-control" id="postalCode" placeholder="우편번호" name="postalCode" required><br>
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="form-control">

						
				<br>
				<input type="text" class="form-control" id="address" placeholder="주소" name="address" required><br>
				<input type="text" class="form-control" id="addressDetail" placeholder="상세주소" name="addressDetail" required><br>
				받는사람 : <input type="text" class="form-control" id="receiver" name="receiverName" required>
				휴대전화번호 : <input type="text" class="form-control" id="phone" name="phone"   required><br>
				배송 요청 사항 : <input type="text" class="form-control" id="order-message" name="orderMessage">
				
				
				<a class="modal-form" data-toggle="modal" data-target="#purchaseModal">펀딩하기</a>
				
				<div class="modal fade" id="purchaseModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">결제하기</h4>
                    
                </div>
        
                
                    <!-- Modal body -->
                    <div class="modal-body">
                        <h5>무통장 입금시 계좌번호 </h5>
                        <h6>국민 은행 : xxxxxxx-xxx-xxxxx</h6>
                        <h6>신한 은행 : xxxxxxx-xx-xxxx</h6>
                        <h6>우리 은행 : xxxxxxxx-xx-xxxxxx</h6>
                        <input type="radio" id="payMethod1" name="payMethod" value="B"><label for="payMethod1">무통장입금</label>
                        <input type="radio" id="payMethod2" name="payMethod" value="C"><label for="payMethod2">신용카드</label>
                        <input type="radio" id="payMethod3" name="payMethod" value="D"><label for="payMethod3">체크카드</label> <br>
                        <select id="bank" name="payBank">
                        	<option value="국민 은행" selected>국민 은행</option>
                        	<option value="신한 은행" selected>신한 은행</option>
                        	<option value="우리 은행" selected>우리 은행</option>
                        	<option value="ibk 은행" selected>ibk 은행 </option>
                        </select>
                        <br>
                        <input type="text"  class="form-control mb-2 mr-sm-2" placeholder="입금자명" id="payName" name="payName">
                        
                        <button type="submit" class="btn btn-primary">결제하기</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소하기</button>
                        
                        
                        
                    </div>
                   </div>
                  </div>
                 </div>
				
				
				
				</form>
			</div>
			
	</div>
	<script>
		
		$(function(){
			$('#order').change(() => {
				const a = $('#order option:selected').val();
				const total = '총가격 : '+ a*${pdtOptionPrice} + '원';
				console.log(total);
				$('.buy-info').html(total);
			})
		})
		$(function(){
			$('#selectAddress').change(() => {
				
				if ($('#selectAddress option:selected').val() === '1'){
					$('#postalCode').val(String(${loginUser.postalCode}).padStart(5,'0'));
					$('#address').val('${loginUser.address}');
					$('#addressDetail').val('${loginUser.addressDetail}');
					$('#receiver').val('${loginUser.userName}');
				} else{
					$('#postalCode').val('');
					$('#address').val('');
					$('#addressDetail').val('');
					$('#receiver').val('');
				}
				
				
			})
		})
		
		
	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		function execDaumPostcode(){
		    new daum.Postcode({
		        oncomplete: function(data) {
		        	 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.

		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            let addr = ''; // 주소 변수

		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }


		            $("#postalCode").val(data.zonecode);
		            $("#address").val(addr);
		            $("#address").focus();
		          }
		      }).open();

		}
		</script>
	
	
	
		
	<jsp:include page="../common/footer.jsp"/>

</body>
</html>