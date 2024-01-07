let $pdtListImgArea = $('.pdt-list-pdtImgSrc');

// 마우스enter 시 하트와 장바구니 아이콘 보이게
$pdtListImgArea.on('mouseenter', e => {
    $(e.target).parent().find('.pdt-list-icon-area').addClass('pdt-list-max-opacity');
});

// 마우스leave 시 하트와 장바구니 아이콘 안보이게
$pdtListImgArea.on('mouseleave', e => {
	$(e.target).parent().find('.pdt-list-icon-area').removeClass('pdt-list-max-opacity');
});
/* @@@처음에 event.stopPropagation();나 pointer-events: none;같은걸 활용했다면 더 좋았을까? */


// 장바구니 빠른추가 모달창 생성 후 띄우기
function ajaxAddCartOne(e) {
	if('${loginUser}' != '') {
		let $pdtNo = $(e).siblings('input[type=hidden]').val();
		let $pdtName = $(e).siblings('.pdt-name').text();
		ajaxCreateCartQuickAddModal($pdtNo, $pdtName);
		//console.log('스코프 밖 / pdtNo : ' + $pdtNo + ' / pdtName : ' + $pdtName);
	};
};
	    
	    
// 장바구니 빠른 추가 (모달창의 장바구니 담기 버튼 클릭 시 선택된 옵션의 상품 1개 추가)
$('#cartQuickAddBtn').click(() => {
	let $pdtNo = $('#cartSelectedPdtNo').attr('class');
	let $pdtOptionNo = $('#cartModalSelectInput').attr('option', 'selected').val();
	$.ajax({
		method : 'POST',
		url : 'ajaxCheckStockAddCart.ca',
		data : {
				pdtNo : $pdtNo,
				pdtOptionNo : $pdtOptionNo,
				pdtCteg : $('#pdtListCteg').val(),
				cartQuantity : 1
		},
		success : result => {
			hideCartQuickAddModal();
			if(result === '1') {
				// 쇼핑 계속하기버튼 or 장바구니 가기버튼 팝업
				if(pdtListConfirmRemaining()) {
					location.href = "cartMain.ca";
				}
			}
			else if(result === '-1') {
				alert('재고가 없는 상품입니다!');
			}
			else {
				alert('잠시 후 다시 시도해주세요!');
			}
		},
		error : () => {
			alert('요청 실패');
		}
	});
});

	
// 상품 추가 후 장바구니로 이동할지 여부 체크
function pdtListConfirmRemaining(){
	return confirm('상품 1개가 장바구니에 추가되었습니다! 장바구니로 이동하시겠습니까?');
};
	    
	    
// 하트 추가or삭제!(온클릭 시 호출 / 기존 위시리스트에 있는지 체크 후 변경함)
function ajaxChangeWishOne(e) {
	if('${loginUser}' != '') {
		$.ajax({
			url : 'ajaxChangeWishOne.pa',
			method : 'POST',
			data : { pdtNo : $(e).siblings('input[type=hidden]').val() },
			success : result => {
				if(result === 'true') {
					$(e).removeClass('bi-suit-heart').addClass('bi-suit-heart-fill');
				}
				else if(result === 'false') {
					$(e).removeClass('bi-suit-heart-fill').addClass('bi-suit-heart');
				}
				else {
					alert('잠시 후 다시 시도해주세요');
				}
			},
			error : () => {
				alert('요청 실패');
			}
		});
	}
};


// 디테일 조회 요청
$('.pdt-detail, .pdt-detail-img').on('click', e => {
	let $pdtHiddenInput = $(e.target).closest('.pdt-list-container-col').find('input[type=hidden]');
	let $pdtNo = $pdtHiddenInput.val();
	let $pdtCteg = $pdtHiddenInput.attr('class');
	if($pdtCteg === 'A') {
		location.href='alcoholDetail.pr?pdtNo=' + $pdtNo;
	}
	else if($pdtCteg === 'F') {
		location.href='perfumeDetail.pr?pdtNo=' + $pdtNo;
	}
	else {
		alert('잘못된 요청입니다!')
	}
});