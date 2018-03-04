package com.db;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DiaryDataBean {
	private int num; // 일기 고유번호
	private String email; // 회원 아이디 (회원마다 일기쓸수있게 받아 옴.)
	private String diaryid; // 일기장 고유 명 (일기장 리스트) 
	private String subject; // 제목
//	private String cdate;
	private Date cdate; // 날짜
	private String content; // 내용
	private String ip; // 아이피
	private String filename; // 파일이름
	private int filesize; // 파일크기
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
	public String getDiaryid() {
		return diaryid;
	}
	public void setDiaryid(String diaryid) {
		this.diaryid = diaryid;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	/*public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}*/
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public void setCdate(String cdate) throws ParseException {
	    DateFormat df = new SimpleDateFormat("dd-MM-yyyy"); 
	    this.cdate = df.parse(cdate);  
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	@Override
	public String toString() {
		return "DiaryDataBean [num=" + num + ", email=" + email + ", diaryid=" + diaryid + ", subject=" + subject
				+ ", cdate=" + cdate + ", content=" + content + ", ip=" + ip + ", filename=" + filename + ", filesize="
				+ filesize + "]";
	}
	
	
	
	
	
	
	
	
	
}
