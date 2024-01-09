<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }
        
        .hr-dashed {
		  border : 0px;
		  border-top: 5px dashed #663399;
		}
			  
    </style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	
	<div class="content">
        <br><br>
        
        <div class="innerOuter">
            <h2>마이페이지</h2>
            <br>

            <form action="update.me" method="post">
                <div class="form-group">
                	<label for="memberType"> 회원 구분 : </label> &nbsp;&nbsp;
                    <input type="radio" id="User" value="U" name="memberType" checked>
                    <label for="User">개인 회원</label> &nbsp;&nbsp;
                    <input type="radio" id="Sale" value="S" name="memberType">
                    <label for="Sale">사업자 회원</label> &nbsp;&nbsp;
                	<br><br>
                
                	<label for="userEmail">아이디(이메일) : </label>
					<input type="text" class="form-control" value="${ sessionScope.loginUser.userEmail }" name="userEmail" readonly><br>
					<br>

					<label for="nickName">닉네임 : </label>
					<input type="text" class="form-control" value="${ sessionScope.loginUser.nickName  }" name="nickName" required><br>
					<br>
					
					<!--  
					<div id="file" style="font-size:1em; display:none;">
					<label for="upfile">* 첨부파일</label>
	                <input type="file" id="upfile" class="form-control-file border" name="upfile" required>
	                 <br>  
					</div>	
						
					<script>
				$(function(){
					const $file = $('#file');
					
					$('#Sale').click(() =>{
						$('#file').show();
					});
					
					$('#User').click(() =>{
						$('#file').hide();
					});
				});
					</script>	
					-->	
						
						
					<div class="btns1" align="right">
		                <button type="submit" class="btn btn-primary">수정하기</button>
		                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteForm">회원탈퇴</button>
		            </div>
		           <hr> 
		        </div>
		        
		    </form>
		    <br>
			<hr>
			<br><br>
			
			  		
			<!-- 배송지 쪽! -->	
			<!--  	
			 <form action="update1.me" method="post">
                <div id="addressBox" class="form-group">			
					<table id="contentArea" align="center" class="table">
						<tr>
							<th><label for="address">배송지</label></th>
							<td></td>
						</tr>
						<tr>
							<th><label for="phone">전화번호 : </label></th>
							<td><input type="text" class="form-control" value="${ rc.phone }"  name="phone" ></td>
						</tr>
						<tr>
							<th><label for="receiverName">받는 사람 이름 : </label><th>
							<th><input type="text" class="form-control" value="${ rc.receiverName }"  name="receiverName" ></th>
							<td></td>
						</tr>
						<tr>
							<th><input type="text" class="form-control"  value="${ rc.postalCode }" name="postalCode" ></th>
							<td><input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="form-control"></td>
						</tr>
						<tr>
							<th><input type="text" class="form-control" value="${ rc.address }" name="address" ><br></th>
							<th><input type="text" class="form-control" value="${ rc.addressDetail }" name="addressDetail" ><br></th>
						</tr>
					</table>
					<div class="btns" align="right">
                     <button type="button" class="btn btn-secondary" onclick="postFormSubmit(0);">수정하기</button>
                    <button type="button" class="btn btn-danger" onclick="postFormSubmit(1);" data-toggle="modal" >삭제하기</button>
                	</div>
                	<br><br>
				</div> 
				
           		<br><br>
           		
                
                
                <input type="button" class="btn btn-primary" value="추가하기(+)" onclick="copyDiv()">
             </form>
             <hr>
             
          
          -->	
                <!-- 배송지2.script사용. -->
                <jsp:include page="../frags/addressForm.jsp" />
	
	<script>
		$(() => {
			$('#receiverForm').submit(e => {
				e.preventDefault();
				//console.log(e);
				var $receiverForm = $('#receiverForm');
				//console.log($receiverForm);
				
				$.ajax({
					url : 'ajaxInsertReceiver.re',
					data : $receiverForm.serialize(),
					type : 'POST',
					success : result => {
						console.log('성공');
						// 성공 얼럿
						alert(result);
						// 폼 리셋 (reset은 바닐라자바 => [0]으로 추출)
						$receiverForm[0].reset();
					},
					error : result => {
						console.log('실패');
						alert(result);
					}
				});
				return false;
			});
		});
	</script>
       
        	</div>
        </div>
        <br><br>
        
    

    <!-- 회원탈퇴 버튼 클릭 시 보여질 Modal -->
    <div class="modal fade" id="deleteForm">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">회원탈퇴</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="delete.me" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div align="center">
                            탈퇴 후 복구가 불가능합니다. <br>
                            정말로 탈퇴 하시겠습니까? <br>
                        </div>
                        <br>
                            <label for="userPwd" class="mr-sm-2">Password : </label>
                            <input type="text" class="form-control mb-2 mr-sm-2" placeholder="Enter Password" id="userPwd" name="userPwd"> <br>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-danger">탈퇴하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    

   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   
   <!-- 배송지 div 복사해주는 script -->
   <script>
   	function copyDiv(){
   		//addressBox node선택
   		const addressBoxDiv = document.getElementById('addressBox');
   		
   		//노드복사
   		const newNode = addressBoxDiv.cloneNode(true);
   		
   		//복사된 Node id변경
   		newNode.id = 'copyNode';
   		
   		//복사한 노드 붙여넣기
   		addressBoxDiv.after(newNode);
   	}
   
   
   
   </script>
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
		<script>
		function execDaumPostcode(){
		    new daum.Postcode({
		        oncomplete: function(data) {
		        	 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.

		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            let addr = ''; // 주소 변수

		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }

		            $("#postalCode").val(data.zonecode);
		            $("#address").val(addr);
		            $("#address").focus();
		          }
		      }).open();
		}
		</script>

		<script>
		function postFormSubmit(num){
    		if(num == 0){
    			// 수정하기 클릭 시
    			$('#postForm').attr('action', 'updateForm.bo').submit();
    		} 
    		else if(num == 1){
    			// 삭제하기 클릭 시
    			$('#postForm').attr('action', 'delete.bo').submit();
    		}
    		
    		
    	}
		
		
		</script>




	<jsp:include page="../common/footer.jsp" />
</body>
</html>