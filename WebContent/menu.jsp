<%@ page contentType="text/html; charset=utf-8" %>
<nav class="navbar navbar-expand  navbar-dark bg-dark">
			<% 
				int isadmin = (int) session.getAttribute("isadmin");
			%>

		<div class="container">			
			<div class="navbar-header">
				<% 
					if (isadmin != -1)
					{
						String id = (String) session.getAttribute("id");
				%>
				<span class="navbar-brand" ><%=id%>님 환영합니다!</span>
				<% 
					}
				%>
			</div>
		</div>	
		<div>
			<ul class="navbar-nav mr-auto">
			
			<% 
				if (isadmin == -1)
				{
			%>
			
				<li class="nav-item"><a class="nav-link" href="./login.jsp">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="./signUp.jsp">회원가입</a></li>
			<%
				}
			%>
				<li class="nav-item"><a class="nav-link" href="./books.jsp">도서목록</a></li>
			<% 
				if (isadmin == 1)
				{
			%>
				<li class="nav-item"><a class="nav-link" href="./bookAdd.jsp">도서등록</a></li>
				<li class="nav-item"><a class="nav-link" href="./bookEdit.jsp?edit=update">도서수정</a></li>
				<li class="nav-item"><a class="nav-link" href="./bookEdit.jsp?edit=delete">도서삭제</a></li>
			<%
				}
			%>
			<% 
				if (isadmin != -1)
				{
			%>
				<li class="nav-item"><a class="nav-link" href="./cart.jsp">장바구니</a></li>
				<li class="nav-item"><a class="nav-link" href="./logout.jsp">로그아웃</a></li>
			<%
				}
			%>
			</ul>
		</div>
		
	</nav>
