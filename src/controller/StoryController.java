package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	
	public String LoginPro(HttpServletRequest req, HttpServletResponse res)  throws Throwable { 
		 // 로그인 화면에 입력된 아이디와 비밀번호를 가져온다
        String email= req.getParameter("email");
        String pwd = req.getParameter("pwd");
        
     	// DB에서 아이디, 비밀번호 확인
        UserDBBean dbPro = UserDBBean.getInstance();
        int check = dbPro.loginCheck(email, pwd);
        
        UserDataBean user = new UserDataBean();
        
		user.setEmail(req.getParameter("email"));
		user.setPwd(req.getParameter("pwd"));
		/*user.setName(req.getParameter("name"));
		user.setTel(req.getParameter("tel"));*/
		/*user.setCdate(Date date);*/
		user.setIp(req.getRemoteAddr());
        
        // URL 및 로그인관련 전달 메시지
        String msg = "";
        
        if(check == 1)    // 로그인 성공
        { 
            // 세션에 현재 아이디 세팅
            req.setAttribute("sessionID", email);
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
	}
	
	public String user_main (HttpServletRequest req, HttpServletResponse res)  throws Throwable {

		return "/Project/view/user_main.jsp";
	}
	
	
	
// {} class
}
