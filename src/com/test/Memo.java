package com.test;

import java.io.File;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.db.DiaryDBBean;
import com.db.UserDBBean;
import com.db.UserDataBean;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class Memo {

		// ���� ����
	/*// 6) fileSave ���� webcontent���� �ȿ� �����
		String realFolder = ""; // �� ���ø����̼ǻ��� ������
		String encType = "euc-kr"; // ���ڵ� Ÿ��
		int maxSize = 5 * 1024 * 1024; // �ִ� ���ε� �� ���� ũ�� .. 5MB
		ServletContext context = req.getServletContext();
		realFolder = context.getRealPath("fileSave");
		MultipartRequest multi = null;

		// DefaultFileRenamePolicy�� �ߺ��� ���� ���ε��Ҷ� �ڵ����� Rename / aaa������ aaa(1)��
		multi = new MultipartRequest(req, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		Enumeration files = multi.getFileNames();
		String[] original = new String[5];;
		String[] type = new String[5];;
		String[] filename = new String[5];
		File[] file = new File[5];
		int index=0;
		
		// 7) 
		while (files.hasMoreElements()) { // ���� ������ �ټ��� if�� while��..
			String name = (String) files.nextElement();
			filename[index] = multi.getFilesystemName(name); // DefaultFileRenamePolicy ����
			original[index] = multi.getOriginalFileName(name); // ���� ���� �̸� (�߰��ص��ǰ�, ���ص�..?)
			type[index] = multi.getContentType(name); // ���� Ÿ�� (�߰��ص��ǰ�, ���ص�..?)
			file[index] = multi.getFile(name);
			index++;
		}*/
	
	// ������. (���� ���� ����)
	/*public String songInsert(HttpServletRequest req, HttpServletResponse res) throws Throwable {

		String realFolder = "";
		String encType = "utf-8";
		int maxSize = 10 * 1024 * 1024;
		ServletContext context = req.getServletContext();
		realFolder = context.getRealPath("songSave");
		MultipartRequest multi = null;
		multi = new MultipartRequest(req, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		String[] filename = new String[2];
		File[] file = new File[2];
		int index = 0;

		String[] original = new String[2];
		String[] type = new String[2];

		while (files.hasMoreElements()) {
			String name = (String) files.nextElement();
			filename[index] = multi.getFilesystemName(name);
			original[index] = multi.getOriginalFileName(name);
			type[index] = multi.getContentType(name);
			file[index] = multi.getFile(name);
			index++;

		}

		SongDataBean song = new SongDataBean();

		if (req.getParameter("snum") != null && !req.getParameter("snum").equals("")) {
			song.setSnum(Integer.parseInt(req.getParameter("snum")));
		}

		song.setSboardid(multi.getParameter("sboardid"));
		song.setStitle(multi.getParameter("stitle"));
		song.setGenre(multi.getParameter("genre"));
		song.setSbio(multi.getParameter("sbio"));

		SongDBBean dbPro = SongDBBean.getInstance();

		String ctype = ".jpg";

		if (filename[0] != null) {
			ctype = filename[0].substring(filename[0].indexOf(".") + 1);
		}

		int chk = 0;

		if (!(ctype.equals("jpg") || ctype.equals("jpeg") || ctype.equals("png") || ctype.equals("gif"))) {
			chk = 1;
			req.setAttribute("chk", chk);
			return "/song/typechk.jsp";
		}

		System.out.println(chk);
		String stype = filename[1].substring(filename[1].indexOf(".") + 1);
		if (!(stype.equals("mp3") || stype.equals("mp4") || stype.equals("wav"))) {
			chk = -1;
			req.setAttribute("chk", chk);
			return "/song/typechk.jsp";
		}

		if (file[0] != null) {

			song.setCfilename(filename[0]);
			song.setCfilesize((int) file[0].length());

		} else {
			song.setCfilename("");
			song.setCfilesize(0);

		}

		song.setSfilename(filename[1]);
		song.setSfilesize((int) file[1].length());

		System.out.println(song);

		dbPro.insertSong(song);
		req.setAttribute("chk", chk);
		req.setAttribute("sboardid", song.getSboardid());

		return "/song/typechk.jsp";

	}*/
		
		
		
		
		// ���� ����.
		/*
		// =================================================
		
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
*/
	
}
	