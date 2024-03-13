<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Tipsy Perfume - 도감</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<style>
    #content-wrap{
        width: 700px;
        margin: 0 auto;
        overflow: hidden;
        padding: 70px 0px;
    }
    #pedia-wrap{
        width: 100%;
        height: 700px;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-content: flex-start;
        padding: 30px 0px;
        border-radius: 0px 20px 20px 20px;
        overflow-y: scroll;
    }
    #pedia-wrap::-webkit-scrollbar{width: 20px;}
    #pedia-wrap.alcohol::-webkit-scrollbar-thumb{
        background: rgb(223, 190, 106);
        border: 7px solid rgb(104, 103, 94);
        border-radius: 10px;
    }
    #pedia-wrap.perfume::-webkit-scrollbar-thumb{
        background: rgb(223, 190, 106);
        border: 7px solid rgb(92, 78, 97);
        border-radius: 10px;
    }
    #pedia-wrap::-webkit-scrollbar-track{background: inherit;}
    #pedia-wrap::-webkit-scrollbar-button:vertical:start:decrement {
        display: block;
        height: 30px;
    }
    #pedia-wrap::-webkit-scrollbar-button:vertical:end:decrement {
        display: block;
        width: 30px;
    }
    .pedia-tab{
        width: 140px;
        height: 40px;
        border-radius: 15px 15px 0px 0px;
        line-height: 40px;
        text-align: center;
        font-size: 20px;
        font-weight: 600;
        color: rgb(255, 255, 255);
        display: inline-block;
        cursor: pointer;
    }
    .alcohol{background-color: rgb(104, 103, 94);}
    .perfume{background-color: rgb(92, 78, 97);}
    .pedia-item{
        width: 100px;
        height: 100px;
        margin: 10px;
        background-color: rgb(255, 255, 255);
        border: 1px solid rgb(223, 190, 106);
    }
    .img{
        width: 100%;
        height: 100%;
        object-fit: contain;
    }
    .disable{
        background-color: black;
    }
    .disable .img{
        filter: grayscale(100%);
        opacity: 0.6;
    }
    #pedia-detail-wrap{
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
    }
    #modal-background{
        width: 100%;
        height: 100%;
        position: fixed;
        top: 0;
        left: 0;
        background-color: rgba(0, 0, 0, 0.6);
        z-index: 2000;
    }
    #pedia-detail{
        width: 500px;
        height: 650px;
        position: fixed;
        left: 50%;
        transform: translateX(-50%);
        background-color: rgb(35, 31, 32);
        border: 1px solid rgb(223, 190, 106);
        border-radius: 20px;
        padding: 20px;
        color: rgb(223, 190, 106);
        margin-top: 80px;
        z-index: 3000;
    }
    #detail-top{
        height: 250px;
        display: flex;
    }
    #detail-img{
        width: 250px;
        height: 250px;
    }
    #detail-info{
        padding: 0px 10px;
        font-size: 13px;
    }
    #detail-title{
        font-size: 32px;
        font-weight: 600;
    }
    #detail-content{
        width: 100%;
        height: 300px;
        overflow-x: hidden;
        overflow-y: scroll;
    }
    #detail-content::-webkit-scrollbar{width: 20px;}
    #detail-content::-webkit-scrollbar-thumb{
        background: rgb(223, 190, 106);
        border: 7px solid rgb(35, 31, 32);
        border-radius: 10px;
    }
    #detail-content::-webkit-scrollbar-track{background: inherit;}
    #detail-article{
        white-space: pre-wrap;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<section>
<div id="content-wrap">
    <div class="pedia-tab alcohol">주류</div><div class="pedia-tab perfume">향수</div>
    <div id="pedia-wrap" class="alcohol">
        <div class="pedia-item disable" onclick="view(1);">
            <img class="img" src="resources/image/product/alcohol/alcohol_1.png">
        </div>
        <div class="pedia-item" onclick="view(2);">
            <img class="img" src="resources/image/product/alcohol/alcohol_1.png">
        </div>
        <div class="pedia-item disable" onclick="view(1);">
            <img class="img" src="resources/image/product/alcohol/alcohol_1.png">
        </div>
        <div class="pedia-item disable" onclick="view(1);">
            <img class="img" src="resources/image/product/alcohol/alcohol_1.png">
        </div>
    </div>
</div>
<div id="pedia-detail-wrap" style="display: none;">
    <div id="modal-background"></div>
    <div id="pedia-detail">
        <div id="detail-top">
            <div id="detail-img">
                <img class="img" src="resources/image/product/alcohol/alcohol_1.png">
            </div>
            <div id="detail-info">
                가격 : <span id="pdtPrice"></span><br>
                구매 횟수 : <span id="userBuy"></span><br>
                총 사용 금액 : <span id="totalPrice"></span><br>
                리뷰 수 : <span id="totalReview"></span>건<br>
                내가 쓴 리뷰 수 : <span id="userReview"></span>건<br>
            </div>
        </div>
        <div id="detail-title">
            조니워커 블루라벨
        </div>
        <div id="detail-content">
<pre id="detail-article">
</pre>
        </div>
    </div>
</div>
</section>
<script>
    $(()=>{
    	loadPedia("A");
        $("#modal-background").click(()=>{
            $("#pedia-detail-wrap").css("display","none");
            $("body").css("overflow","");
        })
        $(".pedia-tab").click(function(){
            if($(this).hasClass("alcohol") && $("#pedia-wrap").hasClass("perfume")){
            	loadPedia("A");
                $("#pedia-wrap").removeClass("perfume").addClass("alcohol");
            }
            else if($(this).hasClass("perfume") && $("#pedia-wrap").hasClass("alcohol")){
            	loadPedia("F");
                $("#pedia-wrap").removeClass("alcohol").addClass("perfume");
            }
        })
    })
    function view(pdtNo){
        //console.log(pdtNo);
        //ajax
        $.ajax({
        	url:"selectPediaInfo",
        	data:{
        		"pdtNo":pdtNo,
    			"userNo":${loginUser.userNo}
        	},
        	async:false,
        	success:(result)=>{
        		const $pediaWrap = $("#pedia-wrap");
    			$("#detail-img img").attr("src",result.pdtImage);
    			$("#detail-title").text(result.pdtName);
    			$("#detail-article").text(result.pdtDescription);
    			$("#pdtPrice").text(result.pdtPrice);
    			$("#userBuy").text(result.userBuy);
    			$("#totalPrice").text(result.totalPrice);
    			$("#totalReview").text(result.totalReview);
    			$("#userReview").text(result.userReview);
        	},
        	error:()=>{
        		console.log("통신실패");
        	}
        })
        $("#pedia-detail-wrap").css("display","");
        $("body").css("overflow","hidden");
    }
    function loadPedia(pdtCteg){
    	$.ajax({
    		url:"selectPediaList",
    		data:{
    			"pdtCteg":pdtCteg,
    			"userNo":${loginUser.userNo}
    		},
    		async:false,
    		success:(result)=>{
    			const $pediaWrap = $("#pedia-wrap");
    			let value="";
    			for(let i in result){
    				if(result[i].userBuy!="0"){
    					value+=  "<div class='pedia-item' onclick='view("+result[i].pdtNo+");'>"
	            		+"<img class='img' src="+result[i].pdtImage+">"
	            		+"</div>";
    				}
    				else{
    					value+=  "<div class='pedia-item disable' onclick='view("+result[i].pdtNo+");'>"
	            		+"<img class='img' src="+result[i].pdtImage+">"
	            		+"</div>";
    				}
    			}
    			$pediaWrap.html(value);
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