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
	
		.table-outer{
		width:800px;
		height:1000px;
		float:left;
		margin-left:50px;
		margin-top:50px;
		
		}
		.boardList{
		width:90%;
	
		}
		
		.content1{
	
		}
	
	</style>
</head>
<body>

	<!-- 메뉴바 -->
	<jsp:include page="../common/header.jsp" />
		
	<div class="content">
		<jsp:include page="../adminManage/adminSideBar.jsp" />
			
            
        <div class="table-outer">
        	<h2>술 판매 관리</h2>
        	<a class="btn btn-secondary" style="float:right;" href="adminAlcoholEnrollForm.me">술 상품 등록</a>
        	
        	<br><br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>상품 번호</th>
                        <th>상품명</th>
                        <th>판매 가격</th>
                        <th>등록일</th>
                        <td>조회수</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${ list }" var="b">
						<tr>
							<td class="bno">${b.pdtNo }</td>
							<td>${b.pdtName }</td>
							<td>${b.pdtPrice }</td>
							<td>${b.pdtDate }</td>
							<td>${b.pdtCount }</td>
						</tr>
					</c:forEach>
                </tbody>
            </table>
         
            
			 <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="list.bo?cPage=${ pi.currentPage - 1 }">Previous</a></li>
                    	</c:otherwise>
                    </c:choose>
                    
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    <li class="page-item"><a class="page-link" href="list.bo?cPage=${ p }">${p}</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="list.bo?cPage?cPage=${ pi.maxPage -1 }">Next</a></li>
                    	</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>	
				
				
				 <br clear="both"><br>

            <form id="searchForm" action="" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="condition">
                        <option value="writer">카테고리 번호</option>
                        <option value="title">상품명</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            </div>
            <br><br>
        </div>
        <br><br>
				
				  </div> 
				
				
				
				
				
				
				
				
				
				
			</div><!-- content2끝 -->
			
		</div><!-- content 끝 div -->
		
		<script>
            $(function(){
            	$('#boardList > tbody > tr').click(function(){
            		location.href = 'detail.bo?bno=' + $(this).children('.bno').text();
            	});
            })
            </script>
		<jsp:include page="../common/footer.jsp" />
</body>
</html>