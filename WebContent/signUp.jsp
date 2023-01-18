<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<title>Login</title>
<script>
function CheckUser() {
	
	var id = document.getElementById("id");
	var pw = document.getElementById("pw");
	var pwcheck = document.getElementById("pwcheck");
	
	// 상품명 체크
	if (pw.value != pwcheck.value) {
		alert("비밀번호 확인이 다릅니다.");
		pwcheck.select();
		pwcheck.focus();
		return false;
	}
	 document.signup.submit()
	 alert("회원가입이 완료되었습니다.");
}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">회원가입</h1>
		</div>
	</div>
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Sign Up</h3>
			<%
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요");
					out.println("</div>");
				}
			%>
			<form name="signup" class="form-signin" action="./signUpProcess.jsp" method="post">

				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label> <input
						type="text" class="form-control" placeholder="ID" id="id"
						name='id' required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> <input
						type="password" class="form-control" placeholder="Password" id="pw"
						name='pw' required>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">PasswordCheck</label> <input
						type="password" class="form-control" placeholder="PasswordCheck" id="pwcheck"
						name='pwcheck' required>
				</div>
				<input type="button" class="btn btn btn-lg btn-success btn-block" value="회원가입" onclick="CheckUser()">
			</form>
		</div>
	</div>
</body>
</html>