<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminSideBar</title>
	
		<style>
	
		.content1{
			width:300px;
			height:100%;
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

	
		
		
			<!--  <div class="box"></div>-->
			<div class="content1">
			<div class="content1_1"></div>
			
			<div class="profile">
				<div class="userProfile">
					<img src="resources/image/common/blank-profile.png" width="100" height="100" id="blank-profile">
				</div>
				<div class="nickName">
					<label>${ sessionScope.loginUser.nickName }</label> 
				</div>
			</div>
			
			<div class="box"></div>
			
			<br>
				<ul id="navi1">
					<li><a href="#">판매 관리</a>
						<ul>
							<li><a href="list.bo">술 판매 관리</a>
							<li><a href="#">향수 판매 관리</a>
							<li><a href="#">주문 관리 승인</a>
						</ul>
					
					</li>
					
					<br><br>
					
					<li><a href="#">사용자 관리</a>
						<ul>
							<li><a href="#">판매자 계정 승인</a>
						</ul>
					</li>
				</ul>
			</div>
			
			
			
</body>
</html>