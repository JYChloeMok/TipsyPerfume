// 상품번호 0이하일 때(서버에서 ERROR반환됨) alert창
function needPdtNoAlert() {
	alert('올바른 상품 번호가 필요합니다!');
};


// ajax요청으로 상품 옵션 조회 후 Select-Option요소 만들어주는 메소드
$(() => {
	$.ajax({
		url : 'product/option/' + $('#pdtNoDetail').val(),
		type : 'GET',
		success : result => {
			console.log('옵션 통신성공');
			console.log(result);
			if(result === 'ERROR') {
				needPdtNoAlert();
			} else { // 옵션 영역 만들어줌
				let pdtNoStr = '<option value="" selected disabled>옵션선택</option>';
				let optionInfoStr = '';
				for(let i in result) {
					pdtNoStr += '<option value="' + result[i].pdtOptionNo + '">'
							  + result[i].pdtOptionFirst + '</option>';
					optionInfoStr += '<input type="hidden" placeholder="pdtOptionStock pdtOptionPrice" '
					               + 'class="' + result[i].pdtOptionStock
					               + ' '
					               + result[i].pdtOptionPrice +'">';
				}
				$('#pdtDetailSelectInput').html(pdtNoStr);
				$('#pdtDetailOptionInfo').html(optionInfoStr);
				
			}
		},
		error : () => {
			console.log('옵션조회 에러발생');
		}
	});
});


// 장바구니 추가
$('#detailAddCartBtn').on('click', () => {
	let $pdtNo = $('#pdtNoDetail').val();
	let $pdtOptionNo = $('#pdtDetailSelectInput option:selected').val();
	let $cartQuantity = $('#pdtDetailQuanInput').val();
	
	if(Number($pdtNo * $pdtOptionNo * $cartQuantity) > 0) { // 딱 내가 원하는 경우만(빈문자열이고 다른 형태고 뭐고 아니고 넘버인데 0보다 큰 경우만)
		console.log('장바구니 추가하기 가능');
		$.ajax({
			method : 'POST',
			url : 'ajaxCheckStockAddCart.ca',
			data : {
				pdtNo : $pdtNo,
				pdtOptionNo : $pdtOptionNo,
				pdtCteg : $('#pdtCtegDetail').val(),
				cartQuantity : $cartQuantity
			},
			success : result => {
				console.log('성공! 장바구니로 이동하시겠습니까?')
			},
			error : () => {
				console.log('통신실패');
			}
		});
	}
	else {
		console.log('옵션과 수량을 정확하게 선택해주세요!');
		alert('옵션과 수량을 정확하게 선택해주세요!');
	}
	
});