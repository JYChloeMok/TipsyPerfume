<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 리뷰 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	#writer-wrap{
		width: 1000px;
		margin: 0 auto;
        padding: 0px 0px 60px 0px;
        overflow: hidden;
	}
	#sub-title{
        font-size: 36px;
        font-weight: 600;
        text-align: center;
        margin: 40px 0;
    }
    #writeForm{
        width: 700px;
        height: 750px;
        float: left;
    }
    #image-wrap{
        width: 300px;
        height: 750px;
        overflow-y: scroll;
        float: left;
    }
    .img{
        width: 280px;
        height: 280px;
        object-fit: contain;
        border: 2px solid rgb(223, 190, 106);
        border-radius: 5px;
        margin-bottom: 10px;
    }
    
    #score-select-wrap{
        position: relative;
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
    #scroe-btn-wrap{
        position: absolute;
        top: 0;
        left: 0;
    }
    .scroe-btn{
        display: inline-block;
        width: 11.5px;
        height: 19px;
        padding: 0px;
        margin: 0px;
        border: none;
        background-color: transparent;
    }
    .scroe-btn:focus{
        outline: none;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<section>
<div id="writer-wrap">
<div id="sub-title">
	리뷰 작성
</div>
<form id="writeForm" method="post" action="reviewWrite.do" enctype="multipart/form-data">
	<input type="hidden" name="userNo" value="${loginUser.userNo }">
	<table class="table">
		<tr>
			<th><label>제품</label></th>
			<td>${pdtName }</td>
			<td>
				<input type="hidden" id="pdtNo" name="pdtNo" value="${pdtNo }">
			</td>
		</tr>
        <tr>
			<th><label>별점</label></th>
			<td>
                <input type="hidden" id="reviewScore" name="reviewScore" value="1">
                <div id="score-select-wrap">
                    <div class="score-bg">
                        <div class="score" style="width: ${review.reviewScore*10}%;"></div>
                    </div>
                    <div id="scroe-btn-wrap">
                        <button type="button" class="scroe-btn" onclick="setScore(1);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(2);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(3);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(4);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(5);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(6);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(7);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(8);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(9);"></button
                        ><button type="button" class="scroe-btn" onclick="setScore(10);"></button>
                    </div>
                </div>
            </td>
		</tr>
        <tr>
        	<th><label>사진</label></th>
        	<td><input multiple="multiple" type="file" class="uploadImg" class="form-control-file border" name="uploadImg" accept="image/gif, image/jpeg, image/png" onchange="loadImg(this);" required></td>
        </tr>
		<tr>
			<th><label for="reviewContent">내용</label></th>
			<td><textarea id="reviewContent" class="form-control" rows="20" style="resize:none;" name="reviewContent" required></textarea></td>
		</tr>
	</table>
	<div align="center">
		<button type="button" id="submit-btn" class="btn btn-primary">작성하기</button>
		<button type="reset" class="btn btn-danger">취소하기</button>
	</div>
</form>
<div id="image-wrap"></div>
</div>
</section>
<script>
    $(()=>{
        const $reviewContent = $("#reviewContent");
        const $writeForm = $("#writeForm");
        setScore(1);
        $("#submit-btn").click(()=>{
            if($reviewContent.val().trim()==""){
                $reviewContent.val("").focus();
                alert("내용을 작성해 주세요!");
            } else{
                $writeForm.submit();
            }
        });
    })

    function loadImg(inputFile){
        const imageWrap = document.getElementById("image-wrap");
        imageWrap.innerHTML="";
        for(let i=0;i<inputFile.files.length;i++){
            let render = new FileReader()
            render.readAsDataURL(inputFile.files[i])
            render.onload = (e)=>{
                imageWrap.innerHTML+="<img class='img' src='"+e.target.result+"'/>";
			}
        }
    }
    function setScore(score){
        const scoreImg=document.getElementsByClassName("score")[0];
        $("#reviewScore").val(score);
        console.log($("#reviewScore").val());
        scoreImg.style.width=score+"0%";
    }
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>