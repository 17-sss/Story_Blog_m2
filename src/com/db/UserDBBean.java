package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/*import jdk.nashorn.internal.ir.RuntimeNode.Request;*/


public class UserDBBean {
	// �̱���
	private static UserDBBean instance = new UserDBBean();
	private UserDBBean() {
		
	}
	
	public static UserDBBean getInstance() {
		return instance;
	}
	// ��Ŭ�� end.
	
	// �����ͺ��̽� ���� ��������
	public static Connection getConnection() {
		Connection conn = null;
		try {
			String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String dbId = "scott";
			String dbpwd = "tiger";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbpwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	// Close
	public void close (Connection conn, ResultSet rs, PreparedStatement pstmt) {
		if(conn!=null) try {conn.close();} catch(SQLException ex) {}
		if(rs!=null) try {rs.close();} catch(SQLException ex) {}
		if(pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
	}
	
	// ȸ������ (�߰�) �޼ҵ�
	public void insertUser(UserDataBean user) {
		String sql="";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int number=0;
		try {
			
			
			sql = "insert into userlist(email, name, pwd, tel, birth, cdate, ip)";
			sql += "values(?,?,?,?,?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getEmail());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getPwd());
			pstmt.setString(4, user.getTel());
			pstmt.setString(5, user.getBirth());
			pstmt.setString(6, user.getIp());
		    pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn, rs, pstmt);
		}
		
	}
	
	// ȸ�� �� �޼ҵ�
	public int getUserCount() throws SQLException {
		int x = 0;
		String sql = "SELECT nvl(count(*),0) FROM userlist";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;
		
		try {
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		if (rs.next()) { x = rs.getInt(1); }
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, rs, pstmt);
		}
		
		return x;
	}
	
	// ȸ������Ʈ ������ �޼ҵ�?
	public List getUsers(int startRow, int endRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List usList = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select * from (select rownum rnum, a.* from (select email, name, pwd, tel, birth, cdate, ip from userlist)"
					+ " a) where rnum between ? and ? order by cdate desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				usList = new ArrayList();
			
				do {
					UserDataBean user = new UserDataBean();
					user.setEmail(rs.getString("email"));
					user.setName(rs.getString("name"));
					user.setPwd(rs.getString("pwd"));
					user.setTel(rs.getString("tel"));
					user.setBirth(rs.getString("birth"));
					user.setCdate(rs.getTimestamp("cdate"));
					user.setIp(rs.getString("ip"));
					usList.add(user);
				} while (rs.next()); 
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(conn, rs, pstmt);
		}
		return usList;
		
	}
	
	// ȸ�� �����Ҷ� ���� �ҷ�����
	public UserDataBean getUser(String email, String pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDataBean user = null;
		String sql = "";
		try {
			conn = getConnection();
			sql="select * from userlist where email = ? and pwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, pwd);
			rs=pstmt.executeQuery();
			
			user = new UserDataBean();
			if(rs.next()) {
				user.setEmail(rs.getString("email"));
				user.setName(rs.getString("name"));
				user.setPwd(rs.getString("pwd"));
				user.setTel(rs.getString("tel"));
				user.setBirth(rs.getString("birth"));
				user.setCdate(rs.getTimestamp("cdate"));
				user.setIp(rs.getString("ip"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, rs, pstmt);
		}
	
		return user;
		
	}
	
	 // �α��ν� ���̵�, ��й�ȣ üũ �޼���
    // ���̵�, ��й�ȣ�� ���ڷ� �޴´�.
    public int loginCheck(String email, String pwd) 
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
 
        String dbPW = ""; // db���� ���� ��й�ȣ�� ���� ����
        int x = -1;
 
        try {
            // ���� - ���� �Էµ� ���̵�� DB���� ��й�ȣ�� ��ȸ�Ѵ�.
            StringBuffer query = new StringBuffer();
            query.append("select pwd from userlist where email=?");
 
            conn = getConnection();
            pstmt = conn.prepareStatement(query.toString());
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
 
            if (rs.next()) // �Էµ� ���̵� �ش��ϴ� ��� �������
            {
                dbPW = rs.getString("pwd"); // ����� ������ �ִ´�.
 
                if (dbPW.equals(pwd)) 
                    x = 1; // �Ѱܹ��� ����� ������ ��� ��. ������ ��������
                else                  
                    x = 0; // DB�� ��й�ȣ�� �Է¹��� ��й�ȣ �ٸ�, ��������
                
            } else {
                x = -1; // �ش� ���̵� ���� ���
            }
 
            return x;
 
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        } finally {
        	 close(conn, null, pstmt);
        }
    } // end loginCheck()
    
    
   /* // �̸��� �ߺ�üũ
    public boolean duplicateIdCheck(String email) {
    	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean x = false;
    	
		try {
            StringBuffer query = new StringBuffer();
            query.append("select email from userlist where email=?");
            
            conn = getConnection();
            pstmt = conn.prepareStatement(query.toString());
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if(rs.next()) x= true; //�ش� �̸��� ����
            
            return x;
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				close(conn, null, pstmt);
			} catch (Exception e2) {
				throw new RuntimeException(e2.getMessage());
			}
		}	
    }*/
    // �̸��� �ߺ�Ȯ�� ver.2
    public boolean confirmEmail(String email) {
    	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
    	boolean result = false;
    	try {
    		conn = getConnection();
    		String sql = "select email from userlist where email =?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, email);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			result = true;
    		}
    	} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, rs, pstmt);
		}
    	return result;
    }
	
    
    public int deleteUser (String email, String pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete from userlist where email=? and pwd=?";
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, pwd);
			x=pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(conn, rs, pstmt);
		}
		return x;
	}
    
    public int updateUser (UserDataBean user) {
		String sql ="";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int chk= 0; // int ���� �ϳ� ����.
		/*ResultSet rs = null; <- �����.(����)*/
		
		try {
			conn = getConnection();
			sql = "update userlist set email=?, name=?, pwd=?, tel=?, birth=? where email=?";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, user.getEmail());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getPwd());
			pstmt.setString(4, user.getTel());
			pstmt.setString(5, user.getBirth());
			pstmt.setString(6, user.getEmail());
			
			chk = pstmt.executeUpdate(); //�÷��� ������Ʈ�� �Ǿ����� ���ڸ� ��ȯ
			/*pstmt.executeUpdate(); <- �����.*/

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, null, pstmt);
		}
		return chk;
		
	}
    
}
