<%@page import="restaurant.ResDAO"%>
<%@page import="restaurant.Restaurant"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*,java.io.*"%>
  
<%
	request.setCharacterEncoding("UTF-8");
	
	
	String user_id = request.getParameter("user_id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String picture1 = request.getParameter("picture1");
	String picture2 = request.getParameter("picture2");
	String picture3 = request.getParameter("picture3");
	String loc = request.getParameter("loc");
	
	
	
	Restaurant restaurant = new Restaurant(user_id, title, content, picture1, picture2, picture3, loc);
	ResDAO resdao = ResDAO.getInstance();
	int result = resdao.insertRes(restaurant);
%>

  <script language=javascript>
   self.window.alert("입력한 글 <%=result%> 건을 저장하였습니다.");
   location.href="list.jsp"; 
</script>