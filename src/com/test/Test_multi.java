package com.test;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.db.DiaryDBBean;
import com.db.DiaryDataBean;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class Test_multi {
	public String user_write(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		String subject = req.getParameter("subject");
	    System.out.println("����:"+subject);
	    
	    int num=0;
		String diaryid = req.getParameter("diaryid");
		
		if (diaryid==null) diaryid = "Main";
		if (subject==null) subject = "�������";

		if (req.getParameter("num")!=null) {num = Integer.parseInt(req.getParameter("num"));}
		
		req.setAttribute("diaryid", diaryid);
		req.setAttribute("subject", subject);
		
		return  "/Project/view/user_write.jsp"; 
	}
	
	// ���� - �ϱ� ���� �� ����
	public String user_writePro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		DiaryDataBean diary = new DiaryDataBean();
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		
		// 6) fileSave ���� webcontent���� �ȿ� �����
		String realFolder = ""; // �� ���ø����̼ǻ��� ������
		String encType = "euc-kr"; // ���ڵ� Ÿ��
		int maxSize = 5 * 1024 * 1024; // �ִ� ���ε� �� ���� ũ�� .. 5MB
		ServletContext context = req.getServletContext();
		realFolder = context.getRealPath("fileSave");
		MultipartRequest multi = null;

		// DefaultFileRenamePolicy�� �ߺ��� ���� ���ε��Ҷ� �ڵ����� Rename / aaa������ aaa(1)��
		multi = new MultipartRequest(req, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		Enumeration files = multi.getFileNames();
		String[] filename = new String[5];
		File[] file = new File[5];
		int index = 0;
		
		String[] original = new String[5];
		String[] type = new String[5];
		
		// 7) 
		while (files.hasMoreElements()) { // ���� ������ �ټ��� if�� while��..
			String name = (String) files.nextElement();
			filename[index] = multi.getFilesystemName(name);
			original[index] = multi.getOriginalFileName(name);
			type[index] = multi.getContentType(name);
			file[index] = multi.getFile(name);
			index++;
		}
		// =================================================
		
		String pageNum = multi.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		
		String diaryid = multi.getParameter("diaryid");
		if (diaryid==null) diaryid = "Main";
		
		//diary.setNum(num);
		diary.setEmail((String)session.getAttribute("sessionID")); 
		diary.setSubject(multi.getParameter("subject"));
		diary.setContent(multi.getParameter("content"));
		diary.setDiaryid(multi.getParameter("diaryid"));
		diary.setIp(req.getRemoteAddr());
		
		// 8)
		if (file[4] != null) {
			diary.setFilename0(filename[4]);
			diary.setFilesize0((int) file[4].length()); 
			
		} 
		
		if (file[3] != null) {
			diary.setFilename1(filename[3]);
			diary.setFilesize1((int) file[3].length()); 
			
		} 
		
		if (file[2] != null) {
			diary.setFilename2(filename[2]);
			diary.setFilesize2((int) file[2].length()); 
			
		}
		
		if (file[1] != null) {
			diary.setFilename3(filename[1]);
			diary.setFilesize3((int) file[1].length()); 
			
		} 
		
		if (file[0] != null) {
			diary.setFilename4(filename[0]);
			diary.setFilesize4((int) file[0].length()); 
			
		} else {}
			
		
	
		
		// =================================================
		
		System.out.println(diary);
		//9) insertDiary �޼ҵ� ���� (���� ���� �ҽ� �ʼ� ����)
		dbPro.insertDiary(diary);
		
		req.setAttribute("pageNum", pageNum);
		res.sendRedirect("user_main?pageNum="+pageNum+"&diaryid="+diaryid);
		
		return null;
	}
	
	/* ��������. - (DiaryDBBean) insertDiary
	 *  sql = "insert into diary(num, email, diaryid, subject, cdate, content, ip, filename0, filesize0, filename1, filesize1,";
			sql += "filename2, filesize2,filename3, filesize3,filename4, filesize4)";
			sql += "values(?,?,?,?,sysdate,?,?,?,?,?,?,?,?,?,?,?,?)"; //+ filename, filesize �߰� / ? �߰� ( ���� ���� ���ε� )
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, diary.getEmail()); // !!
			pstmt.setString(3, diary.getDiaryid());
			pstmt.setString(4, diary.getSubject());
			pstmt.setString(5, diary.getContent());
			pstmt.setString(6, diary.getIp());
			pstmt.setString(7, diary.getFilename0()); //+
			pstmt.setInt(8, diary.getFilesize0()); //+
			pstmt.setString(9, diary.getFilename1()); //+
			pstmt.setInt(10, diary.getFilesize1()); //+
			pstmt.setString(11, diary.getFilename2()); //+
			pstmt.setInt(12, diary.getFilesize2()); //+
			pstmt.setString(13, diary.getFilename3()); //+
			pstmt.setInt(14, diary.getFilesize3()); //+
			pstmt.setString(15, diary.getFilename4()); //+
			pstmt.setInt(16, diary.getFilesize4()); //+
	 */
}
