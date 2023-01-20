package teamProject2;

import java.io.FileReader;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		
		String sql = "insert into rec_liked(no,user_id, res_num, liked_Date)"
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

	
	//좋아요 누른 적 있나, 좋아요 DB검색 
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

}
