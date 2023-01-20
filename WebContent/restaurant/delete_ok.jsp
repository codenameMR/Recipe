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
	
	int res_num = Integer.parseInt(request.getParameter("res_num"));
	
	
	Restaurant restaurant = new Restaurant(res_num);
	ResDAO dao = ResDAO.getInstance();
	int result = dao.deleteRes(res_num);
%>



  <script language=javascript>
   self.window.alert("삭제한 글 <%=result%> 건을 삭제하였습니다.");
   location.href="list.jsp"; 
</script>