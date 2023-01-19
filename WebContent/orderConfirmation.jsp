<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	
	Cookie[] cookies = request.getCookies();

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_name"))
				shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			else if (n.equals("shipping_shippingDate"))
				shipping_shippingDate = thisCookie.getValue();
			else if (n.equals("Shipping_zipCode"))
				shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			else if (n.equals("Shipping_addressName"))
				shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");

		}
	}
%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<title>주문정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">주문정보</h1>
		</div>
	</div>

	<div class="container col-8 alert alert-info">
		<div class="text-center ">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br> 성명 : <% out.println(shipping_name); %>	<br> 
				우편번호 : <% 	out.println(shipping_zipCode);%><br> 
				주소 : <%	out.println(shipping_addressName);%> <br>
			</div>
			<div class="col-4" align="right">
				<p>	<em>배송일: <% out.println(shipping_shippingDate);	%></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">			
			<tr>
				<th class="text-center">도서</th>
				<th class="text-center">수량</th>
				<th class="text-center">가격</th>
				<th class="text-center">소계</th>
			</tr>
			<%
			String a_id = (String) session.getAttribute("id");
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ResultSet rs2 = null;

			String b_id;
			String book_ids="";
			String quantitys="";
			int sum = 0;
			int total;
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
					b_id = rs.getString("book_id");	
					
					sql = "select * from book where b_id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, b_id);
					rs2 = pstmt.executeQuery();
					if (rs2.next()) {
						total = rs2.getInt("b_unitPrice") * rs.getInt("quantity");
						sum += rs2.getInt("b_unitPrice") * rs.getInt("quantity");
						book_ids += b_id + "/";
						quantitys += rs.getInt("quantity") + "/";
			
			%>
						<tr>
							<td class="text-center"><em><%=rs2.getString("b_name")%> </em></td>
							<td class="text-center"><%=rs.getInt("quantity")%></td>
							<td class="text-center"><%=rs2.getInt("b_unitPrice")%>원</td>
							<td class="text-center"><%=total%>원</td>
						</tr>
			<%
					}
				}
				
				Cookie BookIds = new Cookie("book_ids", book_ids);
				Cookie Quantitys = new Cookie("quantitys", quantitys);
				
				BookIds.setMaxAge(365 * 24 * 60 * 60);
				response.addCookie(BookIds);
				Quantitys.setMaxAge(365 * 24 * 60 * 60);
				response.addCookie(Quantitys);
				
				
			} catch (SQLException ex) {
				out.println("DB 탐색이 실패하였습니다.<br>");
				out.println("SQLException: " + ex.getMessage());
			} finally {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			}
			%>
			<tr>
				<td> </td>
				<td> </td>
				<td class="text-right">	<strong>총액: </strong></td>
				<td class="text-center text-danger"><strong><%=sum%> </strong></td>
			</tr>
			</table>
			
				<a href="./shippingInfo.jsp"class="btn btn-secondary" role="button"> 이전 </a>
				<a href="./thankCustomer.jsp"  class="btn btn-success" role="button"> 주문완료 </a>
				<a href="./checkOutCancelled.jsp" class="btn btn-secondary"	role="button"> 취소 </a>
			
		</div>
	</div>	
</body>
</html>
