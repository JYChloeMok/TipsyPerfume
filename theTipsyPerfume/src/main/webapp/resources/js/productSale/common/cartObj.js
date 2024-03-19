/* 시작 (Obj종류)*************************************************************** */
// 체크박스 관련 =================================================================
const cartCheckBoxObj = {
	// 전체선택 체크박스
	boxAll : $('#cartCheckBoxAll'),
	// 상품 별 체크박스
	boxOne : $('.cart-check-box'),
	// 현재 체크된 체크박스
	boxOneChecked : $('.cart-check-box:checked'),
	// 전체선택 체크박스에 따라 => 상품 체크박스들도 checked/unchecked 변환
	changeCheckBoxAll : function() {
		let $boxAll = this.boxAll;
		let $boxOne = this.boxOne;
		if($boxAll.prop('checked')) {
			$boxOne.prop('checked', true);
		}
		else {
			$boxOne.prop('checked', false);
		}
	},
	// 상품이 모두 checked된 상태면 전체체크박스도 checked
	// 상품 하나라도 unchecked면 전체 체크박스도 해제
	changeCheckBoxOne : function() {
		let $boxAll = this.boxAll;
		let $boxOne = this.boxOne;
		let $boxOneChecked = $('.cart-check-box:checked');
		// 모든 박스 개수 == 선택된 박스 개수 => 전체 선택 박스 checked로
		if($boxOne.length == $boxOneChecked.length) {
			$boxAll.prop('checked', true);
		}
		// 그 외에는 전체 선택 박스 체크 해제
		else {
			$boxAll.prop('checked', false);
		}
	}
};



// 상품 CRUD(주문, 삭제 등)에 필요한 상품 관련 정보들  =================================================================
const cartItemObj = {
	// 선택된 아이템 input배열
	getItemArr : function() {
		return $('.cart-check-box:checked');
	},
	// 선택된 상품 부모요소 div배열 (요소 선택용)
	getParentArr : function() {
		return this.getItemArr().closest('.cart-content-block');
	},
	// 선택자를 받아 부모요소에서 적절한 값(배열)을 찾는 함수 (요소 선택용)
	findWithSelector : function(selector) {
		return this.getParentArr().find(selector);
	},
	// 선택된 상품 개당 가격 input배열
	getPriceArr : function() {
		return this.findWithSelector('.cart-pdt-option-price');
	},
	// 선택된 상품 (개당가격 * 선택 수량) input배열
	getTotalPriceArr : function() {
		return this.findWithSelector('.cart-total-price');
	},
	// 선택된 상품 수량 input배열
	getQuantityArr : function() {
		return this.findWithSelector('.cart-quantity');
	},
	// 선택된 상품 배송비 input배열
	getShippingArr : function() {
		return this.findWithSelector('.pdt-shipping');
	},
	// 주문 금액 관련 정보
	billingInfo : {
	  	cartAmount : $('#cartAmount').val(), // 전체 상품 금액
		shippingAmount : $('#shippingAmount').val(), // 배송비 금액
		orderAmount : $('#orderAmount').val() // 
	},
	// 선택된 아이템 (여러개) 총 금액 합산
	getCartAmount : function() {
		// 선택 상품 당 총가격 (낱개 가격 * 개수) 배열
		let $totalPriceArr = this.getTotalPriceArr();
		let cartAmount = 0;
		
		$totalPriceArr.each((index, element) => {
			cartAmount += Number(element.value);
		})
		
		return cartAmount;
	},
	// 최종 배송비(최저 배송비) 가격
	getShippingFee : function() {
		let $shippingArr = this.getShippingArr();
		let shippingFeeArr = [];
		
		if($shippingArr.length > 0) {
			$shippingArr.each((index, element) => {
				shippingFeeArr.push(element.value);
			})
			return Math.min(...shippingFeeArr);
		}
		return 0;
	}
};


	
// 요소 생성용 문자열 & 요소 생성 =================================================================
const cartStrUtilObj = {
	// 선택 물건(여러개) 합계용 문자열
	getCartAmountStr : function() {
		let cartAmount = cartItemObj.getCartAmount();
		let str = '<input id="cartAmount" type="hidden" value="'
				+ cartAmount
				+ '">'
	  			+ cartAmount.toLocaleString()
	  			+ '원';
		return str;
	},
	// 최종 배송비용 문자열
	getShippingFeeStr : function() {
		let shippingFee = cartItemObj.getShippingFee();
		let str = '';
		
		if(shippingFee > 0) {
			str = '<input id="shippingAmount" type="hidden" value="'
					+ shippingFee
					+'">'
					+ shippingFee.toLocaleString()
					+ '원';
		}
		else {
			str = '무료배송';
		}
		return str;
	},
	// 최종 주문 금액용 문자열 (상품금액 + 배송비)
	getOrderAmountStr : function() {
		let orderAmount = (cartItemObj.getCartAmount() + cartItemObj.getShippingFee());
		let str = '<input id="orderAmount" type="hidden" value="'
				+ orderAmount +'">'
				+ '= 총 '
				+ orderAmount.toLocaleString()
				+ '원';
		return str;
	},
	// 상품(한가지) 금액용 문자열(매개변수 금액 = 상품 개당가격 * 개수)
	getItemAmountStr : function(amount) {
		let str = '<input value="'
				+ amount
				+ '" type="hidden" class="cart-total-price">'
				+ ((Number)(amount)).toLocaleString()
				+ '원';
		return str;
	},
	// 물건값 총 합계 영역 동적생성
	makeCartAmountArea : function() {
		$('#cartAmountDiv').html(this.getCartAmountStr());
	},
	// 최종 배송비 영역 동적생성
	makeShippingFeeArea : function() {
		$('#shippingAmountDiv').html(this.getShippingFeeStr());
	},
	// 최종 주문 금액 영역 동적생성
	makeOrderAmountArea : function() {
		$('#orderAmountDiv').html(this.getOrderAmountStr());
	},
	// 금액 영역 3파트 생성 (물건값 총 합계, 최종 배송비, 최종 주문 금액)
	makeAllAmountArea : function() {
		this.makeCartAmountArea();
		this.makeShippingFeeArea();
		this.makeOrderAmountArea();
	}
};
/* 끝 (Obj종류)*************************************************************** */		
