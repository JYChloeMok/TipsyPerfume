/* 시작 (검증, 단순 디스플레이, 기타 유틸 종류)*************************************************************** */
// (디스플레이) 전체상품 체크박스 이벤트
// 전체선택 & 전체 체크해제 (처음 페이지 진입 시에는 모두 checked상태)
$('#cartCheckBoxAll').change(() => {
	cartCheckBoxObj.changeCheckBoxAll();
	cartStrUtilObj.makeAllAmountArea();
});


// (디스플레이) 개별상품 체크박스 이벤트
// 모든 개별상품 체크 시 전체 선택에 checked & 하나라도 체크 안되어있으면 전체선택 체크해제
$('.cart-check-box').change(() => {
	cartCheckBoxObj.changeCheckBoxOne();
	// 최종 금액부분 변경
	cartStrUtilObj.makeAllAmountArea();
});


// (디스플레이) 로딩 시 가격 계산해 띄워줌 (물건값 총 합계 / 배송비 / 최종 주문 금액)
$(() => {
	cartStrUtilObj.makeAllAmountArea();
});
/* 끝 (검증, 단순 디스플레이, 기타 유틸 종류)*************************************************************** */



/* 시작 (ajax 요청부)*************************************************************** */
// 카트 수량 변경(UPDATE) ajax 요청
$('.cart-quantity').on('change', e => {

	// 수량 인풋의 부모 div (요소 선택용)
	let $tempParentDiv = $(e.target).closest('.cart-content-block');
	// 카트 번호
	let $cartNo = $tempParentDiv.find('.cart-check-box').val();
	// 선택 아이템 가격
	let $itemPrice = $tempParentDiv.find('.cart-pdt-option-price').val();
	// 수량
	let $cartQuantity = $(e.target).val();

	// 해당 아이템의 카트 번호 / 수량이 정수 외 입력값이라면 오류 alert
	if(!(isInteger($cartNo)) || !(isInteger($cartQuantity)) || $cartQuantity < 1) {
		alert('올바른 값이 아닙니다! 페이지를 새로고침 해주세요.');
		return false;
	}
	
	// 그 외 올바른 정수값이라면 수량 update 요청
	$.ajax({
		url : 'cart/' + $cartNo + '/quantity',
		method : 'PUT',
		data : JSON.stringify({
			cartQuantity : $cartQuantity
		}),
		contentType : 'application/json',
		success : result => {
			console.log('카트 수량 변경 통신 완료');
			if(result === 'success') {
				// 수량 변경 후 아이템 토탈
				let amount = ($itemPrice * $cartQuantity);
				// 요소 생성용 문자열
				let str = cartStrUtilObj.getItemAmountStr(amount);
				// 요소들이 생성될 div영역
				let $itemAmountArea = $tempParentDiv.find('.item-amount-area');
				
				// 요소 생성
				$itemAmountArea.html(str);
				// 금액 영역 3파트 생성 (물건값 총 합계, 최종 배송비, 최종 주문 금액)
				cartStrUtilObj.makeAllAmountArea();
			}
			else {
				confirm('수량 변경에 실패했습니다. 페이지를 새로고침 합니다.');
				location.reload();
			}
		},
		error : result => {
			console.log('카트 수량 변경 실패');
			console.log(result);
			confirm('알 수 없는 이유로 수량 변경에 실패했습니다. 나중에 다시 시도해주세요!');
			location.reload();
		}
	})
});


// 카트 아이템 삭제(DELETE)
function deleteCart() {
	// 선택된 아이템 번호(cartNo)배열 추출
	let cartNoArr = [];
	$.each(cartItemObj.getItemArr(), (index, element) => {
		cartNoArr.push(element.value);
	})
	// 아이템 삭제
	cartItemObj.getParentArr().remove()
	
	// 선택된 아이템 번호로 삭제 요청 ajax
	$.ajax({
		url : 'cart/delete/' + cartNoArr,
		method : 'DELETE',
		data : JSON.stringify({
			cartNoArr : cartNoArr
			}),
		success : result => {
			console.log('아이템 삭제 통신 성공!');
			if(result === 'success') {
				// 아이템 div영역 삭제
				cartItemObj.getParentArr().remove();
				// 전체 선택 체크박스 해제
				cartCheckBoxObj.changeCheckBoxOne();
			}
			else {
				alert('아이템 삭제에 실패했습니다. 새로고침 후 다시 시도해주세요.');
			}
		},
		error : () => {
			alert('에러발생! 아이템 삭제에 실패했습니다. 나중에 다시 시도해주세요.');
		}
	});
};
// 카트 아이템 삭제 ajax요청
/* 끝 (ajax 요청부)**************************************************************** */



/* 시작 (주문하기 관련 cartOrderObj)*************************************************************** */
//$('[name="cartNo[]"]').each((index, element) => {} 선택된 애만 사용 불가능
// 선택된 상품 이름(span요소) 배열
//let $checkedNames = $checkedParentArr.find('.cart-pdt-name');

// 주문버튼 클릭 시 수행되는 메소드 (주문서 페이지 이동)
function makeOrder() {
	
	let c = cartItemObj;
	
	// 체크된 상품
	$itemArr = c.getItemArr();
	// 개당 가격(input요소) 배열
	$priceArr = c.getPriceArr();
	// 상품 수량(input요소) 배열
	$quantityArr = c.getQuantityArr();
	
	// 조건에 맞지 않을 시 return false
	let itemArrLength = $itemArr.length;
	if(itemArrLength == 0 // 상품 선택이 안됨
	   || itemArrLength != $priceArr.length // 상품배열.length != 가격배열.length
	   || itemArrLength != $quantityArr.length) { // 상품배열.length != 수량배열.length
		alert('올바르지 않은 입력입니다! 페이지를 새로고침 해주세요.');
		return false;
	}

	// 주문서 전송용 정보 (상품 번호 배열)
	// 상품 번호나 구매하려는 개수가 하나라도 1 미만이면 return false
	let orderQuantity = 0;
	let cartNoArr = [];
	
	$itemArr.each((index, element) => {
		orderQuantity = $quantityArr[index].value;
		if(element.value < 1 || orderQuantity < 1) {
			alert('올바르지 않은 입력입니다!');
			return false;
		}
		cartNoArr.push(element.value);
	})

	// 주문서 페이지로 이동 (쿼리스트링에 배열)
	location.href = 'orderMain.od?cartReq=' + cartNoArr;
}; // 메소드끝
/* 끝 (주문하기 관련)*************************************************************** */