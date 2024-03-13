// 주소검색 API
$('#searchingAreaPopUp').on('click', () => {
	new daum.Postcode({
        oncomplete: data => {
            $('#postalCode').val(data.zonecode);
            $('#address').val(data.roadAddress + ' (' + data.buildingName + ')');
            $('#addressDetail').focus();
        }
    }).open();
    return false;
});


// input 입력(디폴트이벤트) 방지
$('#postalCode, #address').on('keydown paste', (e) => {
	console.log(e);
	e.preventDefault();
});
	

// ajax요청
$(() => {
	$('#receiverForm').submit(e => {
		e.preventDefault();
		//console.log(e);
		var $receiverForm = $('#receiverForm');
		//console.log($receiverForm);
		
		$.ajax({
			url : 'ajaxInsertReceiver.re',
			data : $receiverForm.serialize(),
			type : 'POST',
			success : result => {
				console.log('성공');
				// 성공 얼럿
				alert(result);
				// 폼 리셋 (reset은 바닐라자바 => [0]으로 추출)
				$receiverForm[0].reset();
			},
			error : result => {
				console.log('실패');
				alert(result);
			}
		});
		return false;
	});
});
