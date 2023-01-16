<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<%
	String bookId = request.getParameter("id");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		String url = "jdbc:mysql://localhost:3306/BookMarketDB";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		String sql = "select * from book";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			sql = "delete from book where b_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookId);
			pstmt.executeUpdate();
		} else
			out.println("일치하는 상품이 없습니다");
	} catch (SQLException ex) {
		out.println("데이터베이스 접속이 실패되었습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	response.sendRedirect("editBook.jsp?edit=delete");
%>
