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
