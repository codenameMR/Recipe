<%@page import="com.cook.model.RecipeDAO"%>
<%@page import="teamProject2.LikeDao"%>
<%@page import="teamProject2.RecLike"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String login_id = "";
if (session.getAttribute("userId") != null) {
login_id = (String)session.getAttribute("userId");
}
int rec_num = Integer.parseInt(request.getParameter("rec_num"));
RecLike newRecLike = new RecLike(login_id, rec_num);
int resultLike = LikeDao.getInstance().InsertRec(newRecLike);
int afterLikes = RecipeDAO.getInstance().likeRec(rec_num);
%>
<%=afterLikes%>