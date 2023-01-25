package teamProject2;

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
import java.util.Properties;


public class Dao {
	private static Dao dao = new Dao();

	private Dao() {
	}

	public static Dao getInstance() {
		return dao;
	}

	private Connection conn = getConnect();

	private Connection getConnect() {
		try {
			Properties prop = new Properties();
			String path = Dao.class.getResource("db.properties").getPath(); // .class가 있는 위치에 db.properties파일을 가져와서
			path = URLDecoder.decode(path, "utf-8");// utf-8 형식으로 바꿔준다음
			prop.load(new FileReader(path));// fileReader로 값을 읽어오고 아래 형식으로 뿌려준다.
			String driver = prop.getProperty("driver");
			Class.forName(driver);
			String url = prop.getProperty("url");
			String user = prop.getProperty("user");
			String pw = prop.getProperty("pw");
			conn = DriverManager.getConnection(url, user, pw);
			return conn;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public int memberSignUp(MemberInfo mi) {
		String sql = "INSERT INTO MEMBER_INFO (USER_ID, NAME, PASSWORD) "
				+ "VALUES (?, ?, ?)";
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, mi.getUserId());
			psmt.setString(2, mi.getPassword());
			psmt.setString(3, mi.getName());
			
			int res = psmt.executeUpdate();
			psmt.close();
			System.out.println(res);
			return res;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int memberSignUpIdCheck(MemberInfo mi) {
		String sql = "SELECT COUNT(*) FROM MEMBER_INFO WHERE USER_ID = ?";
		int userId = 0;
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, mi.getUserId());
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				userId = rs.getInt(1);
			}
			psmt.close();
			return userId;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
		
	}
	
	public String memberSignInCheck(MemberInfo mi) {
		String sql = "SELECT PASSWORD FROM MEMBER_INFO WHERE USER_ID = ?";
		String userPassword = null;
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, mi.getUserId());
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				userPassword = rs.getString(1);
			}
			psmt.close();
			return userPassword;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	public String[] memberMyPage(MemberInfo mi) {
		String sql = "SELECT * FROM MEMBER_INFO WHERE USER_ID = ?";
		String[] userInfo = new String[3];
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, mi.getUserId());
			ResultSet rs = psmt.executeQuery();
			while(rs.next()) {
				userInfo[0] = rs.getString(1);
				userInfo[1] = rs.getString(2);
				userInfo[2] = rs.getString(3);
			}
			psmt.close();
			return userInfo;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	public int updatePassword(MemberInfo mi) {
		String sql = "UPDATE MEMBER_INFO SET PASSWORD = ? WHERE USER_ID = ?";
		int result = 0;
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, mi.getPassword());
			psmt.setString(2, mi.getUserId());
			result = psmt.executeUpdate();
//			ResultSet rs = psmt.executeQuery();
//			if(rs.next()) {
//				result = rs.getInt(1);
//			}
			psmt.close();
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	public int withdrawal(String userId) {
		String sql = "DELETE FROM MEMBER_INFO WHERE USER_ID = ?";
		int result = 0;
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			result = psmt.executeUpdate();
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
