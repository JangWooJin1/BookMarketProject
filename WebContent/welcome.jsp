<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Welcome</title>
</head>
<body>	
	<%@ include file="menu.jsp"%>
	<%! String greeting = "도서 웹 쇼핑몰";
	String tagline = "Welcome to Web Market!"; %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">
				<%=greeting%>
			</h1>
		</div>
	</div>
	<main role="main">
	<div class="container">
		<div class="text-center">
			<h3>
				<%=tagline%>
			</h3>			
		</div>
		<hr>
	</div>
	</main>
	<%@ include file="footer.jsp"%>
</body>
</html>