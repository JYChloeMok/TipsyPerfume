<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${board.boardTitle } - Tipsy Perfume</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<style>
    .display-flex{display: flex;align-items: center;}
    .bottom-interval{margin-bottom: 3px}
    .profile-img{
        height: 100%;
        width: 100%;
        object-fit: contain;
        border-radius: 14px;
    }
    .profile-wrap{
        width: 28px;
        height: 28px;
        display: flex;
    }
    .name-wrap{
        font-size: 15px;
        margin-left: 5px;
    }

    #board-wrap{
        width: 1000px;
        margin: 0 auto;
        overflow: hidden;
        padding: 0px 0px 120px 0px;
    }
    #content-title{
        font-size: 36px;
        font-weight: 600;
        text-align: center;
        margin: 40px 0;
    }
    .table{
        width: 100%;
        text-align: center;
        border-spacing: 0px;
        border-collapse: collapse;
        margin-bottom: 30px;
        --bs-table-bg: none;
    }
    .table tr{
        border-style: solid;
        border-width: 2px 0px;
        border-color: rgb(165, 165, 165);
    }
    .table td{padding: 15px 0px;}
    .title-head{
        background-color: rgb(221, 221, 221);
        width: 350px;
    }
    .top-text{
        color: rgb(100, 100, 100);
        font-size: 14px;
    }
    .board-content-wrap{
        margin: 0 auto;
        width: 700px;
    }
    .board-content{
        font-size: 16px;
        width: 100%;
        margin: 0 auto;
        white-space: pre-wrap;
        line-height: 22px;
    }
    .board-content-image{
        width: 700px;
        margin: 0 auto;
    }
    .img{
        max-width: 100%;
    }
    
    .write-area{
        display: flex;
        justify-items: center;
        align-items: center;
    }
    .comment-textarea{
        resize: none;
        width: 85%;
        height: 100px;
        border-radius: 6px;
        padding: 2px 10px;
    }
    .comment-btn{
        width: 12%;
        height: 80px;
        margin-left: 20px;
        font-size: 18px;
        font-weight: 600;
        border: 4px solid rgb(223, 190, 106);
        border-radius: 10px;
        background-color: rgb(255, 255, 255);
        color: rgb(223, 190, 106);
    }
    .comment-btn:hover
    {
        background-color: rgb(223, 190, 106);
        color: rgb(255, 255, 255);
    }
    .disabled-btn{
        width: 12%;
        height: 80px;
        margin-left: 20px;
        font-size: 18px;
        font-weight: 600;
        border: 4px solid rgb(223, 190, 106);
        border-radius: 10px;
        background-color: rgb(255, 255, 255);
        color: rgb(223, 190, 106);
    }
    .board-comment{
        padding-bottom: 10px;
        border-bottom: 2px solid rgb(94, 94, 94);
        margin-bottom: 10px;
    }
    .re-comment-div{
        padding: 5px 20px;
        margin: 0 auto;
        background-color: rgb(221, 221, 221);
    }

    .like-wrap{
        width: 300px;
        display: flex;
        justify-content: space-between;
        margin: 50px auto;
    }
    .like-btn-wrap{
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .like-btn{cursor: pointer;}
    .board-btn{
    	font-size: 18px;
        font-weight: 600;
        border: 4px solid rgb(223, 190, 106);
        border-radius: 10px;
        background-color: rgb(255, 255, 255);
        color: rgb(223, 190, 106);
    }
    .board-btn:hover
    {
        background-color: rgb(223, 190, 106);
        color: rgb(255, 255, 255);
    }
    
    #board-list-wrap{
        margin: 0 auto;
    	margin-top: 50px;
    	margin-bottom: 10px;
    }
    #board-list-wrap .table{
    	margin-bottom: 0px;
    	text-align: center;
        border-collapse: collapse;
    }
    #board-list-wrap .table td{
        vertical-align: middle;
        border-color: rgb(214, 214, 214);
        border-bottom: 1px solid;
    }
    #board-list-wrap tbody>tr{
    	cursor: pointer;
    }
    #board-list-wrap tbody>tr>td:not(:nth-child(2n)){
        background-color: rgb(240, 240, 240);
    }
    .thead-dark{
    	position: sticky;
        top: 60px;
    }
    .board-no{width: 12%;}
    .board-title{width: 39%;text-align: left;}
    .board-writer{width: 15%;}
    .board-date{width: 13%;}
    .board-count{ width: 11%;}
    .like-count{width: 10%;}
    .comment-count{
    	font-size: 15px;
    	color: rgb(223, 190, 106);
    }
    #more-list{
    	display: block;
    	width: 300px;
    	margin: 0 auto;
    }
    .modify-text{
    	color: rgb(100, 100, 100);
    	font-size: 10px;
    	vertical-align: top;
    }
</style>
<section>
<input id="board-no" type="hidden" value="${board.boardNo}">
<div id="board-wrap">
    <div id="content-title">
        ${board.boardTitle }
        <c:if test="${loginUser.userNo eq board.boardWriterNo}">
            <button type="button" class="board-btn" onclick="location.href='boardUpdate?boardNo=${board.boardNo }'">수정</button>
        </c:if>
        <c:if test="${loginUser.userNo eq board.boardWriterNo or loginUser.memberType eq 'A'}">
            <button type="button" class="board-btn" onclick="location.href='boardDelete?boardNo=${board.boardNo }&boardCtgy=${board.boardCtgyCode }'">삭제</button>
        </c:if>
    </div>
    <button type="button" class="board-btn" onclick="history.back();">돌아가기</button>
    <table class="table">
        <tr class="title-head">
            <td>분류 <span class="top-text">${board.boardCtgyName }</span></td>
            <td>작성자 <span class="top-text">${board.boardWriter }</span></td>
            <td>작성일 <span class="top-text">${board.boardCreateDate }</span><c:if test="${not empty board.boardModifyDate }"><span class="modify-text"> *수정됨</span></c:if></td>
            <td><i class="fa fa-eye" style="font-size:20px"></i> <span class="top-text">${board.boardCount }</span></td>
            <td><i class='fa fa-thumbs-o-up' style='font-size:18px'></i> <span id="title-like" class="top-text">0</span></td>
            <td><i class='fa fa-thumbs-o-down' style='font-size:18px; transform: scaleX(-1);'></i> <span id="title-dislike" class="top-text">0</span></td>
        </tr>
    </table>
    <div class="board-content-wrap">
        <p class="board-content">
${board.boardContent }
        </p>
        <div class="like-wrap">
                    <c:choose>
                    <c:when test="${empty loginUser }">
                    	<div class="like-btn-wrap">
                        	<i class='fa fa-thumbs-o-up like-btn' style='font-size:36px' onclick="alert('로그인후 사용이 가능합니다')"></i>
                        	<div id="like-count"></div>
                    	</div>
                    	<div class="like-btn-wrap">
                        	<i class='fa fa-thumbs-o-down like-btn' style='font-size:36px; transform: scaleX(-1);' onclick="alert('로그인후 사용이 가능합니다')"></i>
                        <div id="dislike-count"></div>
                    	</div>
                    </c:when>
                    <c:otherwise>
                    	<div class="like-btn-wrap">
                        	<i id="like" class='fa fa-thumbs-o-up like-btn' style='font-size:36px'></i>
                        	<div id="like-count"></div>
                    	</div>
                    	<div class="like-btn-wrap">
                        	<i id="dislike" class='fa fa-thumbs-o-down like-btn' style='font-size:36px; transform: scaleX(-1);'></i>
                        <div id="dislike-count"></div>
                    	</div>
                    </c:otherwise>
                    </c:choose>
    	</div>
    </div>
    <div class="board-comment-div">
        <div>
            댓글쓰기
        </div>
        <div class="write-area">
            <c:choose>
            <c:when test="${empty loginUser }">
                <textarea class="comment-textarea" name="" readonly>로그인 후 작성해 주세요</textarea>
                <button class="disabled-btn" type="button" onclick="alert('로그인후 사용이 가능합니다')">입력</button>
            </c:when>
            <c:otherwise>
                <textarea class="comment-textarea" name=""></textarea>
                <button class="comment-btn" type="button">입력</button>
            </c:otherwise>
            </c:choose>
        </div>
        <div id="board-comment-wrap">
        </div>
    </div>
    <div id="board-list-wrap">
    	<table class="table table-hover">
        <thead class="thead-dark">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>좋아요</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody id="board-list">
        </tbody>
    </table>
    </div>
    <button id="more-list" class="board-btn">더보기</button>
</div>
</section>
<script>
    $(()=>{
    	let page=1;
    	
    	loadRecommend();
        loadAllCommentList();
        loadBoardList(page);
        
    	$("#like").click(()=>{
        	recommend('L');
        });
        $("#dislike").click(()=>{
        	recommend('D');
        });
        
        $(document).on("click",".re-comment-open", function(){
            let $reCommentDiv = $(this).next(".re-comment-div");
            if ($reCommentDiv.css("display") === 'none') {
                $reCommentDiv.slideDown(100);
                $(".comment-open-btn").text("닫기");
            } else {
                $reCommentDiv.slideUp(100);
                $(".comment-open-btn").text("답글");
            }
        });
        $(document).on("click",".comment-btn", function(){
            const $commentContent = $(this).prevAll(".comment-textarea");
            const $boardNo = $("#board-no");
            const $commentGroup = $(this).prevAll(".comment-no");
            const $commentDepth = $(this).prevAll(".comment-depth");
            const userNo = "${loginUser.userNo}";
            
            if($commentContent.val().trim()==""){
            	$commentContent.val("").focus();
                alert("내용을 작성해 주세요!");
                return;
            }
            
            $.ajax({
                url:"insertComment",
                type:"post",
                data:{
                    commentContent:$commentContent.val(),
                    commentGroup:$commentGroup.val(),
                    commentDepth:$commentDepth.val(),
                    boardNo:$boardNo.val(),
                    userNo:userNo
                },
                success:(result)=>{
                    if(result=="1"){
                        $commentContent.val("");
                        if($commentGroup.val()){
                            loadGroupCommentList($commentGroup.val());
                        }
                        else{
                            loadAllCommentList();
                        }
                    }
                },
                error:()=>{
                    console.log("통신실패");
                }
            });
        });
        
        $("#more-list").click(()=>{
        	page++;
        	loadBoardList(page);
        });
    });
    
    function recommend(ld){
    	$.ajax({
    		url:"boardRecommend",
    		type:"get",
    		data:{
    			userNo:"${loginUser.userNo}",
    			likeFlag:ld,
    			contentNo:$("#board-no").val()
    		},
    		success:(result)=>{
    			alert(result);
    			loadRecommend();
    		},
    		error:()=>{
    			console.log("통신실패");
    		}
    	})
    }
    function loadRecommend(){
    	$.ajax({
    		url:"loadBoardRecommend",
    		type:"get",
    		data:{
    			contentNo:$("#board-no").val()
    		},
    		success:(result)=>{
    			$("#title-like").text(result.likeCount);
    			$("#like-count").text(result.likeCount);
    			$("#title-dislike").text(result.dislikeCount);
    			$("#dislike-count").text(result.dislikeCount);
    		},
    		error:()=>{
    			console.log("통신실패");
    		}
    	})
    }
    
    function loadAllCommentList(){
        $.ajax({
            url:"commentList",
            type:"get",
            data:{
                boardNo:$("#board-no").val()
            },
            success:(result)=>{
                const $commentWrap = $("#board-comment-wrap");
                let value="";
                for(let i in result){
                    if(result[i].commentDepth == 0){
                        value+=  "<div class='board-comment'>"
                                +"<div class='display-flex bottom-interval'>"
                                +"<div class='profile-wrap'>"
                                +"<img class='profile-img' src='resources/image/common/blank-profile.png' alt='프로필사진'>"
                                +"</div>"
                                +"<div class='name-wrap'>"+result[i].userNo+"</div>"
                                +"</div>"
                                +"<div>"+result[i].commentContent+"</div>"
                                +"<div>"+result[i].commentCreateDate+"</div>"
                                +"<button class='re-comment-open'>답글 "
                        if(result[i].groupCount-1!=0){
                            value+=result[i].groupCount-1;
                        }
                        value+=  "</button><div class='re-comment-div' style='display: none;'>"
                                +"<div>답글쓰기</div>"
                                +"<div class='write-area'>"
                        if("${loginUser.userNo}"==""){
                        	value+=  "<textarea class='comment-textarea' readonly>로그인 후 작성해 주세요</textarea>"
                            		+"<button class='disabled-btn' type='button'  onclick=\"alert('로그인후 사용이 가능합니다')\">입력</button>";
                        }
                        else{
                        	value+=  "<textarea class='comment-textarea'></textarea>"
                        			+"<input class='comment-no' type='hidden' value='"+result[i].commentNo+"'>"
                        			+"<input class='comment-depth' type='hidden' value='"+result[i].commentDepth+1+"'>"
                        			+"<button class='comment-btn' type='button'>입력</button>";
                        }
                        value+=  "</div>"
                                +"<div class='re-comment-wrap'>";
                    }
                    else{
                        value+=  "<div class='board-comment'>"
                                +"<div class='display-flex bottom-interval'>"
                                +"<div class='profile-wrap'>"
                                +"<img class='profile-img' src='resources/image/common/blank-profile.png' alt='프로필사진'>"
                                +"</div>"
                                +"<div class='name-wrap'>"+result[i].userNo+"</div>"
                                +"</div>"
                                +"<div>"+result[i].commentContent+"</div>"
                                +"<div>"+result[i].commentCreateDate+"</div>"
                                +"</div>";
                    }
                    if(result[i].commentIndex == result[i].groupCount-1){
                        value+=  "</div>"
                                +"</div>"
                                +"</div>";
                    }
                }
                $commentWrap.html(value);
            },
            error:()=>{
                console.log("통신실패");
            }
        });
    }
    function loadGroupCommentList(commentGroup){
        $.ajax({
            url:"commentList",
            type:"get",
            data:{
                "boardNo":$("#board-no").val(),
                "commentGroup":commentGroup
            },
            success:(result)=>{
                console.log(result);
                const $commentWrap = $(".comment-no[value="+commentGroup+"]").parent().next(".re-comment-wrap");
                const $commentOpenBtn = $(".comment-no[value="+commentGroup+"]").parent().parent().prev(".re-comment-open");
                let value="";
                for(let i in result){
                    console.log("dd");
                    value+=  "<div class='board-comment'>"
                            +"<div class='display-flex bottom-interval'>"
                            +"<div class='profile-wrap'>"
                            +"<img class='profile-img' src='resources/image/common/blank-profile.png' alt='프로필사진'>"
                            +"</div>"
                            +"<div class='name-wrap'>"+result[i].userNo+"</div>"
                            +"</div>"
                            +"<div>"+result[i].commentContent+"</div>"
                            +"<div>"+result[i].commentCreateDate+"</div>"
                            +"</div>";
                }
                $commentOpenBtn.text("답글 "+result.length);
                $commentWrap.html(value);
            },
            error:()=>{
                console.log("통신실패");
            }
        });
    }
    function loadBoardList(page){
    	$.ajax({
    		url:"boardList",
    		type:"get",
    		data:{
    			"page":page,
    			"boardNo":${board.boardNo },
    			"boardCtgy":"${board.boardCtgyCode }"
    		},
    		success:(result)=>{
    			console.log(result);
    			if(result.length){
    				const boardList = document.getElementById("board-list");
                    let value="";
                    for(let i in result){
                    	value+="<tr onclick=\"location.href='boardDetail?boardNo="+result[i].boardNo+"'\">"
                        	+"<td class='board-no'>"+result[i].boardNo+"</td>"
                        	+"<td class='board-title'>"+result[i].boardTitle+" ";
                        if(result[i].commentCount){
                        	value+="<span class='comment-count'>["+result[i].commentCount+"]</span>";
                        }
                        value+="</td><td class='board-writer'>"+result[i].boardWriter+"</td>"
                        	+"<td class='board-date'>"+result[i].boardCreateDate+"</td>"
                        	+"<td class='like-count'>"+result[i].likeCount+"</td>"
                        	+"<td class='board-count'>"+result[i].boardCount+"</td>"
                    		+"</tr>";
                    }
                    boardList.innerHTML+=value;
    			}
    			else{
    				$("#more-list").css("display","none");
    			}
    		},
    		error:()=>{
    			console.log("통신실패");
    		}
    	})
    }
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>