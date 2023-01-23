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
		//레시피게시판, 목록으로 클릭 시 (1페이지로)
		case "/recipeBoard.do":
			command = new ListCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_board.jsp";
			break;
		//정렬, 검색시 (1페이지로) 
		case "/recipelist.do":
			command = new ListCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_list.jsp"; //ajax로 사용 
			break;
		//다른 페이지 클릭시
		case "/recipePage.do":
			command = new ListCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_board.jsp";  
			break;
		
		//게시글 1개 조회 
		case "/recipeView.do":
		    command = new ReadCommand();
		    command.execute(request, response);
		    viewPage = "/recipe_board/recipe_view.jsp";
		    break;
		 
		//글쓰기 
		case "/recipeWrite.do":
			viewPage = "/recipe_board/recipe_writeform.jsp";
			break;
		case "/recipeWriteOk.do":
			command =  new WriteCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_write.jsp";
			break;
		
		//글 수정 
		case "/recipeUpdate.do":
		case "/myPage/recipeUpdate.do":
			command = new SelectCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_updateform.jsp";
			break;
		case "/recipeUpdateOk.do":
		case "/myPage/recipeUpdateOk.do":	
			command = new UpdateCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_update.jsp";
			break;
		//글 삭제 	
		case "/recipeDelete.do":
		case "/myPage/recipeDelete.do":		
			command = new DeleteCommand();
			command.execute(request, response);
			viewPage = "/recipe_board/recipe_delete.jsp";
			break;
		
		//마이페이지 
		case "/myPage/myRecipeList.do":
			command = new MyRecipeCommand();
			command.execute(request, response);
			viewPage = "/myPage/myrecipe_list.jsp";
			break;
		case "/myPage/myRecipeListOrder.do":
			command = new MyRecipeCommand();
			command.execute(request, response);
			viewPage = "/myPage/myrecipe_list_order.jsp";
			break;
		case "/myPage/myRecipeLike.do":
			command = new MyRecipeLikeCommand();
			command.execute(request, response);
			viewPage = "/myPage/myrecipe_like.jsp";
			break;
		case "/myPage/myRecipeLikeOrder.do":
			command = new MyRecipeLikeCommand();
			command.execute(request, response);
			viewPage = "/myPage/myrecipe_like_order.jsp";
			break;		
		case "/myPage/myRecipeView.do":
			command = new MyReadCommand();
			command.execute(request, response);
			viewPage = "/myPage/myrecipe_view.jsp";
			break;
			
		}

		// view page로 forward
		if (viewPage != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}

}
