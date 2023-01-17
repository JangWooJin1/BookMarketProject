<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Book"%>
<%@ page import="dao.BookRepository"%>
<%@ page errorPage="exceptionNoBookId.jsp"%>
<%@ page import="java.sql.*"%>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<title>도서 정보</title>
<script type="text/javascript">
	function addToCart() {

		if (confirm("도서를 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit();
		} else {

			document.addForm.reset();
		}
	}
</script>
</head>
<body>
	<jsp:include page="./menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">도서 정보</h1>
		</div>
	</div>
	<%
		String id = request.getParameter("id");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String url = "jdbc:mysql://localhost:3306/BookMarketDB";
			String user = "root";
			String password = "1234";
	
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
	
			String sql = "select * from book WHERE b_id='"+id+"'";
			pstmt = conn.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
			while (rs.next()) {
	%>
		
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<img src="c:/upload/<%=rs.getString("b_fileName")%>" style="width: 100%" />
			</div>
			<div class="col-md-8">
				<h4><b>[<%=rs.getString("b_category")%>]<%=rs.getString("b_name")%></b></h4>
				<p><%=rs.getString("b_description")%>
				<p><b>도서코드 : </b><span class="badge badge-danger"> <%=rs.getString("b_id")%></span>						
				<p><b>저자</b> : <%=rs.getString("b_author")%>				
				<p><b>출판사</b> : <%=rs.getString("b_publisher")%>
				<p><b>출판일</b> : <%=rs.getString("b_releaseDate")%>		
				<p><b>총 페이지수</b> : <%=rs.getString("b_totalPages")%>			
				<p><b>재고수</b> : <%=rs.getString("b_unitsInStock")%>				
				<h4><%=rs.getString("b_unitPrice")%>원</h4>
				<p><form name="addForm" 
					action="./cartAdd.jsp?id=<%=rs.getString("b_id")%>"
					method="post">
					<a href="#" class="btn btn-info" onclick="addToCart()"> 장바구니 추가
						&raquo;</a> <a href="./books.jsp" class="btn btn-secondary">
						도서목록 &raquo;</a>
				</form>
			</div>
		</div>
		<hr>
	</div>
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
	<jsp:include page="./footer.jsp" />
</body>
</html>
