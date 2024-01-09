<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 입력</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!--<link rel="stylesheet" href="resources/css/frags/addressEnrollForm.css">-->
	
	
	
</head>
<body>

	<div id="addressContainer">
		<div>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs nav-pills nav-justified">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#menu1">배송지 선택</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#menu2">배송지 입력</a>
				</li>
			</ul>
	
	
			<!-- Tab panes -->
			<div class="tab-content">
				
				<!-- 메뉴1 배송지선택 -->
				<div id="menu1" class="container tab-pane active">
					<br>
					<div>
						배송지를 선택해주세요
					</div>
					<br>
					<div class="form-check">
						<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked>
						<label class="form-check-label" for="flexRadioDefault1">
							기본배송지
					  	</label>
						<div>
							김ㅇㅇ | 서울특별시 중구 ㅇㅇ로 1230호
						</div>
					</div>
					<br>
					<div class="form-check">
						<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
						<label class="form-check-label" for="flexRadioDefault2">
							배송지 별명
						</label>
						<div>
							김ㅇㅇ | 서울특별시 중구 ㅇㅇ로 1230호
						</div>
					</div>
					<br>
				</div>
				<br><br>
				
				<!-- 메뉴2 배송지입력 -->
				<div id="menu2" class="container tab-pane fade">
					<form id="receiverForm">
						<div class="form-group">
							<label for="placeAlias">배송지 별명</label>
							<input type="text" class="form-control" id="placeAlias" name="placeAlias" placeholder="ex) 집, 회사 등">
						</div>
						
						<div class="form-group">
							<label for="receiverName">수령인 *</label>
							<input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="이름" required>
						</div>
						
						<div class="form-group">
							<label for="phone">전화번호 *</label>
							<input type="text" class="form-control" id="phone" name="phone" placeholder="전화번호 (- 없이 숫자만 입력)" required>
						</div>
						<br>

						<label for="address">주소 *</label>
						<div id="searchingAreaPopUp">
							<div class="row form-group">
								<div class="col">
							  		<input type="text" class="form-control" id="postalCode" name="postalCode" placeholder="우편번호" required>
								</div>
								<div class="col">
							  		<button type="button" class="btn btn-info form-control">주소 검색</button>
								</div>
							</div>
							<div class="form-group">
								<input type="text" class="form-control" id="address" name="address" placeholder="도로명 주소" required>
							</div>
						</div>
							
						<div class="form-group">
							<input type="text" class="form-control" id="addressDetail" name="addressDetail" placeholder="상세주소">
						</div>
						
						<div class="custom-control custom-checkbox">
						    <input type="checkbox" class="custom-control-input" value="Y" id="primaryStatus" name="primaryStatus">
						    <label class="custom-control-label" for="primaryStatus">이 배송지를 기본 배송지로 저장하시겠습니까?</label>
					  	</div>
						<br><br>
						<div class="modal-footer">
							<button  type="submit" class="btn btn-primary" id="addAddressBtn" style="width:100%;">저장</button>
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</div>

	<!-- 다음 주소검색 API -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script src="resources/js/frags/addressForm.js"></script>




</body>
</html>