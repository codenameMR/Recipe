<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int result = (Integer)request.getAttribute("delResult");

	String prePage = "";
	if (request.getAttribute("prePage")!=null) {
	prePage = (String)request.getAttribute("prePage");
	}
	System.out.println(prePage);
	
	String userId = (String)session.getAttribute("userId");
%>
<% if (result == 0) { %>
	<script>
		alert("레시피 삭제 실패");
		history.back();
	</script>
<% } else { 
		if(prePage.equals("")) {%>
		<script>
			alert("레시피 삭제 성공");
			location.href = "recipeBoard.do";
		</script>
	<%} else if(prePage.equals("mylike")){ %>
		<script>
			alert("레시피 삭제 성공");
	 		location.href = "myRecipeLike.do?like_id=<%=userId%>";
		</script>
	<% } else if(prePage.equals("myrecipe")) {%>
		<script>
			alert("레시피 삭제 성공");
	 		location.href = "myRecipeList.do?writer_id=<%=userId%>";
		</script>
	<% } 
 } %>