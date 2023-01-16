package com.cook.model;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Properties;

public class RecipeDAO {
	// singleton
	private static RecipeDAO instance = new RecipeDAO();
	private RecipeDAO() {}
	public static RecipeDAO getInstance() {
		return instance;
	}
	
	public List<Recipe> recLst;
	
	// connection
	private Connection conn = getConnect();
	private Connection getConnect() {
		try {
			Properties prop = new Properties();
			String path = RecipeDAO.class.getResource("db.properties").getPath();
			path = URLDecoder.decode(path, "utf-8");
			prop.load(new FileReader(path));
			String driver = prop.getProperty("driver");
			Class.forName(driver);
			String url = prop.getProperty("url");
			String user = prop.getProperty("user");
			String pw = prop.getProperty("pw");
			Connection conn = DriverManager.getConnection(url, user, pw);
			return conn;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	//pstmt, rs 닫기
	// 메소드 오버로딩
	// closeAll method 1
	public void closeAll(PreparedStatement pstmt) {
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	// closeAll method 2 : rs를 쓰는 경우
	public void closeAll(PreparedStatement pstmt, ResultSet rs) {
		try {
			this.closeAll(pstmt);
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	// 레시피 게시글 등록 
	public int insertRecipeBoard(Recipe newRecipe)  {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rec_num = 0;
		String[] generatedCols = {"rec_num"};
		
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO recipe_board(rec_num, user_id, rec_title, rec_content, rec_category, rec_pic1, rec_pic2, rec_pic3) ");
			sql.append("VALUES (recipe_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)");
			pstmt = conn.prepareStatement(sql.toString(), generatedCols);
			pstmt.setString(1, newRecipe.getUser_id());
			pstmt.setString(2, newRecipe.getRec_title());
			pstmt.setString(3, newRecipe.getRec_content());
			pstmt.setString(4, newRecipe.getRec_category());
			pstmt.setString(5, newRecipe.getRec_pic1());
			pstmt.setString(6, newRecipe.getRec_pic2());
			pstmt.setString(7, newRecipe.getRec_pic3());
			result = pstmt.executeUpdate();
			
			//insert하고 성공하고 난 후에, rec_num을 얻고 recipe에 저장한다.
			//새 게시글 등록하고 난 후에 바로 방금 등록한 글 페이지로 이동하기 위해서
			if (result > 0) {
				rs = pstmt.getGeneratedKeys();
				if (rs.next()) {
					rec_num = rs.getInt(1);
					newRecipe.setRec_num(rec_num);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(pstmt);
		}
		return result;
	}
	
	// 레시피 게시글 목록  (기본정렬 최신순)
	public List<Recipe> selectAllRecipe() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		recLst = new ArrayList<>();
		String sql = "select * from recipe_board order by rec_num desc";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int rec_num = rs.getInt("rec_num");
				String user_id = rs.getString("user_id");
				String rec_title= rs.getString("rec_title");
				String rec_content= rs.getString("rec_content");
				String rec_date= rs.getString("rec_date");
				int rec_views = rs.getInt("rec_views");
				int rec_likes = rs.getInt("rec_likes");
				String rec_category= rs.getString("rec_category");
				String rec_pic1= rs.getString("rec_pic1");
				String rec_pic2= rs.getString("rec_pic2");
				String rec_pic3= rs.getString("rec_pic3");
				Recipe recipe = new Recipe(rec_num, user_id, rec_title, rec_content, rec_date, rec_views, rec_likes, rec_category, rec_pic1, rec_pic2, rec_pic3);
				recLst.add(recipe);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(pstmt, rs);
		}
		return recLst;
	}

	// 레시피 게시글 목록  정렬
	public List<Recipe> selectAllByOrder(int num) {
		List<Recipe>lst2 = new ArrayList<>();
		switch (num) {
		case 0: // 기본 최신순
			return recLst;
		case 1: // 오래된 순
			recLst.stream()
			.sorted(Comparator.comparing(Recipe::getRec_num))
			.forEach(n->lst2.add(n));

			return lst2;
		case 2: // 조회순
			recLst.stream()
			.sorted(Comparator.comparing(Recipe::getRec_views).reversed())
			.forEach(n->lst2.add(n));
			return lst2;
		case 3: // 좋아요순
			recLst.stream()
			.sorted(Comparator.comparing(Recipe::getRec_likes).reversed())
			.forEach(n->lst2.add(n));
			return lst2;
		}
		return lst2;
	}
	
	
	//레시피 게시글 조회(조회수 증가)
	//만약 글을 읽으려 할 때 모종의 이유로 인해 불러와지지 않는 경우 조회수 증가도 되면 안 될 것입니다.
	//따라서 DCL인 commit을 사용해 글이 올바르게 불러와질 때에만 조회수가 증가할 수 있도록 합니다.
	public Recipe readRecipe(int rec_num) throws SQLException {
		Recipe recipe = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//(1) rec_num과 일치하는 레시피의 viwes 값을 기존 값에서 1증가시키는 쿼리
		String UP_VIEWS =
				"UPDATE recipe_board SET rec_views = rec_views + 1 WHERE rec_num = ?";
		//(2)증가이후에 해당 글을 불러오기 위한 쿼리
		String SELECT_BY_REC_NUM =
				"SELECT * FROM recipe_board WHERE rec_num = ? ";
		
		try {
			conn.setAutoCommit(false); //JDBC 사용 시 autoCommit이 true로 되어있기 때문에 setAutoCommit() 메서드를 사용해 false로 설정
			//(1) 쿼리 실행
			pstmt = conn.prepareStatement(UP_VIEWS);
			pstmt.setInt(1, rec_num);
			pstmt.executeUpdate();
			pstmt.close(); //조회수 증가 쿼리를 실행한 뒤, 사용한 pstmt 인스턴스를 close(). pstmt를 이후에 한 번 더 사용해야 하므로 close()는 필수
			
			//(2) 쿼리 실행
			pstmt = conn.prepareStatement(SELECT_BY_REC_NUM);
			pstmt.setInt(1, rec_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String user_id = rs.getString("user_id");
				String rec_title= rs.getString("rec_title");
				String rec_content= rs.getString("rec_content");
				String rec_date= rs.getString("rec_date");
				int rec_views = rs.getInt("rec_views");
				int rec_likes = rs.getInt("rec_likes");
				String rec_category= rs.getString("rec_category");
				String rec_pic1= rs.getString("rec_pic1");
				String rec_pic2= rs.getString("rec_pic2");
				String rec_pic3= rs.getString("rec_pic3");
				recipe = new Recipe(rec_num, user_id, rec_title, rec_content, rec_date, rec_views, rec_likes, rec_category, rec_pic1, rec_pic2, rec_pic3);
			}
			conn.commit();
		} catch (SQLException e) {
			conn.rollback();
			throw e;
		} finally {
			closeAll(pstmt, rs);
		}	
		return recipe;
	}
	
	
	//레시피 게시글 수정시, 기존 내용 불러오기  (조회수 증가x)
	public Recipe selectRecipe(int rec_num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Recipe recipe = null;
		String sql = "select * from recipe_board where rec_num=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rec_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String user_id = rs.getString("user_id");
				String rec_title= rs.getString("rec_title");
				String rec_content= rs.getString("rec_content");
				String rec_date= rs.getString("rec_date");
				int rec_views = rs.getInt("rec_views");
				int rec_likes = rs.getInt("rec_likes");
				String rec_category= rs.getString("rec_category");
				String rec_pic1= rs.getString("rec_pic1");
				String rec_pic2= rs.getString("rec_pic2");
				String rec_pic3= rs.getString("rec_pic3");
				recipe = new Recipe(rec_num, user_id, rec_title, rec_content, rec_date, rec_views, rec_likes, rec_category, rec_pic1, rec_pic2, rec_pic3);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(pstmt, rs);
		}
		return recipe;
	}

	//레시피 게시글 수정
	public int updateRecipe(Recipe recipe)  {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "UPDATE recipe_board SET rec_title=?, rec_content=?, rec_category=?, "
				+ "rec_pic1=?, rec_pic2=?, rec_pic3=? WHERE rec_num =?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, recipe.getRec_title());
			pstmt.setString(2, recipe.getRec_content());
			pstmt.setString(3, recipe.getRec_category());
			pstmt.setString(4, recipe.getRec_pic1());
			pstmt.setString(5, recipe.getRec_pic2());
			pstmt.setString(6, recipe.getRec_pic3());
			pstmt.setInt(7, recipe.getRec_num());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(pstmt);
		}
		return result;
	}
	
	
	//레시피 게시글 삭제
	public int deleteRecipe(int rec_num) {
		int cnt = 0;
		String sql = "DELETE FROM recipe_board WHERE rec_num = ?";
		PreparedStatement pstmt = null; 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rec_num);
			cnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(pstmt);
		}
		return cnt;
	}
	
	//레시피 글 검색 
	public List<Recipe> SearchRecipe(String search_word, String search_class) {
		List<Recipe> searchedLst = new ArrayList<>();
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			if (search_class.equals("rec_title")) {
				pstmt = conn.prepareStatement("SELECT * FROM  recipe_board WHERE rec_title LIKE '%' || ? || '%' order by rec_num desc");
				pstmt.setString(1, search_word); }
			else if (search_class.equals("user_id")) {
				pstmt = conn.prepareStatement("SELECT * FROM  recipe_board WHERE user_id LIKE '%' || ? || '%' order by rec_num desc");
				pstmt.setString(1, search_word);
			} else if (search_class.equals("rec_content")) {
				pstmt = conn.prepareStatement("SELECT * FROM  recipe_board WHERE rec_content LIKE '%' || ? || '%' order by rec_num desc");
				pstmt.setString(1, search_word);
			} else {
				pstmt = conn.prepareStatement("SELECT * FROM  recipe_board WHERE rec_category LIKE '%' || ? || '%' order by rec_num desc");
				pstmt.setString(1, search_word);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int rec_num = rs.getInt("rec_num");
				String user_id = rs.getString("user_id");
				String rec_title= rs.getString("rec_title");
				String rec_content= rs.getString("rec_content");
				String rec_date= rs.getString("rec_date");
				int rec_views = rs.getInt("rec_views");
				int rec_likes = rs.getInt("rec_likes");
				String rec_category= rs.getString("rec_category");
				String rec_pic1= rs.getString("rec_pic1");
				String rec_pic2= rs.getString("rec_pic2");
				String rec_pic3= rs.getString("rec_pic3");
				Recipe recipe = new Recipe(rec_num, user_id, rec_title, rec_content, rec_date, rec_views, rec_likes, rec_category, rec_pic1, rec_pic2, rec_pic3);
				searchedLst.add(recipe);
			}
			recLst = searchedLst;
			return recLst;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(pstmt);
		}
		return null;
	}
	
//	public static void main(String[] args) {
//		RecipeDAO recipeDao = RecipeDAO.getInstance();
//		for (int i = 1; i <= 5; i++) {
//			Recipe recipe = new Recipe(0, "글쓴이" + i, "제목" + i, "내용" + i, null, 0, 0, "한식");
//			recipeDao.insertRecipeBoard(recipe);
//		}
//		for (int i = 6; i <= 10; i++) {
//			Recipe recipe = new Recipe(0, "글쓴이" + i, "제목" + i, "내용" + i, null, 0, 0, "중식");
//			recipeDao.insertRecipeBoard(recipe);
//		}
//		for (int i = 11; i <= 15; i++) {
//			Recipe recipe = new Recipe(0, "글쓴이" + i, "제목" + i, "내용" + i, null, 0, 0, "일식");
//			recipeDao.insertRecipeBoard(recipe);
//		}
//		for (int i = 16; i <= 20; i++) {
//			Recipe recipe = new Recipe(0, "글쓴이" + i, "제목" + i, "내용" + i, null, 0, 0, "양식");
//			recipeDao.insertRecipeBoard(recipe);
//		}
//		for (int i = 21; i <= 25; i++) {
//			Recipe recipe = new Recipe(0, "글쓴이" + i, "제목" + i, "내용" + i, null, 0, 0, "기타");
//			recipeDao.insertRecipeBoard(recipe);
//		}
//		System.out.println("입력완료");
//	}
	
	
	
}
