<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 글작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="resources/js/board/summernote-lite.js"></script>
<script src="resources/js/board/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="resources/css/board/summernote-lite.css">
<style>
	#writer-wrap{
		width: 900px;
		margin: 0 auto;
        padding: 0px 0px 60px 0px;
	}
	#sub-title{
        font-size: 36px;
        font-weight: 600;
        text-align: center;
        margin: 40px 0;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<section>
<div id="writer-wrap">
<div id="sub-title">
	${boardCtgyName} 글 작성
</div>
<form id="writeForm" method="post" action="boardWrite.do" enctype="multipart/form-data">
	<input type="hidden" name="boardCtgyCode" value="${boardCtgyCode }">
	<input type="hidden" name="boardWriterNo" value="${loginUser.userNo }">
	<table class="table">
		<tr>
			<th><label for="boardTitle">제목</label></th>
			<td><input type="text" id="boardTitle" class="form-control" name="boardTitle" required></td>
		</tr>
		<tr>
        	<th><label for="upfile">첨부파일</label></th>
        	<td><input multiple="multiple" type="file" class="uploadImg" class="form-control-file border" name="uploadImg" accept="image/gif, image/jpeg, image/png" onchange="loadImg(this);"></td>
        </tr>
		<tr>
			<th><label for="boardContent">내용</label></th>
			<td><textarea  id="boardContent" class="form-control" name="boardContent" required></textarea></td>
		</tr>
	</table>
	<div align="center">
		<button type="button" id="submit-btn" class="btn btn-primary">작성하기</button>
		<button type="reset" class="btn btn-danger">취소하기</button>
	</div>
</form>
</div>
</section>
<script>
    $(()=>{
        const $boardTitle = $("#boardTitle");
        const $boardContent = $("#boardContent");
        const $writeForm = $("#writeForm");

        $("#submit-btn").click(()=>{

            if($boardTitle.val().trim()==""){
                $boardTitle.val("").focus();
                alert("제목을 작성해 주세요!");
            }
            else if($boardContent.val().trim()==""){
                $boardContent.val("").focus();
                alert("내용을 작성해 주세요!");
            } else{
                $writeForm.submit();
            }
        })

        $('#boardContent').summernote({
		    height: 300,                 // 에디터 높이
		    minHeight: null,             // 최소 높이
		    maxHeight: null,             // 최대 높이
		    focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		    lang: "ko-KR",					// 한글 설정
		    placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
	    });
    })
    function loadImg(inputFile){
        const boardContent = document.getElementById("boardContent");
        //boardContent.value = boardContent.value.replace(/{img%d}/g, "");
        for(let i=0;i<inputFile.files.length;i++){
            boardContent.value+="\n{img"+(i+1)+"}\n";
        }
    }
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>