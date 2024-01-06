

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
    //autoplay : {
        //delay : 2500, // 2.5초마다 이미지 변경
    //    disableOnInteraction: false, // 사용자 상호 작용 후에도 자동 슬라이딩 유지
    //},
    //loop : true, //반복 재생 여부
    slidesPerView : 3, // 이전, 이후 사진 미리보기 갯수
    pagination: { // 페이징 버튼 클릭 시 이미지 이동 가능
        el: '.swiper-pagination',
        clickable: true
    }
});


// 경우의 수
// 로그인O 성인인증O => 주류상품 전체조회 원함
// 로그인O 성인인증O => 주류상품 디테일조회 원함
// 로그인O 성인인증X => 성인인증 해야함(관리자 생일변경 기능)
// 로그인X 성인인증X => 로그인 원함
// 로그인X 성인인증X => 회원가입 원함
function adultValidation(param) {
	location.href = (Number(param)) ? "alcoholPdtDetail.pr?pdtNo=" + param
								    : "alcoholPdtList.pr?sort=" + param;
};