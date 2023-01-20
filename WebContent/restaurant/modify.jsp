<%@page import="restaurant.Restaurant"%>
<%@page import="restaurant.ResDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String user_id=(String)session.getAttribute("userId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>게시판</title>
 </head>
 <body>
<%
 	int res_num = Integer.parseInt(request.getParameter("res_num"));
%>
<form name=modify method=post action="modify_ok.jsp?res_num=<%=res_num%>">

<table>
<input type="hidden" name="res_num" value=<%=res_num%>size="50" maxlength="100">
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <td>수정</td>
    </table>
   <table>
   
     <tr>
      <td>&nbsp;</td>
      <td align="center">제목</td>
      <td><input name="title" size="50" maxlength="100" required></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">지역</td>
      <td><select name="loc">
      	<option value="서울">서울</option>
      	<option value="경기">경기</option>
      	<option value="강원">강원</option>
      	<option value="경상도">경상도</option>
      	<option value="전라도">전라도</option>
      	<option value="제주">제주</option>
      	</select></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea name="content" cols="50" rows="13" required></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2"><input type="submit" value="수정">
      <td>&nbsp;</td>
     </tr>
     </form>
     
    </table>
   </td>
  </tr>
 </table>
</body> 
</html>