<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
	String a_id = (String) session.getAttribute("id");
	String b_id = request.getParameter("b_id");
	
	if (b_id == null || b_id.trim().equals("")) {
		response.sendRedirect("cart.jsp");
		return;
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		String url = "jdbc:mysql://localhost:3306/BookMarketDB";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		String sql;
		
		if(b_id.equals("all")){
			//먼저 해당 책이 장바구니에 이미 존재하는지 확인
			sql = "delete from cart WHERE account_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, a_id);
			pstmt.executeUpdate();
		}
		else{
			//먼저 해당 책이 장바구니에 이미 존재하는지 확인
			sql = "delete from cart WHERE account_id = ? AND book_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, a_id);
			pstmt.setString(2, b_id);
			pstmt.executeUpdate();
		}
		
	} catch (SQLException ex) {
		out.println("cart DB 탐색이 실패하였습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}

	response.sendRedirect("cart.jsp");
%>