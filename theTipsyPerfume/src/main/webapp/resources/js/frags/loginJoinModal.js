// 로그인/회원가입 모달
$('#pdtFirstModalLoginBtn').click(() => {
	console.log('로그인요청');
	location.href="loginForm.me";
});

$('#pdtFirstModalEnrollBtn').click(() => {
	console.log('회원가입요청');
	location.href="enrollForm.me";
});

