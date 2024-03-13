<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 리뷰 페이지</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    #review-wrap{
        width: 900px;
        margin: 0 auto;
        overflow: hidden;
    }
    .review-content-wrap{
        margin: 60px 0;
    }
    .review-content{
        display: flex;
        align-items: stretch;
        position: relative;
    }
    .focus-img-wrap{
        width: 300px;
        height: 300px;
    }
    .display-flex{display: flex;align-items: center;}
    .bottom-interval{margin-bottom: 3px}
    .img{
        height: 100%;
        width: 100%;
        object-fit: contain;
    }
    .review-article{
        width: 500px;
    }
    .profile{border-radius: 14px;}
    .profile-wrap{
        width: 28px;
        height: 28px;
        display: flex;
    }
    .name-wrap{
        font-size: 15px;
        margin-left: 5px;
    }
	.score-bg{
        width: 113px;
        height: 19px;
		background-image: url("resources/image/common/star-bg.svg");
        background-repeat: repeat-x;
        background-position: 0px 0px;
        background-size: auto 100%;
	}
    .score{
        height: 100%;
        background-image: url("resources/image/common/star.svg");
        background-repeat: repeat-x;
        background-position: 0px 0px;
        background-size: auto 100%;
    }
    .article-wrap{
        white-space: pre-wrap;
    }
    .img-container{
        width: 100px;
        height: 300px;
        display: flex;
        overflow-y: scroll;
        flex-wrap: wrap;
        align-content: flex-start;
    }
    .img-wrap{
        width: 100px;
        height: 100px;
    }
    .comment-open-btn{
        width: 100%;
        height: 23px;
        color: rgb(255, 255, 255);
        background-color: rgb(94, 94, 94);
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin: 20px 0;
    }
    .comment-open-btn:active{
        background-color: rgb(75, 75, 75);
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
        width: 10%;
        height: 60px;
        margin-left: 20px;
    }
    .disabled-btn{
        width: 10%;
        height: 60px;
        margin-left: 20px;
    }
    .review-comment{
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
        width: 200px;
        display: flex;
        justify-content: space-between;
        position: absolute;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
    }
    .like-btn-wrap{
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .like-btn{cursor: pointer;}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<section>
<input id="review-no" type="hidden" value="${review.reviewNo}">
<div id="review-wrap">
    <div class="review-content-wrap">
        <div class="review-content">
            <div class="focus-img-wrap">
                <img id="big-img" class="img" src="${review.reviewImages.get(0) }" alt="">
            </div>
            <div class="review-article">
                <div class="display-flex bottom-interval">
                    <div class="profile-wrap">
                        <c:choose>
                		<c:when test="${empty review.userProfile }">
                    		<img class="img profile" src="resources/image/common/blank-profile.png" alt="프로필사진">
                		</c:when>
                		<c:otherwise>
                    		<img class="img profile" src="${review.userProfile }" alt="프로필사진">
                		</c:otherwise>
                		</c:choose>
                    </div>
                    <div class="name-wrap">
                        ${review.userNo } <span>${review.reviewCreateDate }</span>
                    </div>
                </div>
                <div class="score-bg">
                    <div class="score" style="width: ${review.reviewScore*10}%;"></div>
                </div>
<pre class="article-wrap bottom-interval">
${review.reviewContent }
</pre>
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
            <div class="img-container">
            	<c:forEach begin="1" end="${review.reviewImages.size() }" var="i">
                <div class="img-wrap">
                    <img class="img small-img" src="${review.reviewImages.get(i-1) }" alt="">
                </div>
            	</c:forEach>
            </div>
        </div>
        <button class="comment-open-btn" type="button">펼치기</button>
        <div class="review-comment-div" style="display: none;">
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
            <div id="review-comment-wrap">
            </div>
        </div>
    </div>
</div>
</section>
<script>
    $(()=>{
    	loadRecommend();
        loadAllCommentList();

        $(".small-img").click(function(){
            $("#big-img").attr("src", $(this).attr("src"));
        });
        
        $("#like").click(()=>{
        	recommend('L');
        });
        $("#dislike").click(()=>{
        	recommend('D');
        });
        
        $(".comment-open-btn").click(function() {
            let $commentDiv = $(this).next(".review-comment-div");
            if ($commentDiv.css("display") === 'none') {
                $commentDiv.slideDown(100);
                $(".comment-open-btn").text("접기");
            } else {
                $commentDiv.slideUp(100);
                $(".comment-open-btn").text("펼치기");
            }
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
            const $reviewNo = $("#review-no");
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
                    reviewNo:$reviewNo.val(),
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
    });
    
    function recommend(ld){
    	$.ajax({
    		url:"reviewRecommend",
    		type:"get",
    		data:{
    			userNo:"${loginUser.userNo}",
    			likeFlag:ld,
    			contentNo:$("#review-no").val()
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
    		url:"loadReviewRecommend",
    		type:"get",
    		data:{
    			contentNo:$("#review-no").val()
    		},
    		success:(result)=>{
    			$("#like-count").text(result.likeCount);
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
                reviewNo:$("#review-no").val()
            },
            success:(result)=>{
                const $commentWrap = $("#review-comment-wrap");
                let value="";
                for(let i in result){
                    if(result[i].commentDepth == 0){
                        value+=  "<div class='review-comment'>"
                                +"<div class='display-flex bottom-interval'>"
                                +"<div class='profile-wrap'>"
                                +"<img class='img profile' src='resources/image/common/blank-profile.png' alt='프로필사진'>"
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
                        value+=  "<div class='review-comment'>"
                                +"<div class='display-flex bottom-interval'>"
                                +"<div class='profile-wrap'>"
                                +"<img class='img profile' src='resources/image/common/blank-profile.png' alt='프로필사진'>"
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
                "reviewNo":$("#review-no").val(),
                "commentGroup":commentGroup
            },
            success:(result)=>{
                console.log(result);
                const $commentWrap = $(".comment-no[value="+commentGroup+"]").parent().next(".re-comment-wrap");
                let value="";
                for(let i in result){
                    console.log("dd");
                    value+=  "<div class='review-comment'>"
                            +"<div class='display-flex bottom-interval'>"
                            +"<div class='profile-wrap'>"
                            +"<img class='img profile' src='resources/image/common/blank-profile.png' alt='프로필사진'>"
                            +"</div>"
                            +"<div class='name-wrap'>"+result[i].userNo+"</div>"
                            +"</div>"
                            +"<div>"+result[i].commentContent+"</div>"
                            +"<div>"+result[i].commentCreateDate+"</div>"
                            +"</div>";
                }
                $commentWrap.html(value);
            },
            error:()=>{
                console.log("통신실패");
            }
        });
    }
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>