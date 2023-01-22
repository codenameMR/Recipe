<%@page import="com.cook.model.Recipe"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");

List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
//Object에서 List<Recipe>로 타입변환

String[] rec_class = {"최신순","오래된순","조회순","좋아요순"};
int order = 0;
if (request.getAttribute("order") != null) {
	order = (Integer) request.getAttribute("order");
}

String search_word = "";
if(request.getAttribute("search_word") != null) {
search_word = (String) request.getAttribute("search_word");
}

String[] search_classes = {"글제목","글쓴이","글내용","카테고리"};
String[] search_values = {"rec_title","user_id","rec_content","rec_category"};
String search_class = "";
if(request.getAttribute("search_class") != null) {
search_class = (String) request.getAttribute("search_class");
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>레시피공유-레공</title>

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
          <a href="recipeBoard.do" class="list-group-item">레시피 게시판</a>
          <a href="../restaurant/list.jsp" class="list-group-item">맛집 게시판</a>
          <a href="#" class="list-group-item">게시판3</a>
          <a href="#" class="list-group-item">게시판4</a>
          <a href="#" class="list-group-item">게시판5</a>
        </div>
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
		<div style="height:20px"></div>
		<h1>전체 레시피 목록</h1>
	    <hr>
	    <label>정렬하기</label>
	    <%if (search_word=="" || search_class=="") {%> 
	    	<form name="orderform">
	    		<select onchange="orderlist()" name="num" > 
		 	 	<%for(int i = 0; i < rec_class.length; i++) { 
	    			if (i == order) {  %> 
	       				<option value="<%=i%>" selected><%=rec_class[i]%></option> 
	         		<% } else { %>
	    				<option value="<%=i%>" > <%=rec_class[i]%> </option>  	
	    			<%} 
	      		 } %>
	      	 	</select>
	      	 </form>
	    <%} else if (search_word!="" && search_class!="") { %>
	    	<form name="orderform2" id="orderform2">
	    		<input type="hidden" name="search_word" value=<%=search_word%>>
	     		<input type="hidden" name="search_class" value=<%=search_class%>>
	    		<select onchange="orderlist2()" name="num"> 
		 		<%for(int i = 0; i < rec_class.length; i++) { 
	    			if (i == order) {  %> 
	       				<option value="<%=i%>" selected><%=rec_class[i]%></option> 
	         		<% } else { %>
	    				<option value="<%=i%>" > <%=rec_class[i]%> </option>  	
	    			<%}
	     		}%>
	     		</select>	
			</form>
	    <%} %>  
			
		<div style="height:20px;"></div>
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
			if (recipeList != null) {
				for (Recipe recipe : recipeList) {
			%>
			<tr>
				<td><%=recipe.getRec_num()%></td>
				<td><a href="recipeView.do?rec_num=<%=recipe.getRec_num()%>"><%=recipe.getRec_title()%></a></td>
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
		</table>
		<br>
		<%  HttpSession session = request.getSession();
			if(session.getAttribute("userId")==null) {%>
			<button type="button" onclick="signin()">글쓰기</button>
		<%} else { %>
			<button type="button" onclick="location.href='recipeWrite.do'">글쓰기</button>	
		<%} %>
		<br>
		
		<!-- 검색 -->
		<div style="height:10px"></div>
		<form name="searchform" id="searchform">
		<% if(search_word.equals("")) { %>
			<input type=text placeholder="검색어 입력" name="search_word" required>
		<% } else { %>
			<input type=text placeholder="<%=search_word%>" name="search_word" required>	
		<% } %>
		
		<select name="search_class">  <!--order(option의 value) -->
		<% for (int i=0; i<4; i++) { 
				if (search_class.equals(search_values[i])) {
			%>
			<option value="<%=search_values[i]%>" selected><%=search_classes[i]%></option>
			<%  } else { %>
			<option value="<%=search_values[i]%>"><%=search_classes[i]%></option>
			<%  } 
			} %>	
		</select>
		<input type="button" value="검색하기" onClick="searchRec()">
		</form>
  	   </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
	</div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
  </div> <!-- /.container 중앙 끝 -->
	
  <!-- Footer 하단-->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="/recipeteamPJ/vendor/jquery/jquery.min.js"></script>
  <script src="/recipeteamPJ/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">	
function signin() {
	alert("로그인이 필요한 기능입니다");
}

//---------------------recipe_board 관련 ajax-----------------------//
//레시피 게시판 정렬
function orderlist() {
	var o = document.orderform;
	//console.log("orderlist1")
	//console.log(o.num.value);
		$.ajax({
			url : 'recipelist.do?num=' + o.num.value,
			success : function(data) {
				$('#center_right').html(data);
			}
		});
}
//레시피 게시판 검색 (post)
function searchRec() {
	//let sendData = "username="+$('input[name=username]').val();   //폼의 이름 값을 변수 안에 담아줌
	var formData = $("#searchform").serialize();
	//console.log(formData);
		$.ajax({
			url : 'recipelist.do',
			type : 'POST',
			data : formData,
			success : function(data) {
				$('#center_right').html(data);
			}
		});
	}
//레시피 게시판 검색후 정렬
function orderlist2() {
	var formData2 = $("#orderform2").serialize();
	//console.log("orderlist2");
	//console.log(formData2);
	$.ajax({
		url : 'recipelist.do',
		type : 'POST',
		data : formData2,
		success : function(data) {
			$('#center_right').html(data);
		}
	});
}

</script>
</html>
