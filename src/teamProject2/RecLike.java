package teamProject2;

public class RecLike {
	public int no;
	private String userid;
	private int recnum;
	public String likedDate;
	
	public RecLike(String userid, int recnum) {
		super();
		this.userid = userid;
		this.recnum = recnum;
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
	public int getRecnum() {
		return recnum;
	}
	public void setRecnum(int recnum) {
		this.recnum = recnum;
	}
	public String getLikedDate() {
		return likedDate;
	}
	public void setLikedDate(String likedDate) {
		this.likedDate = likedDate;
	}
		
}