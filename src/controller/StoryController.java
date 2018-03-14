package controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.db.DiaryDBBean;
import com.db.DiaryDataBean;
import com.db.UserDBBean;
import com.db.UserDataBean;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sist.msk.Action;

public class StoryController extends Action {
	public String index(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		return  "/Project/index.jsp"; 
	}
	
	// 유저 - 회원가입
	public String accountForm(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		int num=0;
		if (req.getParameter("num")!=null) {
			num = Integer.parseInt(req.getParameter("num"));
			}
		
		req.setAttribute("num", num);

		return  "/Project/accountForm.jsp"; 
	} 
	
	// 유저 - 회원가입 전송
	public String accountPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		UserDBBean dbPro = UserDBBean.getInstance();
		UserDataBean user = new UserDataBean();
		
		// 사진 업로드용 ============================================
		String realFolder = ""; //웹 어플리케이션상의 절대경로
		String encType = "euc-kr"; // 인코딩 타입
		int maxSize = 3 *1024 * 1024; // 최대 업로드 될 파일 크기 .. 3MB (회원사진)
		ServletContext context = req.getServletContext();
		realFolder =context.getRealPath("userSave");
		MultipartRequest multi = null;
		
		// DefaultFileRenamePolicy는 중복된 파일 업로드할때 자동으로 Rename / aaa있으면 aaa(1)로
		multi = new MultipartRequest(req, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String filename="";
		File file = null;
		
		if (files.hasMoreElements()) { // 만약 파일이 다수면 if를 while로..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy 적용
			String original = multi.getOriginalFileName(name); // 파일 원래 이름 (추가해도되고, 안해도..?)
			String type = multi.getContentType(name); // 파일 타입 (추가해도되고, 안해도..?)
			file = multi.getFile(name);
		}
		
		// end. 사진 업로드용 ============================================
		user.setEmail(multi.getParameter("email"));
		user.setName(multi.getParameter("name"));
		user.setPwd(multi.getParameter("pwd"));
		user.setTel(multi.getParameter("tel"));
		user.setBirth(multi.getParameter("birth"));
		user.setIp(req.getRemoteAddr());
		
		// + (사진 관련)
		if (file != null) {
			user.setFilename(filename);
			user.setFilesize((int)file.length());
		} else {
			/*user.setFilename(" ");*/
			user.setFilesize(0);
		}
		// ============
		System.out.println(user);
		
		dbPro.insertUser(user);
		
		res.sendRedirect(req.getContextPath()+"/story/index");
		
		return null; 
	} 
	
	// 유저 - 이메일 확인
	public String confirmEmail (HttpServletRequest req,HttpServletResponse res)  throws Throwable { 
		String email = req.getParameter("email"); 
		UserDBBean dbPro = UserDBBean.getInstance();
		boolean result = dbPro.confirmEmail(email);
		req.setAttribute("result", result);
		req.setAttribute("email", email);
		
		return  "/Project/confirmEmail.jsp"; 
	}
	
	// 유저 - 로그인
	public String LoginPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		 // 로그인 화면에 입력된 아이디와 비밀번호를 가져온다
		HttpSession  session = req.getSession();
		
		String email= req.getParameter("email");
        String pwd = req.getParameter("pwd");
        System.out.println("LoginPro=============");
     	
        // DB에서 아이디, 비밀번호 확인
        UserDBBean dbPro = UserDBBean.getInstance();
        int check = dbPro.loginCheck(email, pwd);
        
        UserDataBean user = new UserDataBean();
       
        // URL 및 로그인관련 전달 메시지
        String msg = "";
 
        if(check == 1)    // 로그인 성공
        {
            // 세션에 현재 아이디 세팅
        	session.setAttribute("sessionID", email);
        	// 유저 정보 가져와서 헤더에 뿌려주기.
        	user=dbPro.getUser(email);
            session.setAttribute("name", user.getName());
            session.setAttribute("filename", user.getFilename());
			msg = req.getContextPath()+"/story/head";
        }
        else if(check == 0) // 비밀번호가 틀릴경우
        {
            msg = req.getContextPath()+"/story/index?msg=0";
        }
        else    // 아이디가 틀릴경우
        {
            msg = req.getContextPath()+"/story/index?msg=-1";
        }
        res.sendRedirect(msg);
        
        return null;
	}
	
	// 유저 - 로그아웃
	public String LogoutPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		
	    HttpSession  session = req.getSession();
		
	    session.invalidate(); // 모든세션정보 삭제
	    res.sendRedirect("index"); // 로그인 화면으로 다시 돌아간다.
		return null;
	}
	
	// 유저 - 메인
	public String user_main (HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "하루의 끝";
		
		
		int pageSize= 5;
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		int count = 0;
		int number = 0;
		List diaryList = null;
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		count = dbPro.getDiaryCount(diaryid, (String)session.getAttribute("sessionID"));
		//게시판에 있는 글 수 count
		if (count > 0) {
			diaryList = dbPro.getDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
		}
		number = count - (currentPage - 1) * pageSize;
		
		System.out.println("일기장 수: "+count);
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //곱셈, 나눗셈먼저.
		int endPage = startPage + bottomLine -1;
		
		if (endPage > pageCount) endPage = pageCount;
		
		req.setAttribute("subject", subject);
		req.setAttribute("diaryid", diaryid);
		req.setAttribute("count", count);
		req.setAttribute("diaryList", diaryList);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("startPage", startPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("number", number);
		req.setAttribute("endPage", endPage);
		
		return "/Project/view/user_main.jsp";
	}
	
	// 유저 - 갤러리
	public String user_gallery (HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "하루의 끝";
		
		
		int pageSize= 9;
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		int count = 0;
		int countT = 0;
		int number = 0;
		List diaryList = null;
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		count = dbPro.getImgDiaryCount(diaryid, (String)session.getAttribute("sessionID"));
		countT = dbPro.getImgDiaryCountTotal(diaryid, (String)session.getAttribute("sessionID"));
		//게시판에 있는 글 수 count
		if (count > 0) {
			diaryList = dbPro.getDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
		}
		number = count - (currentPage - 1) * pageSize;
		
		System.out.println(count+":"+diaryList);
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //곱셈, 나눗셈먼저.
		int endPage = startPage + bottomLine -1;
		
		if (endPage > pageCount) endPage = pageCount;
		
		req.setAttribute("subject", subject);
		req.setAttribute("diaryid", diaryid);
		req.setAttribute("count", count);
		req.setAttribute("countT", countT);
		req.setAttribute("diaryList", diaryList);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("startPage", startPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("number", number);
		req.setAttribute("endPage", endPage);
	
		return "/Project/view/user_gallery.jsp";
	}
	
	// 유저 - 타임라인
	public String user_timeline (HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "하루의 끝";
		
		
		int pageSize= 5;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		int count = 0;
		int number = 0;
		List diaryList = null;
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		count = dbPro.getDiaryCount(diaryid, (String)session.getAttribute("sessionID"));
		//게시판에 있는 글 수 count
		if (count > 0) {
			diaryList = dbPro.getDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
		}
		number = count - (currentPage - 1) * pageSize;
		
		System.out.println(count+":"+diaryList);
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //곱셈, 나눗셈먼저.
		int endPage = startPage + bottomLine -1;
		
		if (endPage > pageCount) endPage = pageCount;
		
		req.setAttribute("subject", subject);
		req.setAttribute("diaryid", diaryid);
		req.setAttribute("count", count);
		req.setAttribute("diaryList", diaryList);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("startPage", startPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("number", number);
		req.setAttribute("endPage", endPage);
		
		return "/Project/view/user_timeline.jsp";
	}
	
	// 유저 - 일기 수정 폼
	public String user_updateDForm(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		HttpSession session = req.getSession();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String diaryid = req.getParameter("diaryid");
		if (diaryid==null) diaryid="Main";
		String pageNum = req.getParameter("pageNum");
			if (pageNum == null || pageNum == "") { 
				pageNum = "1"; 
			}
		int num = Integer.parseInt(req.getParameter("num"));
		
		try {
			DiaryDBBean diaryPro = DiaryDBBean.getInstance();
			DiaryDataBean diary = diaryPro.getDiary(num, (String)session.getAttribute("sessionID"), diaryid);
			
			req.setAttribute("pageNum", pageNum); 
			req.setAttribute("diary", diary); 
		} catch (Exception e) {}
		return "/Project/view/user_updateDForm.jsp"; 
	}
	
	// 일기 수정 전송 - 파일 업로드
	public String user_updateDPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		DiaryDataBean diary = new DiaryDataBean();
		DiaryDBBean diaPro = DiaryDBBean.getInstance();
		
		// 6) fileSave 폴더 webcontent폴더 안에 만들기
		String realFolder = ""; //웹 어플리케이션상의 절대경로
		String encType = "euc-kr"; // 인코딩 타입
		int maxSize = 5 *1024 * 1024; // 최대 업로드 될 파일 크기 .. 5MB
		ServletContext context = req.getServletContext();
		realFolder =context.getRealPath("fileSave");
		MultipartRequest multi = null;
		
		// DefaultFileRenamePolicy는 중복된 파일 업로드할때 자동으로 Rename / aaa있으면 aaa(1)로
		multi = new MultipartRequest(req, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String[] filename = new String[5];
		File[] file = new File[5];
		int index = 0;
		
		String[] original = new String[5];
		String[] type = new String[5];
		
		// 7) 
		while (files.hasMoreElements()) { // 만약 파일이 다수면 if를 while로..
			String name = (String) files.nextElement();
			filename[index] = multi.getFilesystemName(name);
			original[index] = multi.getOriginalFileName(name);
			type[index] = multi.getContentType(name);
			file[index] = multi.getFile(name);
			index++;
		}
		
		int num = Integer.parseInt(multi.getParameter("num"));
		
		String pageNum = multi.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		
		String diaryid = multi.getParameter("diaryid");
		if (diaryid==null) diaryid = "Main";
		
		try {
			diary.setNum(num);
			diary.setEmail(multi.getParameter("email"));
			diary.setSubject(multi.getParameter("subject"));
			diary.setContent(multi.getParameter("content"));
			diary.setDiaryid(multi.getParameter("diaryid"));
			diary.setFilename0(multi.getParameter("filename0"));
			diary.setFilename1(multi.getParameter("filename1"));
			diary.setFilename2(multi.getParameter("filename2"));
			diary.setFilename3(multi.getParameter("filename3"));
			diary.setFilename4(multi.getParameter("filename4"));
			diary.setIp(req.getRemoteAddr());
			
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
			
			int chk = diaPro.updateDiary(diary);
			
			req.setAttribute("chk", chk);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("diaryid", diaryid);
			
			System.out.println("수정여부: " + chk);
			System.out.println(diary);
			
			
		} catch (Exception e) {e.printStackTrace();}
			
		return "/Project/view/user_updateDPro.jsp";
	}
		
	// 유저 - 일기 삭제 전송	
	public String user_deleteDPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		int num = Integer.parseInt(req.getParameter("num"));
		
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		
		int check = dbPro.deleteDiary(num, (String)session.getAttribute("sessionID"), diaryid);
		
		req.setAttribute("check", check);
		
		return "/Project/view/user_deleteDPro.jsp"; 
	} 
	
	// 유저 - 일기 쓰기 폼 
	public String user_write(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		String subject = req.getParameter("subject");
	    System.out.println("제목:"+subject);
	    
	    int num=0;
		String diaryid = req.getParameter("diaryid");
		
		if (diaryid==null) diaryid = "Main";
		if (subject==null) subject = "제목없음";

		if (req.getParameter("num")!=null) {num = Integer.parseInt(req.getParameter("num"));}
		
		req.setAttribute("diaryid", diaryid);
		req.setAttribute("subject", subject);
		
		return  "/Project/view/user_write.jsp"; 
	}
	
	// 유저 - 일기 쓰기 폼 전송 (사진 다수)
	public String user_writePro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		DiaryDataBean diary = new DiaryDataBean();
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		
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
		String[] filename = new String[5];
		File[] file = new File[5];
		int index = 0;
		
		String[] original = new String[5];
		String[] type = new String[5];
		
		// 7) 
		while (files.hasMoreElements()) { // 만약 파일이 다수면 if를 while로..
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
		//9) insertDiary 메소드 수정 (복수 개로 할시 필수 수정)
		dbPro.insertDiary(diary);
		
		req.setAttribute("pageNum", pageNum);
		res.sendRedirect("user_main?pageNum="+pageNum+"&diaryid="+diaryid);
		
		return null;
	}
	
	// 유저 - 콘텐츠 (갤러리에서 이동)
	public String user_content(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		int num = Integer.parseInt(req.getParameter("num"));
		String diaryid = req.getParameter("diaryid");
		if (diaryid==null) diaryid = "Main"; 

		
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
			pageNum = "1";
		}
		try {
			DiaryDBBean dbPro = DiaryDBBean.getInstance();
			DiaryDataBean diary = dbPro.getDiary(num, (String)session.getAttribute("sessionID"), diaryid);
			
			req.setAttribute("diary", diary);
			req.setAttribute("pageNum", pageNum);
			System.out.println("유저 콘텐츠: "+diary);
			
		} catch (Exception e) {e.printStackTrace();}
		
		return "/Project/view/user_content.jsp";
	}
	
	// 유저 - 마이페이지 
	public String user_set(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		/*HttpSession session = req.getSession();
		
		try {
			UserDBBean userPro = UserDBBean.getInstance();
			UserDataBean user = userPro.getUser((String)session.getAttribute("sessionID"));
			
			System.out.println("마이페이지 정보: " + user);
			req.setAttribute("user", user); 
			
		} catch (Exception e) {}
		
		return  "/Project/view/user_set.jsp"; 
	}*/	
		HttpSession session = req.getSession();
		
		try {
			UserDBBean userPro = UserDBBean.getInstance();
			UserDataBean user = userPro.getUser((String)session.getAttribute("sessionID"));
			
			req.setAttribute("user", user); 
		} catch (Exception e) {}
		return "/Project/view/user_set.jsp"; 
	}
	
	
	public String user_updateUPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		UserDataBean user = new UserDataBean();
		UserDBBean dbPro = UserDBBean.getInstance();
		
		// 6) fileSave 폴더 webcontent폴더 안에 만들기
		String realFolder = ""; //웹 어플리케이션상의 절대경로
		String encType = "euc-kr"; // 인코딩 타입
		int maxSize = 5 *1024 * 1024; // 최대 업로드 될 파일 크기 .. 5MB
		ServletContext context = req.getServletContext();
		realFolder =context.getRealPath("userSave");
		MultipartRequest multi = null;
		
		// DefaultFileRenamePolicy는 중복된 파일 업로드할때 자동으로 Rename / aaa있으면 aaa(1)로
		multi = new MultipartRequest(req, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String filename="";
		File file = null;
		// =================================================
		// 7) 
		if (files.hasMoreElements()) { // 만약 파일이 다수면 if를 while로..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy 적용
			String original = multi.getOriginalFileName(name); // 파일 원래 이름 (추가해도되고, 안해도..?)
			String type = multi.getContentType(name); // 파일 타입 (추가해도되고, 안해도..?)
			file = multi.getFile(name);
		}
		
		try {
			user.setEmail(multi.getParameter("email"));
			user.setName(multi.getParameter("name"));
			user.setTel(multi.getParameter("tel"));
			user.setPwd(multi.getParameter("pwd"));
			user.setFilename(multi.getParameter("filename"));
			user.setBirth(multi.getParameter("birth"));
			user.setIp(req.getRemoteAddr());
			
			if (file != null) {
				user.setFilename(filename);
				user.setFilesize((int)file.length());
			} else {
				/*user.setFilename(" ");*/
				/*user.setFilesize(0);*/
			}
			
			int chk = dbPro.updateUser(user);
			
			req.setAttribute("chk", chk);
			
			System.out.println("수정여부: " + chk);
			System.out.println("수정아 좀되라..==========: "+user);
			
			
		} catch (Exception e) {e.printStackTrace();}
			
		return "/Project/view/user_updateUPro.jsp";
	}
	
	public String user_deleteUPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		UserDataBean user = new UserDataBean();
		
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		String email = req.getParameter("email");
		String pwd = req.getParameter("pwd");
		
		user.setEmail(req.getParameter("email"));
		user.setPwd(req.getParameter("pwd"));
		user.setName(req.getParameter("name"));
		user.setTel(req.getParameter("tel"));
		user.setBirth(req.getParameter("birth"));
		
		UserDBBean dbPro = UserDBBean.getInstance();
		
		int check = dbPro.deleteUser(email, pwd);
		
		System.out.println("삭제여부: " + check);
		
		req.setAttribute("pwd", pwd);
		req.setAttribute("email", email);
		req.setAttribute("check", check);
		
		return "/Project/view/user_deleteUPro.jsp"; 
	}
	// end. 유저 - 마이페이지 ============================= 

	// 헤더 테스트 ==========================================
	// header.jspf - /story/head
	public String head(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession(); 
		UserDBBean dbPro = UserDBBean.getInstance();
        UserDataBean user = new UserDataBean();
     
		// 로그인이 안되었을 때
		if(session.getAttribute("sessionID") == null)  {
			res.sendRedirect(req.getContextPath()+"/story/index");
		}
		// 로그인 되었을 때
		else {
	    	res.sendRedirect(req.getContextPath()+"/story/user_main"); 
		} 
		  	
		return null;
	}

// {} class
}
