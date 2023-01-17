<%@page import="teamProject2.LikeDao"%>
<%@page import="teamProject2.ResLike"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	String userid 	= request.getParameter("userId");	
	int resnum 		= Integer.parseInt(request.getParameter("resNum"));	
	String gubun 	= request.getParameter("gubun");	
	try{
		
		int result = 0;
				
		ResLike reslike = new ResLike(userid, resnum);
		
		LikeDao like = LikeDao.getInstance();
		
		// 좋아요
		if(gubun.equals("Y")){
			result = like.InsertRes(reslike);	
		}
		// 안좋아요
		else if(gubun.equals("N")){
			result = like.DeleteRES(reslike);
		}
				
	}catch (NumberFormatException e){
		e.printStackTrace();
	}
	
%>
<body>


<script>
window.location.href = "recipe_bord/recipe_list.jsp";	//돌아갈 페이지
</script>
</body>
</html>