package teamProject2;

public class MemberInfo {
private String userId;
private String password;
private String name;

public MemberInfo(String userId, String password, String name) {
	super();
	this.userId = userId;
	this.password = password;
	this.name = name;
}

public MemberInfo(String userId) {
	super();
	this.userId = userId;
}

public String getUserId() {
	return userId;
}
public void setUserId(String userId) {
	this.userId = userId;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}


}
