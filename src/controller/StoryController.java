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
	
	// user ====================================
	public String index(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		return  "/Project/index.jsp"; 
	}
	
	// ���� - ȸ������
	public String accountForm(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		int num=0;
		if (req.getParameter("num")!=null) {
			num = Integer.parseInt(req.getParameter("num"));
			}
		
		req.setAttribute("num", num);

		return  "/Project/accountForm.jsp"; 
	} 
	
	// ���� - ȸ������ ����
	public String accountPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		UserDBBean dbPro = UserDBBean.getInstance();
		UserDataBean user = new UserDataBean();
		
		// ���� ���ε�� ============================================
		String realFolder = ""; //�� ���ø����̼ǻ��� ������
		String encType = "euc-kr"; // ���ڵ� Ÿ��
		int maxSize = 3 *1024 * 1024; // �ִ� ���ε� �� ���� ũ�� .. 3MB (ȸ������)
		ServletContext context = req.getServletContext();
		realFolder =context.getRealPath("userSave");
		MultipartRequest multi = null;
		
		// DefaultFileRenamePolicy�� �ߺ��� ���� ���ε��Ҷ� �ڵ����� Rename / aaa������ aaa(1)��
		multi = new MultipartRequest(req, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String filename="";
		File file = null;
		
		if (files.hasMoreElements()) { // ���� ������ �ټ��� if�� while��..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy ����
			String original = multi.getOriginalFileName(name); // ���� ���� �̸� (�߰��ص��ǰ�, ���ص�..?)
			String type = multi.getContentType(name); // ���� Ÿ�� (�߰��ص��ǰ�, ���ص�..?)
			file = multi.getFile(name);
		}
		
		// end. ���� ���ε�� ============================================
		user.setEmail(multi.getParameter("email"));
		user.setName(multi.getParameter("name"));
		user.setPwd(multi.getParameter("pwd"));
		user.setTel(multi.getParameter("tel"));
		user.setBirth(multi.getParameter("birth"));
		user.setIp(req.getRemoteAddr());
		
		// + (���� ����)
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
	
	// ���� - �̸��� Ȯ��
	public String confirmEmail (HttpServletRequest req,HttpServletResponse res)  throws Throwable { 
		String email = req.getParameter("email"); 
		UserDBBean dbPro = UserDBBean.getInstance();
		boolean result = dbPro.confirmEmail(email);
		req.setAttribute("result", result);
		req.setAttribute("email", email);
		
		return  "/Project/confirmEmail.jsp"; 
	}
	
	// ���� - �α���
	public String LoginPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		 // �α��� ȭ�鿡 �Էµ� ���̵�� ��й�ȣ�� �����´�
		HttpSession  session = req.getSession();
		
		String email= req.getParameter("email");
        String pwd = req.getParameter("pwd");
        System.out.println("LoginPro=============");
     	
        // DB���� ���̵�, ��й�ȣ Ȯ��
        UserDBBean dbPro = UserDBBean.getInstance();
        int check = dbPro.loginCheck(email, pwd);
        
        UserDataBean user = new UserDataBean();
       
        // URL �� �α��ΰ��� ���� �޽���
        String msg = "";
 
        if(check == 1)    // �α��� ����
        {
            // ���ǿ� ���� ���̵� ����
        	session.setAttribute("sessionID", email);
        	// ���� ���� �����ͼ� ����� �ѷ��ֱ�.
        	user=dbPro.getUser(email);
            session.setAttribute("name", user.getName());
            session.setAttribute("filename", user.getFilename());
			msg = "/Story_Blog_m2/story/head";
        }
        else if(check == 0) // ��й�ȣ�� Ʋ�����
        {
            msg = "/Story_Blog_m2/story/index?msg=0";  
        }
        else    // ���̵� Ʋ�����
        {
            msg = "/Story_Blog_m2/story/index?msg=-1";
        }
        res.sendRedirect(msg);
        
        return null;
	}
	
	// ���� - �α׾ƿ�
	public String LogoutPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		
	    HttpSession  session = req.getSession();
		
	    session.invalidate(); // ��缼������ ����
	    res.sendRedirect("index"); // �α��� ȭ������ �ٽ� ���ư���.
		return null;
	}
	
	// ���� - ����
	public String user_main (HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "�Ϸ��� ��";
		
		
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
		//�Խ��ǿ� �ִ� �� �� count
		if (count > 0) {
			diaryList = dbPro.getDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
		}
		number = count - (currentPage - 1) * pageSize;
		
		System.out.println(count+":"+diaryList);
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //����, ����������.
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
	
	// ���� - ������
	public String user_gallery (HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "�Ϸ��� ��";
		
		
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
		int number = 0;
		List diaryList = null;
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		count = dbPro.getImgDiaryCount(diaryid, (String)session.getAttribute("sessionID"));
		//�Խ��ǿ� �ִ� �� �� count
		if (count > 0) {
			diaryList = dbPro.getImgDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
		}
		number = count - (currentPage - 1) * pageSize;
		
		System.out.println(count+":"+diaryList);
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //����, ����������.
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
	
		return "/Project/view/user_gallery.jsp";
	}
	
	// ���� - Ÿ�Ӷ���
	public String user_timeline (HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "�Ϸ��� ��";
		
		
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
		//�Խ��ǿ� �ִ� �� �� count
		if (count > 0) {
			diaryList = dbPro.getDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
		}
		number = count - (currentPage - 1) * pageSize;
		
		System.out.println(count+":"+diaryList);
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //����, ����������.
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
	
	// ���� - �ϱ� ���� ��
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
	
	// ���� - �ϱ� ���� �� ����
	/*public String user_updateDPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		DiaryDataBean diary = new DiaryDataBean();
		DiaryDBBean diaPro = DiaryDBBean.getInstance();
		int num = Integer.parseInt(req.getParameter("num"));
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		String diaryid = req.getParameter("diaryid");
		if (diaryid==null) diaryid = "Main";
		
		try {
			diary.setNum(num);
			diary.setEmail(req.getParameter("email"));
			diary.setSubject(req.getParameter("subject"));
			diary.setContent(req.getParameter("content"));
			diary.setDiaryid(req.getParameter("diaryid"));
			diary.setIp(req.getRemoteAddr());
			
			int chk = diaPro.updateDiary(diary);
			
			req.setAttribute("chk", chk);
			req.setAttribute("pageNum", pageNum);
			
			System.out.println("��������: " + chk);
			System.out.println(diary);
			
			
		} catch (Exception e) {e.printStackTrace();}
			
		return "/Project/view/user_updateDPro.jsp";
	}*/
	// ���� - ���� ���ε� �õ�
	public String user_updateDPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		DiaryDataBean diary = new DiaryDataBean();
		DiaryDBBean diaPro = DiaryDBBean.getInstance();
		
		// 6) fileSave ���� webcontent���� �ȿ� �����
		String realFolder = ""; //�� ���ø����̼ǻ��� ������
		String encType = "euc-kr"; // ���ڵ� Ÿ��
		int maxSize = 5 *1024 * 1024; // �ִ� ���ε� �� ���� ũ�� .. 5MB
		ServletContext context = req.getServletContext();
		realFolder =context.getRealPath("fileSave");
		MultipartRequest multi = null;
		
		// DefaultFileRenamePolicy�� �ߺ��� ���� ���ε��Ҷ� �ڵ����� Rename / aaa������ aaa(1)��
		multi = new MultipartRequest(req, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String filename="";
		File file = null;
		// =================================================
		// 7) 
		if (files.hasMoreElements()) { // ���� ������ �ټ��� if�� while��..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy ����
			String original = multi.getOriginalFileName(name); // ���� ���� �̸� (�߰��ص��ǰ�, ���ص�..?)
			String type = multi.getContentType(name); // ���� Ÿ�� (�߰��ص��ǰ�, ���ص�..?)
			file = multi.getFile(name);
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
			diary.setIp(req.getRemoteAddr());
			
			if (file != null) {
				diary.setFilename(filename);
				diary.setFilesize((int)file.length());
			} else {
				/*diary.setFilename(" ");*/
				diary.setFilesize(0);
			}
			
			int chk = diaPro.updateDiary(diary);
			
			req.setAttribute("chk", chk);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("diaryid", diaryid);
			
			System.out.println("��������: " + chk);
			System.out.println(diary);
			
			
		} catch (Exception e) {e.printStackTrace();}
			
		return "/Project/view/user_updateDPro.jsp";
	}
		
	// ���� - �ϱ� ���� ����	
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
	
	// ���� - �ϱ� ���� ��
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
			/*diary.setFilename(" ");*/
			diary.setFilesize(0);
		}
		// =================================================
		
		System.out.println(diary);
		//9) insertDiary �޼ҵ� ���� 
		dbPro.insertDiary(diary);
		
		req.setAttribute("pageNum", pageNum);
		res.sendRedirect("user_main?pageNum="+pageNum+"&diaryid="+diaryid);
		
		return null;
	}
	
	// ���� - ������ (���������� �̵�)
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
			System.out.println("���� ������: "+diary);
			
		} catch (Exception e) {e.printStackTrace();}
		
		return "/Project/view/user_content.jsp";
	}
	
	// ���� - ���������� 
	public String user_set(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		HttpSession session = req.getSession();
		
		try {
			UserDBBean userPro = UserDBBean.getInstance();
			UserDataBean user = userPro.getUser((String)session.getAttribute("sessionID"));
			
			req.setAttribute("user", user); 
		} catch (Exception e) {}
		
		return  "/Project/view/user_set.jsp"; 
	}
	
	public String user_updateUPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		UserDataBean user = new UserDataBean();
		UserDBBean userPro = UserDBBean.getInstance();
		// ���� ���ε�� ============================================
		String realFolder = ""; //�� ���ø����̼ǻ��� ������
		String encType = "euc-kr"; // ���ڵ� Ÿ��
		int maxSize = 3 *1024 * 1024; // �ִ� ���ε� �� ���� ũ�� .. 3MB (ȸ������)
		ServletContext context = req.getServletContext();
		realFolder =context.getRealPath("userSave");
		MultipartRequest multi = null;
		
		// DefaultFileRenamePolicy�� �ߺ��� ���� ���ε��Ҷ� �ڵ����� Rename / aaa������ aaa(1)��
		multi = new MultipartRequest(req, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String filename="";
		File file = null;
		
		if (files.hasMoreElements()) { // ���� ������ �ټ��� if�� while��..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy ����
			String original = multi.getOriginalFileName(name); // ���� ���� �̸� (�߰��ص��ǰ�, ���ص�..?)
			String type = multi.getContentType(name); // ���� Ÿ�� (�߰��ص��ǰ�, ���ص�..?)
			file = multi.getFile(name);
		}
		
		// end. ���� ���ε�� ============================================
		
		String email = multi.getParameter("email");
		String pwd= multi.getParameter("pwd");
		
		try {
			user.setEmail(multi.getParameter("email"));
			user.setPwd(multi.getParameter("pwd"));
			user.setName(multi.getParameter("name"));
			user.setTel(multi.getParameter("tel"));
			user.setBirth(multi.getParameter("birth"));
			user.setIp(req.getRemoteAddr());
			
			// + (���� ����)
			if (file != null) {
				user.setFilename(filename);
				user.setFilesize((int)file.length());
			} else {
				/*user.setFilename(" ");*/
				user.setFilesize(0);
			}
			// ============
			
			int chk = userPro.updateUser(user);
			
			req.setAttribute("chk", chk);
			req.setAttribute("email", email);
			req.setAttribute("pwd", pwd);
			
			System.out.println("��������: " + chk);
			System.out.println(user);
			
			
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
		
		System.out.println("��������: " + check);
		
		req.setAttribute("pwd", pwd);
		req.setAttribute("email", email);
		req.setAttribute("check", check);
		
		return "/Project/view/user_deleteUPro.jsp"; 
	}
	// end. ���� - ���������� ============================= 
	
	
	// end. user ====================================
	
	
	// admin ========================================
	
	
	// ������ ��������
	// /story/admin/accountList
	public String accountList(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		int pageSize= 10;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;  
		//��Ģ������ ��������.. +1�� �ǳ��߿�! ���ʿ������� ���������� ���ʴ�� ���
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		List usList = null;
		UserDBBean dbPro = UserDBBean.getInstance();
		count = dbPro.getUserCount();
		//�Խ��ǿ� �ִ� �� �� count
		if (count > 0) {
			usList = dbPro.getUsers(startRow, endRow); 
		}
		number = count - (currentPage - 1) * pageSize;
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //����, ����������.
		int endPage = startPage + bottomLine -1;
		
		if (endPage > pageCount) endPage = pageCount;
		
		req.setAttribute("count", count);
		req.setAttribute("usList", usList);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("startPage", startPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("number", number);
		req.setAttribute("endPage", endPage);
		
		return  "/admin/accountList.jsp"; 
	}
	
	
	// /story/admin/adLogoutPro
	public String adLogoutPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		HttpSession session = req.getSession();
	    session.invalidate(); // ��缼������ ����
	    res.sendRedirect(req.getContextPath()+"/story/index"); // �α��� ȭ������ �ٽ� ���ư���.
		
	    return null; 
	}
	
	
	// /story/admin/updateUserForm
	public String updateUserForm(HttpServletRequest req, HttpServletResponse res) throws Throwable { 
		String email=req.getParameter("email");
		String pwd=req.getParameter("pwd");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") { pageNum = "1"; }
		try {
			UserDBBean userPro = UserDBBean.getInstance();
			UserDataBean user = userPro.getUser(email, pwd);
			
			req.setAttribute("user", user); 
		} catch (Exception e) {}
		return "/admin/updateUserForm.jsp"; 
	}
	
	
	// /story/admin/updateUserPro
	public String updateUserPro(HttpServletRequest req, HttpServletResponse res) throws Throwable { 
		UserDataBean user = new UserDataBean();
		UserDBBean userPro = UserDBBean.getInstance();
		
		// ���� ���ε�� ============================================
		String realFolder = ""; //�� ���ø����̼ǻ��� ������
		String encType = "euc-kr"; // ���ڵ� Ÿ��
		int maxSize = 3 *1024 * 1024; // �ִ� ���ε� �� ���� ũ�� .. 3MB (ȸ������)
		ServletContext context = req.getServletContext();
		realFolder =context.getRealPath("userSave");
		MultipartRequest multi = null;
		
		// DefaultFileRenamePolicy�� �ߺ��� ���� ���ε��Ҷ� �ڵ����� Rename / aaa������ aaa(1)��
		multi = new MultipartRequest(req, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String filename="";
		File file = null;
		
		if (files.hasMoreElements()) { // ���� ������ �ټ��� if�� while��..
			String name = (String) files.nextElement();
			filename = multi.getFilesystemName(name); // DefaultFileRenamePolicy ����
			String original = multi.getOriginalFileName(name); // ���� ���� �̸� (�߰��ص��ǰ�, ���ص�..?)
			String type = multi.getContentType(name); // ���� Ÿ�� (�߰��ص��ǰ�, ���ص�..?)
			file = multi.getFile(name);
		}
		
		// end. ���� ���ε�� ============================================
		
		String email = multi.getParameter("email");
		String pwd= multi.getParameter("pwd");
		String pageNum = multi.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		
		try {
			user.setEmail(multi.getParameter("email"));
			user.setPwd(multi.getParameter("pwd"));
			user.setName(multi.getParameter("name"));
			user.setTel(multi.getParameter("tel"));
			user.setBirth(multi.getParameter("birth"));
			user.setIp(req.getRemoteAddr());
			
			// + (���� ����)
			if (file != null) {
				user.setFilename(filename);
				user.setFilesize((int)file.length());
			} else {
				/*user.setFilename(" ");*/
				user.setFilesize(0);
			}
			// ============
			
			int chk = userPro.updateUser(user);
			
			req.setAttribute("chk", chk);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("email", email);
			req.setAttribute("pwd", pwd);
			
			System.out.println("��������: " + chk);
			System.out.println(user);
			
			
		} catch (Exception e) {e.printStackTrace();}
		
		return  "/admin/updateUserPro.jsp"; 
	}
	
	
	// /story/admin/deleteUserPro
	public String deleteUserPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
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
		
		System.out.println("��������: " + check);
		
		req.setAttribute("pwd", pwd);
		req.setAttribute("email", email);
		req.setAttribute("check", check);
		
		return "/admin/deleteUserPro.jsp"; 
	}
	
	
	// ������ �ϱ���
	// /story/admin/ad_deleteDPro
	public String ad_deleteDPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		int num = Integer.parseInt(req.getParameter("num"));
		
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		
		int check = dbPro.deleteDiary(num, (String)session.getAttribute("sessionID"), diaryid);
		
		req.setAttribute("check", check);
		
		return "/admin/adView/ad_deleteDPro.jsp"; 
	}
	
	
	// /story/admin/ad_gallery
	public String ad_gallery(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		return "/admin/adView/ad_gallery.jsp";
	}
	
	
	// /story/admin/ad_main
	public String ad_main(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "�Ϸ��� ��";

		req.setAttribute("diaryid", diaryid);
		req.setAttribute("subject", subject);
		
		return "/admin/adView/ad_main.jsp";
	}
	
	
	// /story/admin/ad_timeline
	public String ad_timeline(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "�Ϸ��� ��";
		
		
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
		//�Խ��ǿ� �ִ� �� �� count
		if (count > 0) {
			diaryList = dbPro.getDiaries(startRow, endRow, (String)session.getAttribute("sessionID"), diaryid);
		}
		number = count - (currentPage - 1) * pageSize;
		
		System.out.println(count+":"+diaryList);
		
		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //����, ����������.
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
		
		return "/admin/adView/ad_timeline.jsp";
	}
	
	
	// /story/admin/ad_updateDForm 
	public String ad_updateDForm(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
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
			
			req.setAttribute("diary", diary); 
		} catch (Exception e) {}
		
		return "/admin/adView/ad_updateDForm.jsp";
	}
	
	
	// /story/admin/ad_updateDPro
	public String ad_updateDPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		DiaryDataBean diary = new DiaryDataBean();
		DiaryDBBean diaPro = DiaryDBBean.getInstance();
		int num = Integer.parseInt(req.getParameter("num"));
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		String diaryid = req.getParameter("diaryid");
		if (diaryid==null) diaryid = "Main";
		
		try {
			diary.setNum(num);
			diary.setEmail(req.getParameter("email"));
			diary.setSubject(req.getParameter("subject"));
			diary.setContent(req.getParameter("content"));
			diary.setDiaryid(req.getParameter("diaryid"));
			diary.setIp(req.getRemoteAddr());
			
			int chk = diaPro.updateDiary(diary);
			
			req.setAttribute("chk", chk);
			req.setAttribute("pageNum", pageNum);
			
			System.out.println("��������: " + chk);
			System.out.println(diary);
			
			
		} catch (Exception e) {e.printStackTrace();}
		
		return "/admin/adView/ad_updateDPro.jsp";
	}
	
	
	// /story/admin/ad_write
	public String ad_write(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		String subject = req.getParameter("subject");
	    System.out.println("����:"+subject);
	    
	    int num=0;
		String diaryid = req.getParameter("diaryid");
		
		if (diaryid==null) diaryid = "Main";
		if (subject==null) subject = "�������";

		if (req.getParameter("num")!=null) {num = Integer.parseInt(req.getParameter("num"));}
		
		req.setAttribute("diaryid", diaryid);
		req.setAttribute("subject", subject);
		
		return "/admin/adView/ad_write.jsp";
	}
	
	
	// /story/admin/ad_writePro
	public String ad_writePro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession();
		DiaryDataBean diary = new DiaryDataBean();
		DiaryDBBean dbPro = DiaryDBBean.getInstance();
		
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {pageNum = "1";}
		
		String diaryid = req.getParameter("diaryid");
		if (diaryid==null) diaryid = "Main";
		
		//diary.setNum(num);
		diary.setEmail((String)session.getAttribute("sessionID")); 
		diary.setSubject(req.getParameter("subject"));
		diary.setContent(req.getParameter("content"));
		diary.setDiaryid(req.getParameter("diaryid"));
		diary.setIp(req.getRemoteAddr());
		
		System.out.println(diary);
		
		dbPro.insertDiary(diary);
		
		req.setAttribute("pageNum", pageNum);
		res.sendRedirect("ad_timeline?pageNum="+pageNum+"&diaryid="+diaryid);
		
		return null;
	}
	// end. admin ========================================
	
	
	// ��� �׽�Ʈ ==========================================
	// header.jspf - /story/head
	public String head(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		HttpSession session = req.getSession(); 
		UserDBBean dbPro = UserDBBean.getInstance();
        UserDataBean user = new UserDataBean();
        
		// �α����� �ȵǾ��� ��
		if(session.getAttribute("sessionID") == null)  {
			res.sendRedirect(req.getContextPath()+"/story/index");
		}
		// ȸ������ ȭ������ �̵� (admin)
		else if(session.getAttribute("sessionID").equals("admin")) {     
			user=dbPro.getUser((String)session.getAttribute("sessionID"));
            session.setAttribute("name", user.getName());
            session.setAttribute("filename", user.getFilename());
	        res.sendRedirect(req.getContextPath()+"/story/admin/accountList");
	    }
		// �α��� �Ǿ��� ��
		else {
	    	res.sendRedirect(req.getContextPath()+"/story/user_main"); 
		} 
		  	
		return null;
	}
	
	
	// adheader.jspf - /story/admin/adhead
	/*public String adhead(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		HttpSession session = req.getSession(); 
		 
		// admin �ƴ� ��� (�ȸ���)
		if(!session.getAttribute("sessionID").equals("admin"))  {
			session.invalidate();
			res.sendRedirect(req.getContextPath()+"/story/index");
		}
		else {
			res.sendRedirect(req.getContextPath()+"/story/admin/ad_main");
		}
		return null;
	}*/
	
	// end. ��� �׽�Ʈ ========================================

// {} class
}
