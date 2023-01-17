<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
Recipe recipe = (Recipe) request.getAttribute("recipe");
String login_id = "";
if (session.getAttribute("userId") != null) {
login_id = (String)session.getAttribute("userId");
}

if (recipe == null ) {
%>
<script>
	alert("해당 정보가 삭제되었거나 존재하지 않습니다.");
</script>
<%
	return; //if 문 아래 소스코드 실행 x.
}
%>

<%	String writer_id = recipe.getUser_id();

	int rec_num = recipe.getRec_num();
	String rec_title = recipe.getRec_title();
	String rec_content = recipe.getRec_content();
	String rec_date = recipe.getRec_date();
	int rec_views = recipe.getRec_views();
	int rec_likes = recipe.getRec_likes();
	String rec_category = recipe.getRec_category();
	
	String rec_pic1 = "";
	String rec_pic2 = "";
	String rec_pic3 = "";
	if (recipe.getRec_pic1() != null)
	rec_pic1 = recipe.getRec_pic1().substring(14);
	if (recipe.getRec_pic2() != null)
	rec_pic2 = recipe.getRec_pic2().substring(14);
	if (recipe.getRec_pic3() != null)
	rec_pic3 = recipe.getRec_pic3().substring(14);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>레시피 글 상세 보기</title>
<style>
.imgView img{
	width:100px; 
	height:100px;
}
</style>
</head>
<body>
	<h1>레시피 제목 : <%=rec_title%></h1>
	<hr>
	<strong>종류 : </strong> <%=rec_category%><br>
	<strong>글쓴이 : </strong> <%=writer_id%><br>
	<strong>내용 : </strong> <%=rec_content%><br>
	<strong>조회수 : </strong> <%=rec_views%><br>
	<strong>좋아요수 : </strong> <%=rec_likes%><br>
	<strong>등록일 :</strong> <%=rec_date%><!-- <br><br> -->
	<div class=imgView> 
		<%if(rec_pic1 != "") {%>
		<img src="/projectCook1/rec_pic/<%=rec_pic1%>" alt="게시글 <%=rec_num%>의 picture1">
		<%} if(rec_pic2 != "") {%>
		<img src="/projectCook1/rec_pic/<%=rec_pic2%>" alt="게시글 <%=rec_num%>의 picture2">
		<%} if(rec_pic3 != "") {%>
		<img src="/projectCook1/rec_pic/<%=rec_pic3%>" alt="게시글  <%=rec_num%>의 picture3">
		<%} %>
	</div>
	
	<form action="recipeWriteOk.do" method="post" enctype="multipart/form-data">
	<br><hr><br>
	<button type="button" id="tolistBtn">목록으로</button>
	<% if ( login_id.equals(writer_id) ) { %>
		<button type="button" onclick="updateRec(<%=rec_num%>)">수정하기</button>
		<button type="button" onClick="deleteRec(<%=rec_num%>)">삭제하기</button>
	<%} else {%>
		<button type="button" disabled>수정하기</button>
		<button type="button" disabled>삭제하기</button>
	<%} %>
	</form>
	<button type="button" id="writeBtn">신규등록</button>
    <button type="button" >좋아요</button>
    
    <script type="text/javascript">

    </script>
</body>
</html>