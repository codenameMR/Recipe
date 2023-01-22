<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int result = (Integer)request.getAttribute("updateResult");
	Recipe recipe = (Recipe)request.getAttribute("recipe");
	
	String prePage = "";
	if (request.getAttribute("prePage")!=null) {
		prePage = (String)request.getAttribute("prePage");
	}
%>

<% if(result == 0){%> 
   	<script>
 	  	alert("레시피 수정 실패");
 	  	history.back();
   	</script>
<% } else if(result > 0) { 
	 if(prePage.equals("")) {%>
		<script>
			alert("레시피 수정 성공");
				location.href = "recipeView.do?rec_num=<%=recipe.getRec_num()%>";
		</script>
	<%} else if(prePage.equals("mylike")){ %>
		<script>
			alert("레시피 수정 성공");
	 		location.href = "myRecipeView.do?rec_num=<%=recipe.getRec_num()%>&prePage=mylike";
		</script>
	<% } else if(prePage.equals("myrecipe")) {%>
		<script>
			alert("레시피 수정 성공");
	 		location.href = "myRecipeView.do?rec_num=<%=recipe.getRec_num()%>&prePage=myrecipe";
		</script>
		<% } 
}	 
%>
