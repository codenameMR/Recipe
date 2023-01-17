package teamProject2;

public class ResLike {

	public int no;
	private String userid;
	private int resnum;
	public String likedDate;
	
	
	public ResLike(String userid, int resnum) {
		super();
		this.userid = userid;
		this.resnum = resnum;
	}
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getResnum() {
		return resnum;
	}
	public void setResnum(int resnum) {
		this.resnum = resnum;
	}
	public String getLikedDate() {
		return likedDate;
	}
	public void setLikedDate(String likedDate) {
		this.likedDate = likedDate;
	}
	
}
	