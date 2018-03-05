package controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.db.DiaryDBBean;
import com.db.DiaryDataBean;
import com.db.UserDBBean;
import com.db.UserDataBean;
import com.sist.msk.Action;

public class StoryController extends Action {
	
	
	public String index(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		return  "/Project/index.jsp"; 
	}
	
	
	public String accountForm(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		int num=0;
		if (req.getParameter("num")!=null) {
			num = Integer.parseInt(req.getParameter("num"));
			}
		
		req.setAttribute("num", num);

		return  "/Project/accountForm.jsp"; 
	} 
	
	
	public String accountPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		UserDBBean dbPro = UserDBBean.getInstance();
		UserDataBean user = new UserDataBean();
		
		user.setEmail(req.getParameter("email"));
		user.setName(req.getParameter("name"));
		user.setPwd(req.getParameter("pwd"));
		user.setTel(req.getParameter("tel"));
		user.setBirth(req.getParameter("birth"));
		user.setIp(req.getRemoteAddr());
		
		System.out.println(user);
		
		user.setIp(req.getRemoteAddr());
		dbPro.insertUser(user);
		
		res.sendRedirect(req.getContextPath()+"/story/index");
		
		return null; 
	} 
	
	
	public String confirmEmail (HttpServletRequest req,HttpServletResponse res)  throws Throwable { 
		String email = req.getParameter("email"); 
		UserDBBean dbPro = UserDBBean.getInstance();
		boolean result = dbPro.confirmEmail(email);
		req.setAttribute("result", result);
		req.setAttribute("email", email);
		
		return  "/Project/confirmEmail.jsp"; 
	}
	
	
	public String LoginPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		 // 로그인 화면에 입력된 아이디와 비밀번호를 가져온다
        String email= req.getParameter("email");
        String pwd = req.getParameter("pwd");
        System.out.println("LoginPro=============");
     	// DB에서 아이디, 비밀번호 확인
        UserDBBean dbPro = UserDBBean.getInstance();
        int check = dbPro.loginCheck(email, pwd);
        
        UserDataBean user = new UserDataBean();
        HttpSession  session = req.getSession();
		user.setEmail(req.getParameter("email"));
		user.setPwd(req.getParameter("pwd"));
		user.setIp(req.getRemoteAddr());
        
        // URL 및 로그인관련 전달 메시지
        String msg = "";
        
        if(check == 1)    // 로그인 성공
        { 
            // 세션에 현재 아이디 세팅
        	session.setAttribute("sessionID", email);
            
         msg="/Story_Blog_m2/story/user_main";
        }
        else if(check == 0) // 비밀번호가 틀릴경우
        {
            msg = "index?msg=0";
        }
        else    // 아이디가 틀릴경우
        {
            msg = "index?msg=-1";
        }
        res.sendRedirect(msg);
        
        return null;
        /*if(check != 1)
        { 
        	
        	System.out.println("no");
        	return "/Project/index.jsp"; 
        }
        else {
        	System.out.println("yes");
        	session.setAttribute("sessionID", email);
        	 return "/Project/view/user_main.jsp";
        }*/
       
		
	}
	
	
	public String LogoutPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		
	    HttpSession  session = req.getSession();
		
	    session.invalidate(); // 모든세션정보 삭제
	    res.sendRedirect("index"); // 로그인 화면으로 다시 돌아간다.
		return null;
	}
	
	
	public String user_main (HttpServletRequest req, HttpServletResponse res)  throws Throwable {
		String diaryid = req.getParameter("diaryid");
		String subject = req.getParameter("subject");
		
		if (diaryid==null) diaryid = "Main"; 
		if (subject==null) subject = "하루의 끝";

		req.setAttribute("diaryid", diaryid);
		req.setAttribute("subject", subject);
		
		return "/Project/view/user_main.jsp";
	}
	
	
	public String user_gallery (HttpServletRequest req, HttpServletResponse res)  throws Throwable {

		return "/Project/view/user_gallery.jsp";
	}
	
	
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
			
			req.setAttribute("diary", diary); 
		} catch (Exception e) {}
		return "/Project/view/user_updateDForm.jsp"; 
	}
	
	
	public String user_updateDPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
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
			
			System.out.println("수정여부: " + chk);
			System.out.println(diary);
			
			
		} catch (Exception e) {e.printStackTrace();}
			
		return "/Project/view/user_updateDPro.jsp";
	}
		
		
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
	
	public String user_writePro(HttpServletRequest req, HttpServletResponse res)  throws Throwable {
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
		res.sendRedirect("user_timeline?pageNum="+pageNum+"&diaryid="+diaryid);
		
		return null;
	}
	
// {} class
}
