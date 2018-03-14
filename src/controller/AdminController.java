package controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.UserDBBean;
import com.db.UserDataBean;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sist.msk.Action;

public class AdminController extends Action {
	// ������ ��������
	// /story/admin/accountList
	public String accountList(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		int pageSize = 10;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		// ��Ģ������ ��������.. +1�� �ǳ��߿�! ���ʿ������� ���������� ���ʴ�� ���
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		List usList = null;
		UserDBBean dbPro = UserDBBean.getInstance();
		count = dbPro.getUserCount();
		// �Խ��ǿ� �ִ� �� �� count
		if (count > 0) {
			usList = dbPro.getUsers(startRow, endRow);
		}
		number = count - (currentPage - 1) * pageSize;

		int bottomLine = 3;
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; // ����, ����������.
		int endPage = startPage + bottomLine - 1;

		if (endPage > pageCount)
			endPage = pageCount;

		req.setAttribute("count", count);
		req.setAttribute("usList", usList);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("startPage", startPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("number", number);
		req.setAttribute("endPage", endPage);

		return "/Project/admin/accountList.jsp";
	}

	
	
	// /story/admin/updateUserForm
	public String updateUserForm(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		String email = req.getParameter("email");
		String pwd = req.getParameter("pwd");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {
			pageNum = "1";
		}
		try {
			UserDBBean userPro = UserDBBean.getInstance();
			UserDataBean user = userPro.getUser(email, pwd);

			req.setAttribute("user", user);
		} catch (Exception e) {
		}
		return "/Project/admin/updateUserForm.jsp";
	}

	
	
	// /story/admin/updateUserPro
	public String updateUserPro(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		UserDataBean user = new UserDataBean();
		UserDBBean userPro = UserDBBean.getInstance();

		// ���� ���ε�� ============================================
		String realFolder = ""; // �� ���ø����̼ǻ��� ������
		String encType = "euc-kr"; // ���ڵ� Ÿ��
		int maxSize = 3 * 1024 * 1024; // �ִ� ���ε� �� ���� ũ�� .. 3MB (ȸ������)
		ServletContext context = req.getServletContext();
		realFolder = context.getRealPath("userSave");
		MultipartRequest multi = null;

		// DefaultFileRenamePolicy�� �ߺ��� ���� ���ε��Ҷ� �ڵ����� Rename / aaa������ aaa(1)��
		multi = new MultipartRequest(req, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		Enumeration files = multi.getFileNames();
		String filename = "";
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
		String pwd = multi.getParameter("pwd");
		String pageNum = multi.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {
			pageNum = "1";
		}

		try {
			user.setEmail(multi.getParameter("email"));
			user.setPwd(multi.getParameter("pwd"));
			user.setName(multi.getParameter("name"));
			user.setTel(multi.getParameter("tel"));
			user.setBirth(multi.getParameter("birth"));
			user.setFilename(multi.getParameter("filename"));
			user.setIp(req.getRemoteAddr());

			// + (���� ����)
			if (file != null) {
				user.setFilename(filename);
				user.setFilesize((int) file.length());
			} else {
				/* user.setFilename(" "); */
				/* user.setFilesize(0); */
			}
			// ============

			int chk = userPro.updateUser(user);

			req.setAttribute("chk", chk);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("email", email);

			System.out.println("��������: " + chk);
			System.out.println(user);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/Project/admin/updateUserPro.jsp";
	}

	
	
	// /story/admin/deleteUserPro
	public String deleteUserPro(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		UserDataBean user = new UserDataBean();

		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {
			pageNum = "1";
		}
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

		return "/Project/admin/deleteUserPro.jsp";
	}

}
