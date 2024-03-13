<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입!!!!!!!!!!</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
    .content{
	    align:center;
	    width:800px;
	    height:2000px;
	    margin:auto;
    }
    </style>
    
</head>

<body>

	<!-- 메뉴바 -->
	<jsp:include page="../common/header.jsp" />
	<div class="content">
	
		<div class="content1">
			<div class="content2" align="center">
			<br><br>
				<h1>회원가입</h1>
				<hr>
				<h3>일반 회원 가입</h3>
				<br><br><br>

				<h4>필수 입력 사항</h4>
				
				<form action="insert.me" method="post" id="enroll-form">
					<div class="form-group">	
				
				
				<label for="memberType"> *회원 구분 : </label> &nbsp;&nbsp;
                    <input type="radio" id="User" value="U" name="memberType" checked>
                    <label for="User">개인 회원</label> &nbsp;&nbsp;
                    <input type="radio" id="Sale" value="S" name="memberType">
                    <label for="Sale">사업자 회원</label> &nbsp;&nbsp;
                <br><br>

				
						<label for="userEmail">* 아이디(이메일) : </label>
						<input type="text" class="form-control" id="userEmail" placeholder="아이디를 입력해주세요." name="userEmail" required><br>
						<div id="checkResult" style="font-size:1em; display:none;"></div>
						
						<!--  
						<div class="button">
						<button type="submit" class="disabled btn btn-primary" disabled>인증하기</button>
						</div>
						-->
						
						<br>
						<label for="userPwd">* 비밀번호 : </label>
						<input type="text" class="form-control" id="userPwd" name="userPwd" onchange="check_pw()" placeholder="비밀번호를 입력해주세요."  required><br>
						
						<br>
						
						<label for="checkPwd">* 비밀번호 확인 : </label>
						<input type="text" class="form-control" id="checkPwd" name="checkPwd" onchange="check_pw()" placeholder="비밀번호를 다시 입력해주세요."  required><br>
						&nbsp;<span id="check"></span>
						
						<br><br>
						
						<label for="userName">* 이름 : </label>
						<input type="text" class="form-control" id="userName" placeholder="이름을 입력해주세요." name="userName" required><br>
						
						<br>

						<label for="nickName">* 닉네임 : </label>
						<input type="text" class="form-control" id="nickName" placeholder="닉네임을 입력해주세요." name="nickName" required><br>
						
						<br>

						<label for="birthDate">* 생년월일 : </label>
						<input type="date" class="form-control" id="birthDate" placeholder="생년월일을 입력해주세요." name="birthDate" required><br>
						
						<br>

						<label for="phone">* 전화번호 : </label>
						<input type="text" class="form-control" id="phone" placeholder="전화번호를 입력해주세요." name="phone" required><br>
						
						<br>

						<label for="address">* 주소</label>
						<br>
						<label for="receiverName">* 받는 사람 이름 : </label>
						<input type="text" class="form-control" id="receiverName" placeholder="받는 사람 이름을 입력해주세요." name="receiverName" required><br>
						
						<br>
						
						<br>
						
						<input type="text" class="form-control" id="postalCode" placeholder="우편번호" name="postalCode" required><br>
						<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="form-control">
						
						<br>
						<input type="text" class="form-control" id="address" placeholder="주소" name="address" required><br>
						<input type="text" class="form-control" id="addressDetail" placeholder="상세주소" name="addressDetail" required><br>
					</div>
					
						<br>
						<div class="btns" align="center">
		                    <button type="submit" class="btn btn-primary" disabled>회원가입</button>
		                    <button type="reset" class="btn btn-danger">초기화</button>
		                </div>
					
				</form> 
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	</div><!-- 제일 겉 div -->
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
		
		
		<script>
		//아이디 중복체크
		$(function(){
			
			const $emailInput = $('.form-group #userEmail');
			const $checkResult = $('#checkResult');
			const $enrollFormSubmit = $('#enroll-form :submit');
			
			$emailInput.keyup(function(){
				//console.log($emailInput.val());
				
				if($emailInput.val().length >= 15){
					
					$.ajax({
						url : 'emailCheck.me',
						data : {checkEmail : $emailInput.val()},
						success : function(result){
							
							//console.log(result.substr(14));
							
							if(result.substr(14) === 'N') {//사용불가능
								$checkResult.show().css('color', 'crimson').text('중복된 아이디가 존재합니다');
								$enrollFormSubmit.attr('disabled', true);
							}
							else { // 사용가능
								$checkResult.show().css('color', 'lightgreen').text('사용 가능한 아이디(이메일)입니다!');
								$enrollFormSubmit.removeAttr('disabled', false);
							}
						},
						error : function(){
							console.log('아이디 중복체크용 AJAX통신 실패 ~ ');
						}
					});				
				} 
				else {
					$checkResult.hide();
					$enrollFormSubmit.attr('disabled', true);
				}
			});
		});
		
		</script>
		
		
		
		<script>
		//비밀번호 체크
		function check_pw(){
			 if(document.getElementById('userPwd').value !='' && document.getElementById('checkPwd').value!=''){
				if(document.getElementById('userPwd').value == document.getElementById('checkPwd').value){
					document.getElementById('check').innerHTML = '비밀번호가 일치합니다.'
					document.getElementById('check').style.color='blue';
			}
			else{
					document.getElementById('check').innerHTML ='비밀번호가 일치하지 않습니다.';
					document.getElementById('check').style.color='red';
			}
			
		}
		}
		</script>
		
		
		
		
	<jsp:include page="../common/footer.jsp" />
</body>
</html>