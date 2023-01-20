package restaurant;


public class Restaurant {
		private int res_num;
		private String user_id;
		private String title;
		private String content;
		private String date;
		private int views;
		private int likes;
		private String picture1;
		private String picture2;
		private String picture3;
		private String loc;
		
		public Restaurant() {
			
		}

		public Restaurant(int res_num, int views) {
			super();
			this.res_num = res_num;
			this.views = views;
		}

		public Restaurant(int res_num) {
			this.res_num=res_num;
		}
		
		public Restaurant(String title, String content, String loc) {
			super();
			this.title = title;
			this.content = content;
			this.loc = loc;
		}

		public Restaurant(int res_num, String user_id, String title, String content, String date, int views, int likes,
				String picture1, String picture2, String picture3, String loc) {
			super();
			this.res_num = res_num;
			this.user_id = user_id;
			this.title = title;
			this.content = content;
			this.date = date;
			this.views = views;
			this.likes = likes;
			this.picture1 = picture1;
			this.picture2 = picture2;
			this.picture3 = picture3;
			this.loc = loc;
		}
		
		public Restaurant(String user_id, String title, String content, String picture1, String picture2,
				String picture3, String loc) {
			super();
			this.user_id = user_id;
			this.title = title;
			this.content = content;
			this.picture1 = picture1;
			this.picture2 = picture2;
			this.picture3 = picture3;
			this.loc = loc;
		}

		public Restaurant(int res_num, String title, String content, String picture1, String picture2, String picture3,
				String loc) {
			super();
			this.res_num = res_num;
			this.title = title;
			this.content = content;
			this.picture1 = picture1;
			this.picture2 = picture2;
			this.picture3 = picture3;
			this.loc = loc;
		}

		public Restaurant(String title, String content, String picture1, String picture2, String picture3, String loc) {
			super();
			this.title = title;
			this.content = content;
			this.picture1 = picture1;
			this.picture2 = picture2;
			this.picture3 = picture3;
			this.loc = loc;
		}

		public Restaurant(String user_id, String title, String content, String date, int views,
				String picture1, String picture2, String picture3, String loc) {
			super();
			this.user_id = user_id;
			this.title = title;
			this.content = content;
			this.date = date;
			this.views = views;
			this.picture1 = picture1;
			this.picture2 = picture2;
			this.picture3 = picture3;
			this.loc = loc;
		}

		public int getRes_num() {
			return res_num;
		}
		public void setRes_num(int res_num) {
			this.res_num = res_num;
		}
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public int getViews() {
			return views;
		}
		public void setViews(int views) {
			this.views = views;
		}
		public int getLikes() {
			return likes;
		}
		public void setLikes(int likes) {
			this.likes = likes;
		}
		public String getPicture1() {
			return picture1;
		}
		public void setPicture1(String picture1) {
			this.picture1 = picture1;
		}
		public String getPicture2() {
			return picture2;
		}
		public void setPicture2(String picture2) {
			this.picture2 = picture2;
		}
		public String getPicture3() {
			return picture3;
		}
		public void setPicture3(String picture3) {
			this.picture3 = picture3;
		}
		public String getLoc() {
			return loc;
		}
		public void setLoc(String loc) {
			this.loc = loc;
		}
		@Override
		public String toString() {
			return "restaurant [res_num=" + res_num + ", user_id=" + user_id + ", title=" + title + ", content="
					+ content + ", date=" + date + ", views=" + views + ", likes=" + likes + ", picture1=" + picture1
					+ ", picture2=" + picture2 + ", picture3=" + picture3 + ", loc=" + loc + "]";
		}
		
}