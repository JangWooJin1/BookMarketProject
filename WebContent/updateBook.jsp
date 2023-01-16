<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<title>상품 수정</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>

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

			String sql = "select * from book where b_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<img src="c:/upload/<%=rs.getString("b_filename")%>" alt="image"
					style="width: 100%" />
			</div>
			<div class="col-md-8">
				<form name="newBook" action="./processUpdateBook.jsp"
					class="form-horizontal" method="post" enctype="multipart/form-data">
		<div class="form-group row">
				<label class="col-sm-3">도서ID</label>
				<div class="col-sm-5">
					<input type="text" id="bookId" name="bookId" class="form-control" value='<%=rs.getString("b_id")%>'>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">도서명</label>
				<div class="col-sm-5">
					<input type="text"  id="name" name="name" class="form-control" value='<%=rs.getString("b_name")%>'>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">가격</label>
				<div class="col-sm-5">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control" value='<%=rs.getString("b_unitPrice")%>'>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">저자</label>
				<div class="col-sm-5">
					<input type="text" name="author" class="form-control" value='<%=rs.getString("b_author")%>'>
				</div>
			</div>
				<div class="form-group row">
				<label class="col-sm-3">출판사</label>
				<div class="col-sm-5">
					<input type="text" name="publisher" class="form-control" value='<%=rs.getString("b_publisher")%>'>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">출판일</label>
				<div class="col-sm-5">
					<input type="text" name="releaseDate" class="form-control" value='<%=rs.getString("b_releaseDate")%>'>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">총 페이지수</label>
				<div class="col-sm-5">
					<input type="text" name="totalPages" class="form-control" value='<%=rs.getString("b_totalPages")%>'>
				</div>
			</div>			
			<div class="form-group row">
				<label class="col-sm-3">상세설명</label>
				<div class="col-sm-7">
					<textarea name="description" cols="50" rows="2"
						class="form-control" placeholder="100자 이상 적어주세요"><%=rs.getString("b_description")%></textarea>
				</div>
			</div>			
			<div class="form-group row">
				<label class="col-sm-3">분류</label>
				<div class="col-sm-5">
					<input type="text" name="category" class="form-control" value='<%=rs.getString("b_category")%>'>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">재고수</label>
				<div class="col-sm-5">
					<input type="text"  id="unitsInStock" name="unitsInStock" class="form-control" value='<%=rs.getString("b_unitsInStock")%>'>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">상태</label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New " > 신규도서
					<input type="radio" name="condition" value="Old" > 중고도서
					<input type="radio" name="condition" value="EBook" > E-Book
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-3">이미지 </label>
				<div class="col-sm-5">
					<input type="file" name="bookImage" class="form-control">
				</div>
			</div>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10 ">
							<input type="submit" class="btn btn-primary" value="등록">
						</div>
					</div>
				</form>

			</div>
		</div>
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

</body>
</html>
