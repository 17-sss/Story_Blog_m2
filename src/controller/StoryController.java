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
		
		if (req.getParameter("num") != null && !req.getParameter("num").equals("")) {
			user.setNum(Integer.parseInt(req.getParameter("num")));
		}
		
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
	
	
	
// {} class
}
