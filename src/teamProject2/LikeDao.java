package teamProject2;

import java.io.FileReader;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.cook.model.Recipe;

public class LikeDao {
	private static LikeDao dao = new LikeDao(); 
	private LikeDao() {}
	public static LikeDao getInstance() {
		return dao;	
	}

	private Connection conn = getConnect();
	
	private Connection getConnect() {

		try {
			Properties prop = new Properties();
			String path = Dao.class.getResource("db.properties").getPath();
			path = URLDecoder.decode(path, "utf-8");

			prop.load(new FileReader(path));
			String driver = prop.getProperty("driver");

			Class.forName(driver);
			String url = prop.getProperty("url");
			String user = prop.getProperty("user");
			String pw = prop.getProperty("pw");

			Connection conn = DriverManager.getConnection(url, user, pw);
			return conn;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
	//맛집 좋아요수 user_id로 카운트
	 public String resLike(String user_id ){
		      String sql = "select count(*) as cnt , to_char(sysdate,'yyyy-mm-dd') as likedDate  from res_liked where user_id = ?";
		  		String res = null;
		  		try {
		  			PreparedStatement pstm = conn.prepareStatement(sql);
		  			pstm.setString(1, user_id);
		  			ResultSet rs = pstm.executeQuery();
		  			if (rs.next()) {
		  				String likedDate = rs.getString("entry_date");
		  			res = likedDate;

		  			}
		  			rs.close();
		  			pstm.close();
		  			return res;

		  		} catch (SQLException e) {
		  			// TODO Auto-generated catch block
		  			e.printStackTrace();
		  		}

		  		return null;

	}
	 
	 //레시피 좋아요수 user_id로 카운트
	 public String recLike(String user_id) {
		  String rec =  null;
		    try {
		      String sql = "select count(*) as cnt , to_char(sysdate,'yyyy-mm-dd') as entry_date from rec_liked where user_id = ? ";
		      PreparedStatement pstm = conn.prepareStatement(sql);
		      ResultSet rs = pstm.executeQuery();
		      
		      if (rs.next()) {
	  				String likedDate = rs.getString("entry_date");
	  			rec = likedDate;

	  			}
		      
	  			rs.close();
	  			pstm.close();
	  			return rec;
		      
		    } catch (SQLException e) {
		    	// TODO Auto-generated catch block
				e.printStackTrace();
		    }
			return null;
		  }

	
	 
	// DEL REC	
	public int DeleteRec(RecLike rec) {
			String sql ="DELETE FROM rec_liked WHERE USER_ID = ? AND REC_NUM = ?";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, rec.getUserid());
				pstm.setInt(2, rec.getRecnum());
				int res = pstm.executeUpdate();
				pstm.close();
				return res;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return 0;
	}
	
	
	
	// DEL RES	
	public int DeleteRES(ResLike res) {
			String sql ="DELETE FROM RES_LIKED WHERE USER_ID = ? AND  RES_NUM = ?";
			try {
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, res.getUserid());
				pstm.setInt(2, res.getResnum());
				
				int no = pstm.executeUpdate();
				pstm.close();
				return no;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return 0;
		}
	
	//레시피 게시글 삭제시, 해당 글 좋아요 모두 삭제
	public int DeleteRecAll(int rec_num) {
		int result = 0;
		String sql = "DELETE FROM rec_liked WHERE rec_num = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rec_num);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			closeAll(pstmt);
		}
		return result;
	}
	
	
	//insert ResLike
	public int InsertRes(ResLike res) {
		String sql = "insert into RES_LIKED(no, user_id, res_num, liked_Date)"
					+ "values (RESLIKE_SEQ.NEXTVAL,?,?,to_char(sysdate,'yyyy/mm/dd'))";
	
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
	
			pstm.setString(1, res.getUserid());
			pstm.setInt(2, res.getResnum());
			
			int no = pstm.executeUpdate();
			pstm.close();
			return no;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	//insert RecipeLike
	public int InsertRec(RecLike rec) {
		
		String sql = "insert into rec_liked(no,user_id, rec_num, liked_Date)"
					+ "values (RECLIKE_SEQ.NEXTVAL,?,?,to_char(sysdate,'yyyy/mm/dd'))";

		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setString(1, rec.getUserid());
			pstm.setInt(2, rec.getRecnum());
			int no = pstm.executeUpdate();
			pstm.close();
			return no;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	
	//해당 글 좋아요 누른 적 있나, 좋아요 DB검색 
	public RecLike searchRecLike(String login_id, int rec_num) {
		ResultSet rs = null;
		PreparedStatement pstm = null;
		RecLike reclike = null;
		String sql = "select * from rec_liked where user_id=? and rec_num=?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1,login_id);
			pstm.setInt(2, rec_num);
			rs = pstm.executeQuery();
			if (rs.next()) {
				String user_id = rs.getString("user_id");
				reclike = new RecLike(user_id, rec_num);
			}
		pstm.close();
		return reclike;	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reclike;
	}
	
	

	// 로그인 userid로 recnum 리턴해주기
	public int SearchLike(String user_id) {
		  int rec = 0;
		  String sql = "SELECT rec_num "
		      		+ "FROM rec_liked "
		      		+ "WHERE USER_ID =?";
		  try {
		      PreparedStatement pstm = conn.prepareStatement(sql);
		      ResultSet rs = pstm.executeQuery();
		      
		      if (rs.next()) {
	  				int recnum = rs.getInt("rec_num");
	  				rec = recnum;
	  			}
		      
	  			rs.close();
	  			pstm.close();
	  			return rec;
		      
		    } catch (SQLException e) {
		    	// TODO Auto-generated catch block
				e.printStackTrace();
		    }
			return 0;
		  }
	
	
	public List<Recipe> recLst;
	// 좋아요 한 레시피 게시글 목록  (기본정렬 최신순)
	public List<Recipe> myLike(String userId) {
		List<Recipe> searchedLst = new ArrayList<>();
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement("select * from recipe_board where rec_num in (select rec_num from REC_LIKED where user_id=?) order by rec_num desc");
				pstmt.setString(1, userId); 
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
				return searchedLst;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeAll(pstmt);
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

}
