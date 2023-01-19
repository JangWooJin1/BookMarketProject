<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<title>주문완료</title>
</head>
<body>
	<%
		String shipping_name = "";
		String shipping_zipCode = "";
		String shipping_addressName = "";
		String shipping_shippingDate ="";
		String book_ids="";
		String quantitys="";
		
		Cookie[] cookies = request.getCookies();
	
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if (n.equals("Shipping_name"))
					shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				else if (n.equals("Shipping_zipCode"))
					shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				else if (n.equals("Shipping_addressName"))
					shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				else if (n.equals("shipping_shippingDate"))
					shipping_shippingDate = thisCookie.getValue();
				else if (n.equals("book_ids"))
					book_ids = thisCookie.getValue();
				else if (n.equals("quantitys"))
					quantitys = thisCookie.getValue();
	
			}
		}
	%>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">주문완료</h1>
		</div>
	</div>
	<div class="container">
		<h2 class="alert alert-danger">주문해 주셔서 감사합니다.</h2>
		<p>
			주문은	<%	out.println(shipping_shippingDate);	%>
			에 배송될 예정입니다! !	
	</div>
	<div class="container">
		<p>
			<a href="./books.jsp" class="btn btn-secondary"> &laquo; 상품목록</a>
		</p>
	</div>
</body>
</html>
<%
	request.setCharacterEncoding("UTF-8");
	
	String a_id = (String) session.getAttribute("id");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String url = "jdbc:mysql://localhost:3306/BookMarketDB";
		String user = "root";
		String password = "1234";
	
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
	
		String sql = "insert into receipt(account_id,name,zipCode,addressName,shippingDate,book_ids,quantitys) values(?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, a_id);
		pstmt.setString(2, shipping_name);
		pstmt.setString(3, shipping_zipCode);
		pstmt.setString(4, shipping_addressName);
		pstmt.setString(5, shipping_shippingDate);
		pstmt.setString(6, book_ids);
		pstmt.setString(7, quantitys);
	
		pstmt.executeUpdate();
	
	} catch (SQLException ex) {
		out.println("DB연결 실패.<br>");
		out.println("SQLException: " + ex.getMessage());
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}

	for (int i = 0; i < cookies.length; i++) {
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		
		if (n.equals("Shipping_name"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_shippingDate"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_country"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_zipCode"))
			thisCookie.setMaxAge(0);
		else if (n.equals("Shipping_addressName"))
			thisCookie.setMaxAge(0);
		else if (n.equals("book_ids"))
			thisCookie.setMaxAge(0);
		else if (n.equals("quantitys"))
			thisCookie.setMaxAge(0);
		
		response.addCookie(thisCookie);
	}
%>
