<%@page import="com.cook.model.Recipe"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
request.setCharacterEncoding("utf-8");
HttpSession session = request.getSession();
List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
//Object에서 List<Recipe>로 타입변환

//정렬기능
String[] rec_class = {"최신순","오래된순","조회순","좋아요순"};
int order = 0;
if (request.getAttribute("order") != null) {
	order = (Integer) request.getAttribute("order");
}

//검색기능
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

//페이징 처리 
int startPage = (Integer)request.getAttribute("startPage");
int endPage = (Integer)request.getAttribute("endPage");
int totalPages = (Integer)request.getAttribute("totalPages");
int tempPage = 1;
if (request.getAttribute("tempPage")!=null) {
	tempPage = (Integer)request.getAttribute("tempPage");
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
table a {
 color:orangered;
}
.my.page-link {
	color:coral;
}
.my.pagination > .active > a, 
.my.pagination > .active > span, 
.my.pagination > .active > a:hover, 
.my.pagination > .active > span:hover, 
.my.pagination > .active > a:focus, 
.my.pagination > .active > span:focus {
  background: coral;
  border-color: coral;
}
</style>
</head>

<body style="padding-top: 0px; font-family: 'Noto Sans KR', sans-serif;">
  <!-- 상단 Navigation -->
  <jsp:include page="../header.jsp" />

  <!-- 중앙 Page Content -->
  <div class="container" id="center" style="height:1500px; padding-top:10px;">
    <div class="row"> <!-- 왼쪽(게시판)과 오른쪽(내용) 정렬 -->
	
      <div class="col-lg-3"> <!-- 왼쪽 (게시판) -->
        <jsp:include page="../board.jsp" />
      </div> <!-- /.col-lg-3 왼쪽(게시판) 끝-->
      
	  <div class="col-lg-9" id ="center_right"> <!-- 오른쪽(내용) --> 
		<div style="height:20px"></div>
		<h1>전체 레시피 목록</h1>
	    <hr> <br>
	    <div class="d-flex justify-content-end"> 
	    <label>정렬하기&nbsp;&nbsp;</label>
	    <%if (search_word=="" || search_class=="") {%> 
	    	<form name="orderform">
	    		<select onchange="orderlist()" name="order" > 
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
	    		<select onchange="orderlist2()" name="order"> 
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
		</div>	
		
		<div style="height:20px;"></div>
		<table class="table">
			<colgroup>
				<!-- <col width="5%"> -->
				<col width="45%">
				<col width="12%">
				<col width="7%">
				<col width="7%">
				<col width="7%">
				<col width="18%">
			</colgroup>
			<thead class="thead-light">
				<tr>
					<!-- <th scope="col">게시글 번호</th> -->
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">조회수</th>
					<th scope="col">좋아요수</th>
					<th scope="col">카테고리</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<%
			if (recipeList != null) {
				for (Recipe recipe : recipeList) {
			%>
			<tbody>
				<tr>
					<%-- <td><%=recipe.getRec_num()%></td> --%>
					<td><a href="recipeView.do?rec_num=<%=recipe.getRec_num()%>"><%=recipe.getRec_title()%></a></td>
					<td><%=recipe.getUser_id()%></td>
					<td><%=recipe.getRec_views()%></td>
					<td><%=recipe.getRec_likes()%></td>
					<td><%=recipe.getRec_category()%></td>
					<td><%=recipe.getRec_date()%></td>
				</tr>
			<%	}
			} else {
			%>
			<tr><td colspan="6">데이터가 존재하지 않습니다.</td></tr>
			<%}%>
			</tbody>
		</table>
		
		<br>
		<%  if(session.getAttribute("userId")==null) {%>
			<button type="button" onclick="signin()">글쓰기</button>
		<%} else { %>
			<button type="button" onclick="location.href='recipeWrite.do'">글쓰기</button>	
		<%} %>
		<br>
		
		<!-- 페이지 --> 
		<nav aria-label="Page navigation">
		  <ul class="pagination justify-content-center my">
		      <% if (startPage == 1) {%>
			      <li class="page-item disabled"><a class="page-link" href="#"
			          tabindex="-1" aria-disabled="true">Previous</a></li>
		      <% } else {%>
			      <li class="page-item"><a class="page-link my" href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=startPage - 1%>')"
			          tabindex="-1"
			          aria-disabled="true">Previous</a></li>
		      <% }%>
		      
		      <% for (int i = startPage; i <= endPage; i++) {%>
			      <%if (tempPage == i) { %>
				      <li class="page-item active">
					      <a class="page-link" href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=i%>')"
					      ><%=i%></a>
					  </li>
			      <%} else { %>
				      <li class="page-item">
					      <a class="page-link my" href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=i%>')"
					      ><%=i%></a>
					  </li>
			      <%} 
		       } %>
		      
		      <%  // 마지막 페이지 숫자와 startPage에서 pageLength 더해준 값이 일치할 때
		          // (즉 마지막 페이지 블럭일 때)
		          if (totalPages == endPage) {
		      %>
		      	<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
		      <% } else {%>
			  	<li class="page-item">
			    	<a class="page-link my" 
			    	href="javascript:goPage('<%=search_class%>','<%=search_word%>','<%=order%>','<%=endPage + 1%>')">Next</a>
			    </li>
		      <% }%>
		  </ul>
		</nav>
		
		<!-- 검색 -->
		<div style="height:10px"></div>
		<div class="d-flex justify-content-center">
			<form name="searchform" id="searchform">
				<input type="hidden" name="tempPage" value="1">
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
		</div> 
		<!-- 검색 끝 -->
		
  	   </div> <!--/.col-lg-9 오른쪽(내용) 끝--> 	
	</div> <!-- /.row 왼쪽,오른쪽 정렬 끝--> 
  </div> <!-- /.container 중앙 끝 -->
	
  <!-- Footer 하단--> 
  <jsp:include page="../footer.jsp" />

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
			url : 'recipelist.do?order=' + o.order.value,
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

function goPage(search_class, search_word, order, tempPage){
    let pageForm = document.createElement('form');
    
    let obj_class;
    obj_class = document.createElement('input');
    obj_class.setAttribute('type', 'hidden');
    obj_class.setAttribute('name', 'search_class');
    obj_class.setAttribute('value', search_class);
    
    let obj_word;
    obj_word = document.createElement('input');
    obj_word.setAttribute('type', 'hidden');
    obj_word.setAttribute('name', 'search_word');
    obj_word.setAttribute('value', search_word);
    
    let obj_order;
    obj_order = document.createElement('input');
    obj_order.setAttribute('type', 'hidden');
    obj_order.setAttribute('name', 'order');
    obj_order.setAttribute('value', order);
    
    let obj_page;
    obj_page = document.createElement('input');
    obj_page.setAttribute('type', 'hidden');
    obj_page.setAttribute('name', 'tempPage');
    obj_page.setAttribute('value', tempPage);
    
    pageForm.appendChild(obj_class);
    pageForm.appendChild(obj_word);
    pageForm.appendChild(obj_order);
    pageForm.appendChild(obj_page);
    
    pageForm.setAttribute('method', 'post');
    pageForm.setAttribute('action', 'recipePage.do');
    document.body.appendChild(pageForm);
    pageForm.submit();
}

</script>
</html>
