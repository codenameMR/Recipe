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
}
