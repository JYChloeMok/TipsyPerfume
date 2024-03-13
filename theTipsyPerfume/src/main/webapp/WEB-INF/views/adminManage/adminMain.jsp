<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.content{
			width: 1200px;
			height: 1500px;
			align: center;
			margin: auto;
			border: 1px solid red;
		}
		
		.box{
			height:30px;
		}
	
		.content1{
			width:300px;
			height:1500px;
			align:left;
			margin:left;
			background-color : rgb(195, 195, 195);
			float : left;
		}
		
		.content1_1{
			width:100%;
			height:50px;
		}
		
		.profile{
			width:100%;
			height:120px;
		
		}
		
		.userProfile{
			width:120px;
			height:120px;
			border-radius: 50%;
			float : left;
		}
		
		#blank-profile{
			margin-top:10px;
			margin-left:10px;
			border-radius: 50%;
		}
		
		.nickName{
			float : left;
			margin-top :50px;
			margin-left:20px;
			font-size:18px;
		}
		
		.content2{
			align:left;
			margin:left;
			float : left;
			margin-top :30px;
			margin-left:30px;
			width:850px;
			height:100%;
		}
	
		.navi1{
			margin-left:30px;
		}
	
		 #navi1 a{
            text-decoration:none;
			line-height : 35px;
			font-weight : 800;
		}
		
		#navi1 > li{
			 list-style : none;
			 font-size : 20px;
		}
		
		#navi1 > li > a{
			 list-style : none;
			 font-size : 22px;
		}
		
		 #navi1 > li > ul{
            list-style : none;
		}
	
		#pagingArea {
			width:fit-content; 	
			margin:auto;
		}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        
        #searchForm>* {
            float:left;
            margin:5px;
        }
        
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
	
	
	
	</style>
</head>
<body>

	<!-- 메뉴바 -->
		<jsp:include page="../common/header.jsp" />
		<!-- -------------------------------------- -->
		<div class="content">
		<jsp:include page="../adminManage/adminSideBar.jsp" />
        <br><br>
        
         <style>
        .content {
            background-color:rgb(247, 245, 245);

            margin:auto;
        }
        
        .innerOuter {
            
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
            align:right;
            margin-left:200px;
        }
        
        .hr-dashed {
		  border : 0px;
		  border-top: 5px dashed #663399;
		}
    </style>
        
        
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
						
					<div class="btns1" align="right">
		                <button type="submit" class="btn btn-primary">수정하기</button>
		                 </div>
		         
		        </div>
		        
		    </form>
		    <br>
		
			<br><br>
			
			  		
			
	
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
			
			</div><!-- content2끝 -->
			
		</div><!-- content 끝 div -->
		<jsp:include page="../common/footer.jsp" />
</body>
</html>