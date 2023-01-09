package teamProject2;

public class test {

	public static void main(String[] args) {
		Dao dao = Dao.getInstance();
		String a = "testdd";
		MemberInfo mi = new MemberInfo(a);
		System.out.println(dao.memberSignUpIdCheck(mi));
	}

}
