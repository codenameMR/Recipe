<%@page import="restaurant.Restaurant"%>
<%@page import="java.util.List"%>
<%@page import="restaurant.ResDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	List<Restaurant> res_list = ResDAO.getInstance().selectAll();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>게시판</title>
 </head>
 <body>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr height="5"><td width="5"></td></tr>
 <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
   <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
   <td width="73">번호</td>
   <td width="73">제목</td>
   <td width="73">작성자</td>
   <td width="73">조회수</td>
   <td width="73">좋아요수</td>
   <td width="73">작성일</td>
  </tr>
<% if(res_list !=null){
	  for(Restaurant restaurant : res_list){
	  	%>
<tr height="25" align="center">
	<td>&nbsp;</td>
	<td><%=restaurant.getRes_num() %></td>
	<td align="left"><a href="view.jsp?res_num=<%=restaurant.getRes_num()%>"><%=restaurant.getTitle() %></td>
	<td align="center"><%=restaurant.getUser_id() %></td>
	<td align="center"><%=restaurant.getViews() %></td>
	<td align="center"><%=restaurant.getLikes() %></td>
	<td align="center"><%=restaurant.getDate() %></td>
	<td>&nbsp;</td>
</tr>
<% }
	  }%>
  <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>

 </table>
 
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr align="center">
   <td><input type=button value="글쓰기" OnClick="window.location='write.jsp'"></td>
  </tr>
</table>
</body> 
</html>