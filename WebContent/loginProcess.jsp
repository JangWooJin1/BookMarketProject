<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		String url = "jdbc:mysql://localhost:3306/BookMarketDB";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		String sql = "select * from account where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			if(rs.getString("password").equals(pw)){
				if(id.equals("admin")){
					session.setAttribute("isadmin",1);
				}
				else{
					session.setAttribute("isadmin",0);
				}
				response.sendRedirect("books.jsp");
			}
			else{
				response.sendRedirect("./login.jsp?error='true'");
			}

		}
		else{
			response.sendRedirect("./login.jsp?error='true'");
		}
			

	} catch (SQLException ex) {
		out.println("Member 테이블에 삽입이 실패되었습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	
	

	
%>
