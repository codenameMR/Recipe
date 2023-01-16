package com.cook.model;

public class Recipe {
			private int  rec_num;
			private String user_id;
			private String rec_title;
			private String rec_content;
			private String rec_date;
			private int rec_views;
			private int rec_likes;
			private String rec_category;
			private String rec_pic1;
			private String rec_pic2;
			private String rec_pic3;
			

			public Recipe() {}
			public Recipe(int rec_num, String user_id, String rec_title, String rec_content, String rec_date,
					int rec_views, int rec_likes, String rec_category) {
				this.rec_num = rec_num;
				this.user_id = user_id;
				this.rec_title = rec_title;
				this.rec_content = rec_content;
				this.rec_date = rec_date;
				this.rec_views = rec_views;
				this.rec_likes = rec_likes;
				this.rec_category = rec_category;
			}
			public Recipe(int rec_num, String user_id, String rec_title, String rec_content, String rec_date,
					int rec_views, int rec_likes, String rec_category, String rec_pic1, String rec_pic2,
					String rec_pic3) {
				this(rec_num,user_id,rec_title, rec_content, rec_date,rec_views,
						rec_likes,rec_category);
				this.rec_pic1 = rec_pic1;
				this.rec_pic2 = rec_pic2;
				this.rec_pic3 = rec_pic3;
			}

			public int getRec_num() {
				return rec_num;
			}

			public String getUser_id() {
				return user_id;
			}

			public String getRec_title() {
				return rec_title;
			}

			public String getRec_content() {
				return rec_content;
			}

			public String getRec_date() {
				return rec_date;
			}

			public int getRec_views() {
				return rec_views;
			}

			public int getRec_likes() {
				return rec_likes;
			}

			public String getRec_category() {
				return rec_category;
			}

			public void setRec_num(int rec_num) {
				this.rec_num = rec_num;
			}

			public void setUser_id(String user_id) {
				this.user_id = user_id;
			}

			public void setRec_title(String rec_title) {
				this.rec_title = rec_title;
			}

			public void setRec_content(String rec_content) {
				this.rec_content = rec_content;
			}

			public void setRec_date(String rec_date) {
				this.rec_date = rec_date;
			}

			public void setRec_views(int rec_views) {
				this.rec_views = rec_views;
			}

			public void setRec_likes(int rec_likes) {
				this.rec_likes = rec_likes;
			}

			public void setRec_category(String rec_category) {
				this.rec_category = rec_category;
			}
			
			public String getRec_pic1() {
				return rec_pic1;
			}
			public void setRec_pic1(String rec_pic1) {
				this.rec_pic1 = rec_pic1;
			}
			public String getRec_pic2() {
				return rec_pic2;
			}
			public void setRec_pic2(String rec_pic2) {
				this.rec_pic2 = rec_pic2;
			}
			public String getRec_pic3() {
				return rec_pic3;
			}
			public void setRec_pic3(String rec_pic3) {
				this.rec_pic3 = rec_pic3;
			}
			@Override
			public String toString() {
				return "RecipeBoard [rec_num=" + rec_num + ", user_id=" + user_id + ", rec_title=" + rec_title
						+ ", rec_content=" + rec_content + ", rec_date=" + rec_date + ", rec_views=" + rec_views
						+ ", rec_likes=" + rec_likes + ", rec_category=" + rec_category + "]";
			}
			
			
		
}
