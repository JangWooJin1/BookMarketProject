<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Book"%>
<%@ page import="dao.BookRepository"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<%
	String cartId = session.getId();
%>
<title>Cart</title>
</head>
<body>
	<jsp:include page="./menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./cartDelete.jsp?cartId=<%=cartId%>"
						class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="./shippingInfo.jsp?cartId=<%= cartId %>" class="btn btn-success">주문하기</a></td>		
					</a></td>
				</tr>
			</table>

		</div>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%				
					String a_id = (String) session.getAttribute("id");
				
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					ResultSet rs2 = null;
	
					Book book = new Book();
					String b_id;
					int sum = 0;
					try {
						String url = "jdbc:mysql://localhost:3306/BookMarketDB";
						String user = "root";
						String password = "1234";
	
						Class.forName("com.mysql.jdbc.Driver");
						conn = DriverManager.getConnection(url, user, password);
	
						String sql;
						
						sql = "select * from cart WHERE account_id = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, a_id);
						rs = pstmt.executeQuery();
						
						while(rs.next()){
							book.setQuantity(rs.getInt("quantity"));
							b_id = rs.getString("book_id");	
							
							sql = "select * from book where b_id = ?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, b_id);
							rs2 = pstmt.executeQuery();
							if (rs2.next()) {
								sum += rs2.getInt("b_unitPrice") * rs.getInt("quantity");
							
				%>
								<tr>
									<td><%=rs2.getString("b_id")%> - <%=rs2.getString("b_name")%></td>
									<td><%=rs2.getInt("b_unitPrice")%></td>
									<td><%=rs.getInt("quantity")%></td>
									<td><%= rs2.getInt("b_unitPrice") * rs.getInt("quantity")%></td>
									<td><a href="./cartRemove.jsp?id=<%=rs2.getString("b_id")%>"
										class="badge badge-danger">삭제</a></td>
								</tr>
				<%
							}
						}
					} catch (SQLException ex) {
						out.println("book DB 탐색이 실패하였습니다.<br>");
						out.println("SQLException: " + ex.getMessage());
					} finally {
						if (pstmt != null)
							pstmt.close();
						if (conn != null)
							conn.close();
					}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>
			<a href="./books.jsp" class="btn btn-secondary"> &laquo; 쇼핑
				계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page="./footer.jsp" />
</body>
</html>
