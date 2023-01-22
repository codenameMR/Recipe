package com.cook.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.*;

import teamProject2.LikeDao;

public class MyRecipeCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//정렬
		String orderStr = request.getParameter("order");
		//System.out.println(orderStr);
		int order = 0;
		if (orderStr != null) {
			order = Integer.parseInt(orderStr);
		}
		
		//내 레시피
		RecipeDAO recipeDao = RecipeDAO.getInstance();
		List<Recipe> myRecipeList = null;
		String writer_id = request.getParameter("writer_id");
		if(writer_id != null) {
			myRecipeList = recipeDao.myRecipe(writer_id);
			myRecipeList = recipeDao.selectAllByOrder(order, myRecipeList);		
		}
		request.setAttribute("order", order);	
		request.setAttribute("myRecipeList", myRecipeList);	
		
	}

}
