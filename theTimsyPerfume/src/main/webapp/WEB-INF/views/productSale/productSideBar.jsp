<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="resources/css/productSale/productSideBar.css">


</head>




<body>


	<form id="pdtSideBarForm" action="#" method="post">
		<div id="productSideBarWrap" class="d-none d-lg-block">
		    <div id="pdtSideBarSortArea" class="btn-group" role="group" aria-label="Basic radio toggle button group">
		    	<input type="hidden" id="sidebarPdtCteg" value="${pdtCteg}">
		    	<input type="hidden" id="sidebarSort" value="${sort}">
		    	<input type="hidden" id="sidebarCurrentPage" value="${pi.currentPage}">
		    	
				<input type="radio" class="btn-check pdt-side-bar-sort" name="sort" value="New" id="sideBarSortBtn1" autocomplete="off">
				<label class="btn btn-outline-primary" for="sideBarSortBtn1"></label>
				
				<input type="radio" class="btn-check pdt-side-bar-sort" name="sort" value="BestSeller" id="sideBarSortBtn2" autocomplete="off">
				<label class="btn btn-outline-primary" for="sideBarSortBtn2"></label>
				
				<input type="radio" class="btn-check pdt-side-bar-sort" name="sort" value="Popular" id="sideBarSortBtn3" autocomplete="off">
				<label class="btn btn-outline-primary" for="sideBarSortBtn3"></label>
			</div>


			<div class="accordion" id="accordionPanelsStayOpenExample">
		        <div class="accordion-item">
		          <h2 class="accordion-header" id="panelsStayOpen-headingOne">
		            <button class="accordion-button" type="button" data-bs-toggle="collapse"
		              data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
		              aria-controls="panelsStayOpen-collapseOne">
		              브랜드
		              ${pdtManufac}
		            </button>
		          </h2>
		          <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show"
		            aria-labelledby="panelsStayOpen-headingOne">
		            <div class="accordion-body">
		
		              <div class="list-group custom-control custom-checkbox pdt-side-checkbox">
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  그레이 구스
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  베일리스
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  바카디
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  스미노프
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  헤네시
		                </label>
		              </div>
		            </div>
		          </div>
		        </div>
		
		
		        <div class="accordion-item">
		          <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
		            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
		              data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false"
		              aria-controls="panelsStayOpen-collapseTwo">
		              종류 PDT_GROUP
		            </button>
		          </h2>
		          <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse"
		            aria-labelledby="panelsStayOpen-headingTwo">
		            <div class="accordion-body">
		
		              <div class="list-group custom-control custom-checkbox pdt-side-checkbox">
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  맥주
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  소주
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  와인
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  샴페인
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  헤네시
		                </label>
		              </div>
		            </div>
		          </div>
		        </div>
		
		
		        <div class="accordion-item">
		          <h2 class="accordion-header" id="panelsStayOpen-headingThree">
		            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
		              data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false"
		              aria-controls="panelsStayOpen-collapseThree">
		              가격
		            </button>
		          </h2>
		          <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse"
		            aria-labelledby="panelsStayOpen-headingThree">
		            <div class="accordion-body">
		              
		              <!-- ↓ 슬라이더 오픈소스, https://codepen.io/Manitoba/pen/ZWRjye?js-preprocessor=babel
		                Copyright (c) 2023 - JY - https://codepen.io/Manitoba/pen/ZWRjye?js-preprocessor=babel
		
		                Permission is hereby granted, free of charge, to any person 
		                obtaining a copy of this software and associated documentation 
		                files (the "Software"), to deal in the Software without restriction,
		                including without limitation the rights to use, copy, modify, 
		                merge, publish, distribute, sublicense, and/or sell copies of 
		                the Software, and to permit persons to whom the Software is 
		                furnished to do so, subject to the following conditions:
		
		                The above copyright notice and this permission notice shall 
		                be included in all copies or substantial portions of the Software.
		
		                THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
		                EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
		                OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
		                NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
		                HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
		                WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
		                OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
		                DEALINGS IN THE SOFTWARE.
		                -->
		              <div slider id="slider-distance">
		                <div>
		                  <div inverse-left style="width:70%;"></div>
		                  <div inverse-right style="width:70%;"></div>
		                  <div range style="left:30%;right:40%;"></div>
		                  <span thumb style="left:30%;"></span>
		                  <span thumb style="left:60%;"></span>
		                  <div sign style="left:30%;">
		                    <span id="sidebar-range-value">30</span>
		                  </div>
		                  <div sign style="left:60%;">
		                    <span id="sidebar-range-value">60</span>
		                  </div>
		                </div>
		                <input type="range" tabindex="0" value="30" max="100" min="0" step="1" oninput="this.value=Math.min(this.value,this.parentNode.childNodes[5].value-1);
		                var value=(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.value)-(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.min);
		                var children = this.parentNode.childNodes[1].childNodes;
		                children[1].style.width=value+'%';
		                children[5].style.left=value+'%';
		                children[7].style.left=value+'%';children[11].style.left=value+'%';
		                children[11].childNodes[1].innerHTML=this.value;" />
		
		                <input type="range" tabindex="0" value="60" max="100" min="0" step="1" oninput="
		                this.value=Math.max(this.value,this.parentNode.childNodes[3].value-(-1));
		                var value=(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.value)-(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.min);
		                var children = this.parentNode.childNodes[1].childNodes;
		                children[3].style.width=(100-value)+'%';
		                children[5].style.right=(100-value)+'%';
		                children[9].style.left=value+'%';children[13].style.left=value+'%';
		                children[13].childNodes[1].innerHTML=this.value;" />
		              </div>
		              <!-- ↑ 슬라이더 오픈소스 -->
		            </div>
		          </div>
		        </div>
		
		        <div class="accordion-item">
		          <h2 class="accordion-header" id="panelsStayOpen-headingFour">
		            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
		              data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false"
		              aria-controls="panelsStayOpen-collapseFour">
		              도수
		            </button>
		          </h2>
		          <div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse"
		            aria-labelledby="panelsStayOpen-headingFour">
		            <div class="accordion-body">
		              <!-- ↓ 슬라이더 오픈소스, https://codepen.io/Manitoba/pen/ZWRjye?js-preprocessor=babel -->
		              <div slider id="slider-distance">
		                <div>
		                  <div inverse-left style="width:70%;"></div>
		                  <div inverse-right style="width:70%;"></div>
		                  <div range style="left:30%;right:40%;"></div>
		                  <span thumb style="left:30%;"></span>
		                  <span thumb style="left:60%;"></span>
		                  <div sign style="left:30%;">
		                    <span id="sidebar-range-value">30</span>
		                  </div>
		                  <div sign style="left:60%;">
		                    <span id="sidebar-range-value">60</span>
		                  </div>
		                </div>
		                <input type="range" tabindex="0" value="30" max="100" min="0" step="1" oninput="this.value=Math.min(this.value,this.parentNode.childNodes[5].value-1);
		                var value=(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.value)-(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.min);
		                var children = this.parentNode.childNodes[1].childNodes;
		                children[1].style.width=value+'%';
		                children[5].style.left=value+'%';
		                children[7].style.left=value+'%';children[11].style.left=value+'%';
		                children[11].childNodes[1].innerHTML=this.value;" />
		
		                <input type="range" tabindex="0" value="60" max="100" min="0" step="1" oninput="
		                this.value=Math.max(this.value,this.parentNode.childNodes[3].value-(-1));
		                var value=(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.value)-(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.min);
		                var children = this.parentNode.childNodes[1].childNodes;
		                children[3].style.width=(100-value)+'%';
		                children[5].style.right=(100-value)+'%';
		                children[9].style.left=value+'%';children[13].style.left=value+'%';
		                children[13].childNodes[1].innerHTML=this.value;" />
		              </div>
		              <!-- ↑ 슬라이더 오픈소스 -->
		            </div>
		          </div>
		        </div>
		
		        <div class="accordion-item">
		          <h2 class="accordion-header" id="panelsStayOpen-headingFive">
		            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
		              data-bs-target="#panelsStayOpen-collapseFive" aria-expanded="false"
		              aria-controls="panelsStayOpen-collapseFive">
		              용량
		            </button>
		          </h2>
		          <div id="panelsStayOpen-collapseFive" class="accordion-collapse collapse"
		            aria-labelledby="panelsStayOpen-headingFive">
		            <div class="accordion-body">
		              <div class="list-group custom-control custom-checkbox pdt-side-checkbox">
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--
		                  -->~ 100 ml
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  100ml ~ 300ml
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  300ml ~ 500ml
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  600ml ~ 800ml
		                </label>
		                <label class="list-group-item">
		                  <input class="form-check-input me-1" type="checkbox" value="">
		                  800ml ~
		                </label>
		              </div>
		            </div>
		          </div>
		        </div>
		    </div>
		</div>
	</form>

	<script src="resources/js/productSale/productSideBar.js"></script>
  </body>

  </html>