package com.db;

import java.util.Date;

public class DiaryDataBean {
	private int num; // 일기 고유번호
	private String diaryid; // 일기장 번호(일기장 리스트) 
	private String subject; // 제목
	private Date reg_date; // 날짜
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
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
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
		return "DiaryDataBean [num=" + num + ", diaryid=" + diaryid + ", subject=" + subject + ", reg_date=" + reg_date
				+ ", content=" + content + ", ip=" + ip + ", filename=" + filename + ", filesize=" + filesize + "]";
	}
	
	
	
	
	
}
