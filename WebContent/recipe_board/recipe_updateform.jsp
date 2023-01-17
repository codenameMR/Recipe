<%@page import="com.cook.model.Recipe"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
Recipe recipe = (Recipe) request.getAttribute("recipe");

if (recipe == null ) {
%>
<script>
	alert("해당 정보가 삭제되었거나 존재하지 않습니다.");
	history.back();
</script>
<%
	return;  //if 문 아래 소스코드 실행 x.
}
%>

<%
String[] rec_categories = {"한식","중식","일식","양식","기타"};
int rec_num = recipe.getRec_num();
String user_id= recipe.getUser_id();
String rec_title = recipe.getRec_title();
String rec_content = recipe.getRec_content();
String rec_date = recipe.getRec_date();
int rec_views = recipe.getRec_views();
int rec_likes = recipe.getRec_likes();
String rec_category = recipe.getRec_category();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=rec_title %> 수정</title>
</head>
<body>
	<h1><%=rec_title %> 수정</h1>
	<hr>
	<form name="frm" action="recipeUpdateOk.do" method="post"  enctype="multipart/form-data">
		<input type="hidden" name="rec_num" value="<%=rec_num %>"/>
		<strong>제목 : </strong>
		<input type="text" name="rec_title" value="<%=rec_title %>" required/><br>
		<strong>글쓴이(id) : </strong> <%=user_id%><br>
		<input type="hidden" name="user_id" value="<%=session.getAttribute("userId")%>">
		<strong>내용 : </strong>
		<textarea name="rec_content" 
						style="width: 300px; height: 200px;" required><%=rec_content%></textarea><br>
		<strong>카테고리 : </strong>
		<select name="rec_category">
    			<%for(String categoryName : rec_categories) { 
    				  	if (categoryName == recipe.getRec_category()) {  %> 
       				  <option value="<%=rec_category%>" selected><%=rec_category%></option> 
         			   <% } else { %>
    					<option value="<%=categoryName%>" > <%=categoryName%> </option>  	
    				   <%} 
    				}%>
		</select><br>				
		<strong>조회수 : </strong> <%=rec_views%><br>
		<strong>좋아요수 : </strong> <%=rec_likes%><br>
		<strong>등록일 :</strong> <%=rec_date%><br>
			<div>
				<h3 class="fileuploder">
				<label>이미지 첨부1 </label> 
					<input id="rec_pic_file1" class="btn" name="rec_pic1" type="file"
						 accept=".gif, .jpg, .png"
						onchange="fileUpload()">
				</h3>
			</div>

			<div>
				<h3 class="fileuploder">
					<label>이미지 첨부2 </label> 
					<input id="rec_pic_file2" class="btn" name="rec_pic2" type="file"
						 accept=".gif, .jpg, .png"
						onchange="fileUpload()">
				</h3>
			</div>
			
			<div>
				<h3 class="fileuploder">
					<label>이미지 첨부3 </label> 
					<input id="rec_pic_file3" class="btn" name="rec_pic3" type="file"
						 accept=".gif, .jpg, .png"
						onchange="fileUpload()">
				</h3>
			</div>
		
		<input type="submit" value="수정하기"/>	
	</form>
	
	<br><hr><br>
	<button id="tolistBtn">목록으로</button>
	

</body>
</html>