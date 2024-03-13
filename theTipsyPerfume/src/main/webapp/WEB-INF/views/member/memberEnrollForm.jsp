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
    
    </style>

</head>

<body>

	<!-- 메뉴바 -->

	<jsp:include page="../common/header.jsp" />
	
	<style>
    .content{
	    align:center;
	    width:800px;
	    height:2200px;
	    margin:auto;
    }
    
    .form-control {
	    display: block;
	    width: 60%;
	    height: calc(1.5em + 0.75rem + 2px);
	    padding: 0.375rem 0.75rem;
	    font-size: 1rem;
	    font-weight: 400;
	    line-height: 1.5;
	    color: #495057;
	    background-color: #fff;
	    background-clip: padding-box;
	    border: 1px solid #ced4da;
	    border-radius: 0.25rem;
	    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
	}
    
    </style>
    
	<div class="content">
	
		<div class="content1">
			<div class="content2" >
			<br><br>
				<h1>회원가입</h1>
				<hr>
				<h3>일반 회원 가입</h3>
				<br><br><br>

				<h4>필수 입력 사항</h4>
				
				<form action="insert.me" method="post" id="enroll-form" enctype="multipart/form-data">
					<div class="form-group">	
				
				
					<label for="memberType"> *회원 구분 : </label> &nbsp;&nbsp;
	                    <input type="radio" id="User" value="U" name="memberType" checked>
	                    <label for="User">개인 회원</label> &nbsp;&nbsp;
	                    <input type="radio" id="Sale" value="S" name="memberType">
	                    <label for="Sale" >사업자 회원</label> &nbsp;&nbsp;
	                <br><br>
				
				
				<!--  
				<div id="file" style="font-size:1em; display:none;">
					<label for="upfile">* 첨부파일</label>
	                <input type="file" id="upfile" class="form-control-file border" name="upfile" required>
	                 <br>  
				</div>
				-->
				
				
				
				
				
				
						<label for="userEmail">* 아이디(이메일) : </label>
						<input type="text" class="form-control" id="userEmail" placeholder="아이디를 입력해주세요." name="userEmail" required><br>
						<div id="checkResult" style="font-size:1em; display:none;"></div>
						
						
						<div class="emailSend" >
						<button type="button" class="btn btn-primary" id="emailSendButton" disabled>인증 번호 받기</button>
						</div>
						<br>
						
						
							<label for="emailSendConfirm">* 인증 번호 입력 : </label>
							<input type="text" class="form-control" id="emailSendConfirm" placeholder="인증번호를 입력해주세요." name="emailSendConfirm" required><br>
							<div id="confirmResult" style="font-size:1em; display:none;"></div><!-- 이건 결과글띄워주는 숨김 -->
							
							<span class="target_time">
					            <span id="remaining_min">3</span> :
					            <span id="remaining_sec">00</span>
					        </span>
												
							
							
							<div class="emailSendConfirmButton" >
							<button type="button" class="btn btn-primary" id="emailSendConfirmButton" disabled>인증 완료하기</button>
							</div>
						<!--  </div>-->
						<br>
						
						
						
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
						

	
						<label for="nickName">* 닉네임 : </label>
						<input type="text" class="form-control" id="nickName" placeholder="닉네임을 입력해주세요." name="nickName" required><br>

						
						<br>

						<label for="birthDate">* 생년월일 : </label>
						<input type="date" class="form-control" id="birthDate" placeholder="생년월일을 입력해주세요." name="birthDate" required><br>
						

						<div id="checkResult" style="font-size:0.5em; display:none;"></div>
						<br>

						

						<label for="phone">* 전화번호 : </label>
						<input type="text" class="form-control" id="phone" placeholder="전화번호를 입력해주세요." name="phone" required><br>

						
						<br>

						<label for="address">* 주소</label>
						<br>
						<label for="receiverName">* 받는 사람 이름 : </label>
						<input type="text" class="form-control" id="receiverName" placeholder="받는 사람 이름을 입력해주세요." name="receiverName" required><br>
						
						<br>
						

						<div id="checkResult" style="font-size:0.5em; display:none;"></div>
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
		                    <button id="submitButton" type="button" class="btn btn-primary" disabled>회원가입</button>
		                    <button type="reset" class="btn btn-danger">초기화</button>
		                </div>
					
				</form> 
			</div>
		</div>
	</div><!-- 제일 겉 div -->
	
	
	<!-- <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> -->
	<!--  <script src="resources/js/member/memberEnrollForm.js"></script>-->
	<!-- 잠깐 뺴놓음 -->
	
	
	<!-- 회원가입 이메일 인증용 script.나중에 스크립트 파일로 빼야 함 -->
	

 	<script>
				$(function(){
					const $file = $('#file');
					
					$('#Sale').click(() =>{
						$('#file').show();
					});
					
					$('#User').click(() =>{
						$('#file').hide();
					});
				});
	</script>	
	
	
	
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		function execDaumPostcode(){
		    new daum.Postcode({
		        oncomplete: function(data) {
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
		$(function(){
			const $emailInput = $('.form-group #userEmail'); // userEmail 입력란 form-group class명
			const $checkResult = $('#checkResult'); // 이메일 사용 가능/불가 여부 표시 css id임 
			const $emailSendInput = $('#emailSendButton'); // 인증번호 받기 버튼
			let checkEmailSend = false; // flag
			
				$emailInput.keyup(function(){
					if($emailInput.val().length >= 15){
						$.ajax({
							url : 'emailCheck.me',
							data : {checkEmail : $emailInput.val()},
							success : function(result){
								if(result.substr(14) === 'N') {
									$checkResult.show().css('color', 'crimson').text('중복된 이메일이 존재합니다.');
									checkEmailSend = false; 
								}
								else { 
									$checkResult.show().css('color', 'lightgreen').text('사용 가능한 이메일입니다!');
									checkEmailSend = true;
									$emailSendInput.removeAttr('disabled');
									$emailSendInput.attr('disabled', false);
								}
							},
							error : function(){
								console.log('아이디 중복체크용 AJAX통신 실패');
							}
						});				
					} 
					else {
						$checkResult.hide();
					}
				});
			
			
			const $emailSendCheck = $('.form-group #emailSendConfirm'); // 인증번호 입력란
			const $emailSendCheckButton = $('#emailSendConfirmButton');
			let checkEmailRight = false; // flag
				//인증 번호 받기 누를 시 메일보내는 ajax
				$('#emailSendButton').click(() =>{
					if(checkEmailSend){
						$.ajax({
							url:'mail',
							method: "post",
							data : {userEmail : $emailInput.val()},
							success : function(result){
								if(result == "1") {
									$emailSendCheckButton.removeAttr('disabled');
									checkEmailRight=true;//키업할때 disabled해놓기. 
									$emailSendInput.removeAttr('disabled');
									$emailSendInput.attr('disabled', true);
								}
								else{
									alert('이메일 발송 실패');
								}
							},
							error : function(){
								console.log('통신 실패');
							}
						})
					}
				})
				
				
				
					//인증번호 받기 누르고 3분동안 체크하는 거
					const remainingMin = document.getElementById("remaining_min");
					const remainingSec = document.getElementById("remaining_sec");
					//const $emailSendCheckButton = $('#emailSendConfirmButton');이거사용중임!
					let interval;
					let time = 180;
					$('#emailSendButton').click(() => {
						clearInterval(interval);
						let time=180;
						interval=setInterval(function () {
					    if (time > 0) { // >= 0 으로하면 -1까지 출력된다.
					      time = time - 1; // 여기서 빼줘야 3분에서 3분 또 출력되지 않고, 바로 2분 59초로 넘어간다.
					      let min = Math.floor(time / 60);
					      let sec = String(time % 60).padStart(2, "0");
					      remainingMin.innerText = min;
					      remainingSec.innerText = sec;
					    } else {
					    	$emailSendCheckButton.removeAttr('disabled');
							$emailSendCheckButton.attr('disabled', true);
							//인증번호받기 다시 disabled풀어주기
							$emailSendInput.attr('disabled', false);
					    }
					  }, 1000);
					});
				
				
				
				
				
				
				const $submitButtonCheck = $('#submitButton'); // 회원가입 submit버튼
				//이메일 인증번호 맞는지 체크해주기 
				$('#emailSendConfirmButton').click(() =>{	
					if(checkEmailRight){
						$.ajax({
							url : 'check',
							method: "post",
							data : {authCode : $emailSendCheck.val()},
							success : function(result){
								console.log(result);
								if (result == "true"){
									alert('이메일 인증 완료!');
									//키업할때 disabled해놓기. 
									$emailSendCheckButton.removeAttr('disabled');
									$emailSendCheckButton.attr('disabled', true);
									$submitButtonCheck.removeAttr('disabled');
								} else {
									alert('이메일 인증 실패!');
								}
							},
							error : function(){
								console.log('통신 실패');
							}
						})
					};
				});
	
				
				//모든 필수 입력란들이 다 1글자 이상인지 확인
				const $required = $('.form-control');
				let requiredfinal = false; // flag
				
				$required.keyup(function(){
					for(i = 0; i<$required.length; i++){
						if($required.val().length >= 1 ){
						requiredfinal = true;
						}
					}
				});
				
				
				//플래그가 다 true가 되었을 경우에만 회원가입 버튼이 열리도록
				$('#submitButton').click(() =>{
					if(checkEmailSend == true && checkEmailRight == true && requiredfinal == true){
						$('#enroll-form').submit();
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