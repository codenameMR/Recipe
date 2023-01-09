<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="heartCss.css">
</head>
<body>

<div class="right_area"> 
 <a href="javascript:;" class="icon heart" onclick="onClick();">
     <img id="heart" src="https://cdn-icons-png.flaticon.com/512/812/812327.png" alt="찜하기">
  </a></div>
</body>

<form action="처리할 페이지.jsp" id="frm">
	<input type="hidden" id="userId"> 		<!-- 아이디 -->
	<input type="hidden" id="resNum"> 		<!-- 게시글 순번 -->
	<input type="hidden" id="gubun"> 		<!-- 등록 및 삭제 여부 -->
</form>

<script>

function onClick(){
	
	var tmp = document.getElementById("heart").src; // 이미지 경로 추출
	var imgNm = tmp.substr(tmp.length-10, 6)		// 이미지 파일명 추출
	
	// 찜하기 완료
	if(imgNm == "812327"){
		document.getElementById("heart").src = "https://cdn-icons-png.flaticon.com/512/803/803087.png";
		document.getElementById("gubun").value = "Y";
	}
	// 찜하기 미완료
	else if(imgNm == "803087"){
		document.getElementById("heart").src = "https://cdn-icons-png.flaticon.com/512/812/812327.png";
		document.getElementById("gubun").value = "N";
	}
}

</script>
</html>