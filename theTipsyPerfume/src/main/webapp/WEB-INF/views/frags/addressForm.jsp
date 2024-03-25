<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<link rel="stylesheet" href="resources/css/frags/addressForm.css" />
	
	
	
</head>
<body>

	<div id="addressContainer">
		<!-- id속성 중복이 너무 많이 일어남 class로 해결하자 -->		
		<!--
			모달창 닫기버튼 필요시
			<button type="button" class="btn-close" data-bs-dismiss="modal" area-label="Close"></button>
		-->
	
		<div>
			<!-- 네비 탭 -->
			<ul class="nav nav-tabs nav-pills nav-justified">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#menu1">배송지 선택</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#menu2">배송지 입력</a>
				</li>
			</ul>
	

			<!-- 탭 내부 메뉴 -->
			<div class="tab-content">
				<!-- 탭 메뉴1 : 배송지선택 -->
				<div id="menu1" class="container tab-pane active">
					<c:choose>
						<c:when test="${not empty receiverList}">
							<div>
								배송지를 선택해주세요
							</div>
							<c:forEach var="receiver" items="${receiverList }" varStatus="status">
								<div class="form-check">
									<input class="receiverStatus" type="hidden" value="${receiverList.receiverStatus }">
									<c:choose>
										<c:when test="${receiver.receiverStatus eq 'P' }">
											<input value="${receiverList.receiverNo }" class="form-check-input" type="radio" id="receiver${status.index }" checked>
										</c:when>
										<c:otherwise>
											<input value="${receiverList.receiverNo }" class="form-check-input" type="radio" id="receiver${status.index }">
										</c:otherwise>
									</c:choose>
									<label class="form-check-label" for="receiver${status.index }">
										${receiver.placeAlias }
								  	</label>
									<div>
										수령인 : ${receiver.receiverName } | 전화번호 : ${receiver.phone }
									</div>
									<div>
										우편번호 : ${receiver.postalCode }
										주소 : ${receiver.address }
										상세주소 : ${receiver.addressDetail }
									</div>
								</div>
								<br>
							</c:forEach>
							<input class="orderMessage">
							<button type="button" class="btn btn-primary" id="addAddressBtn">저장하기</button>
						</c:when>
						<c:otherwise>
							<div>배송지 정보를 불러올 수 없습니다. 새로운 배송지를 입력하거나 나중에 다시 시도해주세요.</div>
							
						</c:otherwise>
					</c:choose>
				</div>
				<br><br>
				
				<!-- 탭 메뉴2 : 배송지입력 -->
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
						    <input type="checkbox" class="custom-control-input" value="Y" id="receiverStatus" name="receiverStatus">
						    <label class="custom-control-label" for="receiverStatus">이 배송지를 기본 배송지로 저장하시겠습니까?</label>
					  	</div>
						<br><br>
						<div>
							<button  type="button" class="btn btn-primary" id="addAddressBtn" style="width:100%;">저장</button>
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