<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>


<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<title>도서 목록</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">도서 목록</h1>
		</div>
	
	</div>
	      
	<div class="container">	
	<%
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
					while (rs.next()) {
			%>
		<div class="row" >
			<div class="col-md-3" align="center">	
			<img src="c:/upload/<%=rs.getString("b_fileName")%>" style="width: 50%">
			</div>			
			<div class="col-md-7">	
				<p><h5 ><b>[<%=rs.getString("b_category")%>] <%=rs.getString("b_name")%></b></h5>
				<p style="padding-top: 20px"><%=rs.getString("b_description").substring(0, 100)%>... 
				<p><%=rs.getString("b_author")%> | <%=rs.getString("b_publisher")%> | <%=rs.getString("b_unitPrice")%>원
			</div>	
			<div class="col-md-2"  style="padding-top: 70px">						    			 
				<a href="./book.jsp?id=<%=rs.getString("b_id")%>" class="btn btn-secondary" role="button"> 상세정보 &raquo;></a>
				
			</div>				
		</div>
		<hr>
		<%
					}
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
			%>
	</div>	
	<jsp:include page="footer.jsp" />
</body>
</html>
