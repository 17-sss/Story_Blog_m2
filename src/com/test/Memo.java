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

		// 파일 복수
	/*// 6) fileSave 폴더 webcontent폴더 안에 만들기
		String realFolder = ""; // 웹 어플리케이션상의 절대경로
		String encType = "euc-kr"; // 인코딩 타입
		int maxSize = 5 * 1024 * 1024; // 최대 업로드 될 파일 크기 .. 5MB
		ServletContext context = req.getServletContext();
		realFolder = context.getRealPath("fileSave");
		MultipartRequest multi = null;

		// DefaultFileRenamePolicy는 중복된 파일 업로드할때 자동으로 Rename / aaa있으면 aaa(1)로
		multi = new MultipartRequest(req, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		Enumeration files = multi.getFileNames();
		String[] original = new String[5];;
		String[] type = new String[5];;
		String[] filename = new String[5];
		File[] file = new File[5];
		int index=0;
		
		// 7) 
		while (files.hasMoreElements()) { // 만약 파일이 다수면 if를 while로..
			String name = (String) files.nextElement();
			filename[index] = multi.getFilesystemName(name); // DefaultFileRenamePolicy 적용
			original[index] = multi.getOriginalFileName(name); // 파일 원래 이름 (추가해도되고, 안해도..?)
			type[index] = multi.getContentType(name); // 파일 타입 (추가해도되고, 안해도..?)
			file[index] = multi.getFile(name);
			index++;
		}*/
	
	// 가져옴. (파일 복수 참조)
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
		
		
		
		
		// 파일 단일.
		/*
		// =================================================
		
		// 6) fileSave 폴더 webcontent폴더 안에 만들기
		String realFolder = ""; // 웹 어플리케이션상의 절대경로
		String encType = "euc-kr"; // 인코딩 타입
		int maxSize = 5 * 1024 * 1024; // 최대 업로드 될 파일 크기 .. 5MB
		ServletContext context = req.getServletContext();
		realFolder = context.getRealPath("fileSave");
		MultipartRequest multi = null;

		// DefaultFileRenamePolicy는 중복된 파일 업로드할때 자동으로 Rename / aaa있으면 aaa(1)로
		multi = new MultipartRequest(req, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		Enumeration files = multi.getFileNames();
		String filename = "";
		File file = null;
		
		// 7) 
		if (files.hasMoreElements()) { // 만약 파일이 다수면 if를 while로..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy 적용
			String original = multi.getOriginalFileName(name); // 파일 원래 이름 (추가해도되고, 안해도..?)
			String type = multi.getContentType(name); // 파일 타입 (추가해도되고, 안해도..?)
			file = multi.getFile(name);
		}
		// =================================================
*/
	
}
	