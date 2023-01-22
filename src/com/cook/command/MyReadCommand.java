package com.cook.command;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.model.Recipe;
import com.cook.model.RecipeDAO;

public class MyReadCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		Recipe recipe = null;
		int rec_num = Integer.parseInt(request.getParameter("rec_num"));
		
		try {
			recipe = RecipeDAO.getInstance().readRecipe(rec_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//내가 쓴 레시피/ 좋아요 누른 레시피
		String prePage = request.getParameter("prePage");
		request.setAttribute("prePage", prePage);
		
		request.setAttribute("recipe", recipe);
	}

}
