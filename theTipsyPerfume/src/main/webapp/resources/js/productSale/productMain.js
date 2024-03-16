// date타입 날짜 비활성화
$(() => {
	var $pdtModalDateInput = $('#birthDate');
	$pdtModalDateInput.prop('min', '1900-01-01').prop('max', new Date().toISOString().split('T')[0]);
	//$pdtModalDateInput.prop('min', new Date().toISOString().split('T')[0]); 오늘 이전 비활성화 시
});


// 버튼 리셋 혹은 서브밋
$('#pdtMainResetBtn').click(() => {
	return confirm('리셋하시겠습니까?');
});
$('#pdtMainSubmitBtn').click(() => {
	return confirm('입력하신 정보로 회원가입을 할까요?');
});


// 슬라이더 동작 정의
const swiper = new Swiper('.swiper', {
	// 슬라이딩 멈추고싶을 때 여기서부터 주석처리
    autoplay : {
        delay : 2500, // 2.5초마다 이미지 변경
    	disableOnInteraction: false, // 사용자 상호 작용 후에도 자동 슬라이딩 유지
    },
    loop : true, //반복 재생 여부
    // 슬라이딩 멈추고싶을 때 여기까지 주석처리
    slidesPerView : 3, // 이전, 이후 사진 미리보기 갯수
    pagination: { // 페이징 버튼 클릭 시 이미지 이동 가능
        el: '.swiper-pagination',
        clickable: true
    }
});


// 주류상품 메인에서 요청될 수 있는 경우의 수
// 로그인O 성인인증O => 주류상품 전체조회 or 디테일조회 원함
// 로그인O 성인인증X => 성인인증 해야함(관리자가 생일변경 기능)
// 로그인X 성인인증X => 로그인 or 회원가입 필요

// 주류 상품 썸네일 클릭 시 : 특정 상품 디테일 조회, 상품 번호(숫자 변환 가능)가 param에 담김 
// 더보기버튼 클릭 시         : 해당 기준(최신순 등)으로 상품 리스트 조회, 정렬기준 식별자(문자열)가 param에 담김
function adultValidation(param) {
	location.href = (Number(param)) ? "alcoholDetail.pr?pdtNo=" + param
								    : "alcoholList.pr?sort=" + param;
};
// 요청 : alcoholDetail와 alcoholList 메소드로 전달됨
// 위치 : src\main\java\com\kh\ttp\productSale\product\controller\ProductViewController