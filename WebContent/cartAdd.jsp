<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
	String a_id = (String) session.getAttribute("id");
	String b_id = request.getParameter("b_id");
	if (b_id == null || b_id.trim().equals("")) {
		response.sendRedirect("books.jsp");
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
		
		//먼저 해당 책이 장바구니에 이미 존재하는지 확인
		sql = "select * from cart WHERE account_id = ? AND book_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, a_id);
		pstmt.setString(2, b_id);
		rs = pstmt.executeQuery();
		
		
		if(rs.next()){ //이미 책이 장바구니에 존재한다면 수량값만 1증가
			int quantity = rs.getInt("quantity");
			sql = "UPDATE cart SET quantity=? where account_id = ? AND book_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, quantity+1);
			pstmt.setString(2, a_id);
			pstmt.setString(3, b_id);
			pstmt.executeUpdate();
		}
		else{ //책이 장바구니에 없다면 책 id가 book DB에 존재하는지 확인
			sql = "select * from book where b_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {	//장바구니에 책 추가
				sql = "insert into cart(account_id,book_id,quantity) values(?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, a_id);
				pstmt.setString(2, b_id);
				pstmt.setInt(3, 1);
				pstmt.executeUpdate();
			}
			else{	//(예외처리)book DB에 해당 책 id가 없는 경우
				response.sendRedirect("exceptionNoBookId.jsp");
			}	
		}
	} catch (SQLException ex) {
		out.println("DB 탐색이 실패하였습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}

	response.sendRedirect("book.jsp?id=" + b_id);
%>