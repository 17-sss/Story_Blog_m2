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

public class Test_single {
	/*public String user_writePro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
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
		String filename = "";
		File file = null;
		
		// 7) 
		if (files.hasMoreElements()) { // ���� ������ �ټ��� if�� while��..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy ����
			String original = multi.getOriginalFileName(name); // ���� ���� �̸� (�߰��ص��ǰ�, ���ص�..?)
			String type = multi.getContentType(name); // ���� Ÿ�� (�߰��ص��ǰ�, ���ص�..?)
			file = multi.getFile(name);
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
		if (file != null) {
			diary.setFilename(filename);
			diary.setFilesize((int) file.length());
		} else {
			diary.setFilename(" ");
			diary.setFilesize(0);
		}
		// =================================================
		
		System.out.println(diary);
		//9) insertDiary �޼ҵ� ���� 
		dbPro.insertDiary(diary);
		
		req.setAttribute("pageNum", pageNum);
		res.sendRedirect("user_main?pageNum="+pageNum+"&diaryid="+diaryid);
		
		return null;
	}*/
}
