<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart Quick Add</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<!-- 장바구니 빠른추가 모달 -->
	<div class="modal fade" id="cartQuickAddModal" tabindex="-1" aria-labelledby="cartQuickAddModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="cartQuickAddModalLabel">옵션을 선택해주세요</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div><!-- 제목 생길 영역 --></div>
					<select id="cartModalSelectInput" class="form-select">
						<!-- 옵션생길영역 -->
					</select>
					<br><br>
				</div>
				<div class="modal-footer">
					<button id="cartQuickAddBtn" type="button" class="btn btn-primary">장바구니 담기</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!-- js파일들 가져오기 -->
	<script src="resources/js/frags/cartQuickAddModal.js"></script>
	
</body>
</html>