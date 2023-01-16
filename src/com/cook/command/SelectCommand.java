package com.cook.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;


public class SelectCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rec_num = Integer.parseInt(request.getParameter("rec_num"));
		Recipe recipe = null;
		recipe = RecipeDAO.getInstance().selectRecipe(rec_num);
		
		request.setAttribute("recipe", recipe);
		
	}
}
