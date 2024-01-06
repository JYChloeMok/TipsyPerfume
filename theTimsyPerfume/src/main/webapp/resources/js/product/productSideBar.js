// 사이드바 현재 정렬로 체크상태 되도록 함
$(() => {
	$('input[value=' + $('#sidebarSort').val() + ']').attr('checked', 'true');
});


// 사이드바 정렬기준 클릭 시 정렬에 맞춰 조회
$('.pdt-side-bar-sort').on('click', e => {
	console.log('dddd');
	
	let $pdtSidebarSort = $(e.target).val();
	let $pdtCteg = $('#sidebarPdtCteg').val();
	let $pdtCurrentPage = $('#sidebarCurrentPage').val();
	if($pdtCteg == 'A') {
		//location.href="alcoholPdtList.pr?sort=" + $pdtSidebarSort + "&currentPage=" + $pdtCurrentPage;
		location.href='alcoholPdtList.pr?sort=' + $pdtSidebarSort + '&currentPage=' + $pdtCurrentPage;

	} else {
		location.href='perfumePdtList.pr?sort=' + $pdtSidebarSort + '&currrentPage=' + $pdtCurrentPage;
	}
});