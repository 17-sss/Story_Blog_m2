package com.db;

import java.util.Date;

public class UserDataBean {
	private String email; //ȸ�� �̸��� (���̵�)
	private String name;  //ȸ�� �̸�
	private String pwd;   //ȸ�� ��й�ȣ
	private String tel; //ȸ�� ����ó
	private String birth; //ȸ�� ����
	private Date cdate;	//ȸ�� ���� ��¥
	private String ip; //ȸ�� ������
	
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
		return "UserDataBean [email=" + email + ", name=" + name + ", pwd=" + pwd + ", tel=" + tel + ", birth=" + birth
				+ ", cdate=" + cdate + ", ip=" + ip + "]";
	}
	
	
	
	
	
	
	
	
	
}
