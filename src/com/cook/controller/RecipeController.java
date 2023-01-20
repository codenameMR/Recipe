package com.cook.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cook.command.*;
import com.oreilly.servlet.MultipartRequest;


@WebServlet("*.do")
public class RecipeController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // POST 방식 한글 처리
		doProcess(request, response);
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		Command command = null; // 어떠한 로직을 수행할지
		String viewPage = null; // 어떠한 페이지를 보여줄지

		// URL로부터 command 분리
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());
		//http://localhost:8080/Book/example.do라는 request가 들어왔다고 가정합니다.
		// uri 부분은 /Book/example.do가 될 것이고,
		//conPath 부분은 /Book이 될 것이고,
		//com 부분은 /example.do
		
		
		switch (com) {
		case "/recipeBoard.do":
			command = new ListCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_board.jsp";
			break;
		case "/recipelist.do":
			command = new ListCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_list.jsp";
			break;	
		case "/recipeView.do":
		    command = new ReadCommand();
		    command.execute(request, response);
		    viewPage = "/recipe_board/recipe_view.jsp";
		    break;
		case "/recipeWrite.do":
			viewPage = "/recipe_board/recipe_writeform.jsp";
			break;
		case "/recipeWriteOk.do":
			command =  new WriteCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_write.jsp";
			break;
		case "/recipeUpdate.do":
			command = new SelectCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_updateform.jsp";
			break;
		case "/recipeUpdateOk.do":
			command = new UpdateCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_update.jsp";
			break;
		case "/recipeDelete.do":
			command = new DeleteCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_delete.jsp";
			break;
		}

		// view page로 forward
		if (viewPage != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}

}
