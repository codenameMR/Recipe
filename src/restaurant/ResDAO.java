package restaurant;

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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class ResDAO {
	//singleton
	private static ResDAO instance = new ResDAO();

	private ResDAO() {
	}

	public static ResDAO getInstance() {
		return instance;
	}

	//connection
	private Connection conn = getConnect();

	private Connection getConnect() {
		try {
			Properties prop = new Properties();
			String path = ResDAO.class.getResource("db.properties").getPath();
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

	//글 목록
	public List<Restaurant> selectAll() {
		List<Restaurant> res_list = new ArrayList<>();
		Statement stmt;
		try {
			stmt = conn.createStatement();
			String sqlCount = "SELECT COUNT(*) FROM restaurant";// DB내의 자료개수를 찾는 SQL문
			ResultSet rs = stmt.executeQuery(sqlCount);// DB실행

			String sqlList = "SELECT * from restaurant order by res_num desc";
			rs = stmt.executeQuery(sqlList); // DB실행
			while (rs.next()) {
				int res_num = rs.getInt("res_num");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String date = rs.getString("date_2");
				int views = rs.getInt("views");
				int likes = rs.getInt("likes");
				String picture1 = rs.getString("picture1");
				String picture2 = rs.getString("picture2");
				String picture3 = rs.getString("picture3");
	 			String loc = rs.getString("loc");
				Restaurant restaurant = new Restaurant(res_num, user_id, title, content, date, views, likes, picture1,
						picture2, picture3, loc);
				res_list.add(restaurant);
			}

			rs.close();// rs객체 반환
			stmt.close();// stmt객체 반환
			return res_list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res_list;
	}

	//글 내용 보기
	   public Restaurant view(int res_num) throws SQLException {
	      Restaurant restaurant = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String COUNTUP =
	            "UPDATE restaurant SET views = views + 1 WHERE res_num = ?";
	      
	      String SELECT_BY_RES_NUM =
	            "SELECT * FROM restaurant WHERE res_num = ? ";
	      
	      try {
	         conn.setAutoCommit(false);
	        
	         pstmt = conn.prepareStatement(COUNTUP);
	         pstmt.setInt(1, res_num);
	         pstmt.executeUpdate();
	         pstmt.close(); 
	         
	         pstmt = conn.prepareStatement(SELECT_BY_RES_NUM);
	         pstmt.setInt(1, res_num);
	         rs = pstmt.executeQuery();
	         if (rs.next()) {
	            String user_id = rs.getString("user_id");
	            String title= rs.getString("title");
	            String content= rs.getString("content");
	            String date_2= rs.getString("date_2");
	            int views = rs.getInt("views");
	            int likes = rs.getInt("likes");
	            String picture1= rs.getString("picture1");
	            String picture2= rs.getString("picture2");
	            String picture3= rs.getString("picture3");
	            String loc= rs.getString("loc");
	            restaurant = new Restaurant(res_num, user_id, title, content, date_2, views, likes, picture1, picture2, picture3, loc);
	         }
	         conn.commit();
	      } catch (SQLException e) {
	         conn.rollback();
	         throw e;
	      } finally {
	    	 pstmt.close();
	    	 rs.close();
	      }   
	      return restaurant;
	   }
	
	
	
	//글 작성
	public int insertRes(Restaurant restaurant) {
		int result = 0;
		ResultSet rs = null;
		try {
			String sql = "INSERT INTO restaurant(res_num, user_id, title, content, loc ,picture1, picture2, picture3) "
					+ "VALUES(restaurant_seq.NEXTVAL,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, restaurant.getUser_id());
			pstmt.setString(2, restaurant.getTitle());
			pstmt.setString(3, restaurant.getContent());
			pstmt.setString(4, restaurant.getLoc());
			pstmt.setString(5, restaurant.getPicture1());
			pstmt.setString(6, restaurant.getPicture2());
			pstmt.setString(7, restaurant.getPicture3());

			result = pstmt.executeUpdate();
			pstmt.close();
			return result;

		} catch (SQLException e) {
		
		}
		return result;
	}
	
	//글 수정
	public int updateRes(String title, String content, String picture1, String picture2, String picture3, String loc, int res_num) {
		int result = 0;
		PreparedStatement pstmt=null;
		try {
		String sql="UPDATE restaurant SET title=?, content=?, picture1=?, "
				+ "picture2=?, picture3=?, loc=? WHERE res_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, picture1);
			pstmt.setString(4, picture2);
			pstmt.setString(5, picture3);
			pstmt.setString(6, loc);
			pstmt.setInt(7, res_num);
			
			return pstmt.executeUpdate();				
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
		

	//글 삭제
	public int deleteRes(int res_num) {
		int result = 0;
		ResultSet rs = null;
		try {
			String sql = "delete from restaurant where res_num=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, res_num);

			result = pstmt.executeUpdate();
			pstmt.close();
			return result;

		} catch (SQLException e) {
		
		}
		return result;
	}

}
	
	
