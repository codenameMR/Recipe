package com.cook.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;


public class ListCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//기본
		List<Recipe> recipeList = RecipeDAO.getInstance().selectAllRecipe();
        
		//정렬
		String orderStr = request.getParameter("num");
		//System.out.println(orderStr);
		int order = 0;
		if (orderStr != null) {
			order = Integer.parseInt(orderStr);
		}
		recipeList = RecipeDAO.getInstance().selectAllByOrder(order);
		
		
		request.setAttribute("recipeList", recipeList);
	}
}


