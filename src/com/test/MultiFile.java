package com.test;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.ServletContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MultiFile {
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
	