package com.db;

import java.util.Date;

public class UserDataBean {
	private int num;
	private String email; //회원 이메일 (아이디)
	private String name;  //회원 이름
	private String pwd;   //회원 비밀번호
	private String tel; //회원 연락처
	private String birth; //회원 생일
	private Date cdate;	//회원 생성 날짜
	private String ip; //회원 아이피
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	@Override
	public String toString() {
		return "UserDataBean [num=" + num + ", email=" + email + ", name=" + name + ", pwd=" + pwd + ", tel=" + tel
				+ ", birth=" + birth + ", cdate=" + cdate + ", ip=" + ip + "]";
	}
	
	
	
	
	
	
	
	
	
	
}
