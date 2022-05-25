<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>seller진행</title>
    <link rel="stylesheet" href="resources/css/bootstrap.css">
    <link rel="stylesheet" href="resources/css/sellerReq.css">
    <script src="resources/js/jquery-3.6.0.js"></script>
    <script src="resources/js/sellerReq.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;700&display=swap');
        #textarea{
        	font-size:10px;
        	padding-left:5px;
        }
        #enType{
        	width:300px;
        	font-size:10px;
        	
        }
        #enpath{
        	width:300px;
        	height:30px;
        	font-size:10px;
        	
        }
        input{
        	padding-left:5px;
        }
		.adsear{
		    width:90px;
		    height:40px;
		    color: #fff;
		    
		    font-size: 11px;
		    background-color: #00b2b2;
		}
		.sign{
		    width:200px;
		    
		    background-color: #00b2b2;  
		}
		#signupb{
			background-color: #00b2b2; 
			border-radius: 5px;
		}
		#signupb:hover{
		    background-color: #00b2b2; 
		    opacity: 0.7;
		    transition: 1s;
		}
		#signupb:focus{
		    box-shadow: none;
		    background-color: #00b2b2; 
		    opacity: 0.7;
		    transition: 1s;
		}
		#photopath{
		    width:200px;        
		    height:30px;
		    font-size:10px;
		    margin-left:90px ;
		}
		.imgbox{
			border : 1px solid rgba(51,51,51,0.2);
		}
    </style>
</head>
<body>
    <%@include file="/WEB-INF/views/common/header.jsp" %>
            
    <div class="content">
            <h5>판매자 신청</h5>
            
            <ul class="signup">
            		<form action="sellerReq.do" method="post" enctype="multipart/form-data">        
                
                    <li>
                        <input type="hidden" name="memberId" value="${sessionScope.m.memberId }">
                        <div class="imgbox"><img src="" alt="" style="width:80px;height:70px;"></div>
                        <span class="greeting">Fun 예비 메이커 ~님 환영합니다</span>
                        <input type="file" class="form-control" onchange="loadImg(this)" id="photopath"  name="upfile">
                    </li>
                    <li>
                        <div class="ti intro">회사소개 및 인사말</div>
                        <textarea class="text" name="enIntro" id="textarea" placeholder="회사 소개 100자 이내로 간략히 작성하세요" required></textarea>
                        <div></div>
                    </li>
                    <li>
                        <div class="ti">사업자 등록 번호</div>
                        <input type="text" name="enNo" placeholder="사업자 등록 번호 14자리 입력">
                        <div></div>
                    </li>

                    <li>
                        <div class="ti">업종</div>
                        <select name="enType" id="enType" class="form-select">
                            <option value="0">리빙</option>
                            <option value="1">뷰티</option>
                            <option value="2">반려동물</option>
                            <option value="3">여행</option>
                            <option value="4">푸드</option>
                        </select>
                    </li>
                    <li>
                        <div class="ti">사업자 등록 첨부파일</div>
                        <input type="file"  class="form-control" id=enpath name="upfile">
                    </li>
                    <li>
                        <div class="ti">대표자</div>
                        <input type="text" name="owner" placeholder="대표자 명 입력">
                        <div></div>
                        
                    </li>
                    <li>
                        <div class="ti">소재지</div>
                        <input type="text" style="width:210px; margin-bottom:2px"name="postcode" id="postcode" placeholder="우편번호">
                        <button class="btn btn-primary adsearc" type="button" onclick="searchAddr();" id="signupb">주소검색</button>
                        <input type="text" name="detailAddress" id="detailAddress" placeholder="주소">
                        <input type="text" style="margin-top:3px;"name="address" id="address" placeholder="상세주소">
                        
                        
                    </li>
                    <li>
                        <div class="ti">직급</div>
                        <input type="text" name="position" placeholder="ex)사원, 대리">
                    </li>
                    <input type="hidden" name="authSeller" value="0">
                    

                    <li>
                        <div class="askb"><button type="submit" class="btn btn-primary signupb" id="signupb">관리자에게 요청</button>
                        <div></div>
                        </div>
                        <div><span class="ask">* 잘못된 정보를 등록하시면 요청이 반려될 수 있습니다.</span></div>
                    </li>
                </form>
            </ul>
        
    </div>
    <script>
    	function loadImg(f){
    		console.log(f.files); //input file에서 선택한 파일이 여러개일 수 있으므로 여러개로 처리
    		//배열의 길이가 0이 아니고 , 배열 첫번째 파일이 정상적인 파일이면 
    		if(f.files.length !=0 && f.files[0]!=0){
    			const reader = new FileReader(); //파일의 정보를 읽어오는 객체생성 
    			reader.readAsDataURL(f.files[0]);
    			reader.onload = function(e){
    				$(".imgbox>img").attr("src",e.target.result);
    			}
    		}else{
    			$(".imgbox>img").attr("src","");
    		}
    		
    	}
    	function searchAddr(){
			new daum.Postcode({
				oncomplete : function(data){
					console.log(data)
					$("#postcode").val(data.zonecode);
					$("#detailAddress").val(data.roadAddress);
					$("#address").focus();
				}
			}).open();
		}
    </script>
    
</body>
</html>