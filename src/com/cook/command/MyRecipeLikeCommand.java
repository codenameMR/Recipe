package com.cook.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.*;

import teamProject2.LikeDao;

public class MyRecipeLikeCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		RecipeDAO recipeDao = RecipeDAO.getInstance();
		LikeDao likeDao = LikeDao.getInstance();
		
		//정렬
		String orderStr = request.getParameter("order");
		//System.out.println(orderStr);
		int order = 0;
		if (orderStr != null) {
			order = Integer.parseInt(orderStr);
		}
		
		//내가 좋아요한 레시피 
		List<Recipe> myLikeRecList = null;
		String like_id = request.getParameter("like_id");
		if(like_id != null) {
			myLikeRecList = likeDao.myLike(like_id);
			myLikeRecList = recipeDao.selectAllByOrder(order, myLikeRecList);
		}
		
		request.setAttribute("order", order);
		request.setAttribute("myLikeRecList", myLikeRecList);
	}

}
