<%@page import="java.util.List"%>
<%@page import="teamProject2.*"%>
<%@page import="com.cook.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");
HttpSession session = request.getSession();
String userId = (String)session.getAttribute("userId");

List<Recipe> viewList = null; 
if(request.getAttribute("myRecipeList")!=null) { //내가 쓴 레시피 
	viewList = (List<Recipe>)request.getAttribute("myRecipeList");
}

String[] order_name = {"최신순","오래된순","조회순","좋아요순"};
int order = 0;
if (request.getAttribute("order") != null) {
	order = (Integer) request.getAttribute("order");
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>레시피공유-마이페이지</title>
	
  <!-- Bootstrap core CSS -->
  <link href="/recipeteamPJ/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="/recipeteamPJ/css/shop-homepage.css" rel="stylesheet">
  
  <style>
  	table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
    	text-align: center;
	}
	table {
		width: 100%;
	}
	label{
	font-size: 30px;
	}
  </style>
</head>

<body>
  <!-- 상단 Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <jsp:include page="../header.jsp" />
  </nav>

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1200px">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
        <h1 class="my-4">게시판</h1>
        <div class="list-group">
          <a href="myPage.jsp" class="list-group-item">회원정보 수정</a>
          <a href="myRecipeList.do?writer_id=<%=userId%>" class="list-group-item">내가 쓴 레시피</a>
          <a href="myRes.jsp" class="list-group-item">내가 쓴 맛집</a>
          <a href="myRecipeLike.do?like_id=<%=userId%>" class="list-group-item">좋아요한 레시피</a>
          <a href="myResLike.jsp" class="list-group-item">좋아요한 맛집</a>
        </div>
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
	  	<div style="height:20px"></div>
	  		<h1>내가 쓴 레시피</h1>
	  		<hr> 
	  		<label>정렬하기</label>
	  		<form id="orderform" name="orderform">
	  			<input type="hidden" name="writer_id" value="<%=userId%>">
	    		<select onchange="orderlist()" name="order"> 
		 	 	<%for(int i = 0; i < order_name.length; i++) { 
	    			if (i == order) {  %> 
	       				<option value="<%=i%>" selected><%=order_name[i]%></option> 
	         		<% } else { %>
	    				<option value="<%=i%>" ><%=order_name[i]%> </option>  	
	    			<%} 
	      		 } %>
	      	 	</select>
      		</form>	
      		
      		<br>
		  	<table>
			<tr>
				<th>게시글 번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>조회수</th>
				<th>좋아요수</th>
				<th>카테고리</th>
				<th>등록일</th>
			</tr>
			<%
			if (viewList != null) {
				for (Recipe recipe : viewList) {
			%>
			<tr>
				<td><%=recipe.getRec_num()%></td>
				<td>
					<a href="myRecipeView.do?rec_num=<%=recipe.getRec_num()%>&prePage=myrecipe"><%=recipe.getRec_title()%></a>
				</td>
				<td><%=recipe.getUser_id()%></td>
				<td><%=recipe.getRec_views()%></td>
				<td><%=recipe.getRec_likes()%></td>
				<td><%=recipe.getRec_category()%></td>
				<td><%=recipe.getRec_date()%></td>
			</tr>
			<%
				}
			} 
			%>
	  </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
      
     </div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
       
  </div>
  <!-- /.container 중앙 끝 -->

  <!-- Bootstrap core JavaScript -->
  <script src="/recipeteamPJ/vendor/jquery/jquery.min.js"></script>
  <script src="/recipeteamPJ/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
//정렬하기
function orderlist() {
	var formData = $("#orderform").serialize();
	//console.log(formData1);
	$.ajax({
		url : 'myRecipeListOrder.do',
		type : 'POST',
		data : formData,
		success : function(data) {
			$('#center_right').html(data);
		}
	});
}
</script>
</html>
