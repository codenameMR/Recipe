<%@page import="restaurant.ResDAO"%>
<%@page import="restaurant.Restaurant"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
			request.setCharacterEncoding("UTF-8");

			int res_num = Integer.parseInt(request.getParameter("res_num"));
			String title = request.getParameter("title");
			String user_id = request.getParameter("user_id");
			String content = request.getParameter("content");
			String picture1 = request.getParameter("picture1");
			String picture2 = request.getParameter("picture2");
			String picture3 = request.getParameter("picture3");
			String loc = request.getParameter("loc");
			
			ResDAO resdao = ResDAO.getInstance();
			int restr = resdao.updateRes(title,  content,  picture1, picture2, picture3,  loc, res_num);

%>
				  <script language=javascript>
				  	self.window.alert("글이 수정되었습니다.");
				  	location.href="list.jsp"; 
				  </script>
</body>
</html>