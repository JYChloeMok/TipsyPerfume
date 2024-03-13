<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 글수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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

<script src="resources/js/board/summernote-lite.js"></script>
<script src="resources/js/board/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="resources/css/board/summernote-lite.css">

<section>
<div id="writer-wrap">
<div id="sub-title">
	${board.boardCtgyName} 글 수정
</div>
<form id="writeForm" method="post" action="boardUpdate.do" enctype="multipart/form-data">
	<input type="hidden" name="boardNo" value="${board.boardNo }">
	<table class="table">
		<tr>
			<th><label for="boardTitle">제목</label></th>
			<td><input type="text" id="boardTitle" class="form-control" name="boardTitle" value="${board.boardTitle }" required></td>
		</tr>
		<tr>
			<th><label for="boardContent">내용</label></th>
			<td><textarea id="boardContent" class="form-control" rows="20" style="resize:none;" name="boardContent" required>${board.boardContent }</textarea></td>
		</tr>
	</table>
	<div align="center">
		<button type="button" id="submit-btn" class="btn btn-primary">수정하기</button>
		<button type="reset" class="btn btn-danger" onclick="summerReset();">취소하기</button>
		<button type="button" class="btn btn-dark" onclick="history.back();">돌아가기</button>
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
        else if($('#boardContent').summernote('isEmpty')){
            $boardContent.val("").focus();
            alert("내용을 작성해 주세요!");
        } else{
            $writeForm.submit();
        }
    })

    $('#boardContent').summernote({
	    height: 500,
	    width: 800,
	    minHeight: null,
	    maxHeight: null,
	    focus: true,
	    lang: "ko-KR",
	    placeholder: '내용을 작성해 주세요.',
	    toolbar:[
	    	['style', ['style']],
	    	['font', ['bold', 'underline', 'clear']],
	    	['fontname', ['fontname']],
	    	['color', ['color']],
	    	['para', ['ul', 'ol', 'paragraph']],
	    	['table', ['table']],
	    	['insert', ['link', 'picture', 'video']],
	    	['view', ['codeview', 'help']]
	    ],
	    callbacks:{
	    	onImageUpload:function(files){
	    		uploadBoardImageFile(files[0]);
	    	},
	    	onPaste:function(e){
	    		var clipboardData = e.originalEvent.clipboardData;
	    		if(clipboardData && clipboardData.items && clipboardData.items.length){
	    			var item = clipboardData.items[0];
	    			if (item.kind == 'file' && item.type.indexOf('image/') != -1){
	    				e.preventDefault();
	    			}
	    		}
	    	}
	    }
    });
});
function uploadBoardImageFile(file){
	data = new FormData();
	data.append("file",file);
	$.ajax({
		data : data,
		type : "POST",
		url : "uploadBoardImageFile",
		contentType : false,
		processData : false,
		success : (data)=>{
			$('#boardContent').summernote('insertImage', data.url);
		},
		error:()=>{
			console.log("통신실패");
		}
	});
}
function summerReset(){
	$('#boardContent').summernote('reset');
}
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>