<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String shipping_shippingDate = sdf.format(c1.getTime());

	Cookie name = new Cookie("Shipping_name", URLEncoder.encode(request.getParameter("name"), "utf-8"));
	Cookie zipCode = new Cookie("Shipping_zipCode",
			URLEncoder.encode(request.getParameter("zipCode"), "utf-8"));
	Cookie addressName = new Cookie("Shipping_addressName",
			URLEncoder.encode(request.getParameter("addressName"), "utf-8"));
	Cookie shippingDate = new Cookie("shipping_shippingDate", shipping_shippingDate);
	
	
	
	name.setMaxAge(365 * 24 * 60 * 60);
	zipCode.setMaxAge(365 * 24 * 60 * 60);
	addressName.setMaxAge(365 * 24 * 60 * 60);
	shippingDate.setMaxAge(365 * 24 * 60 * 60);

	response.addCookie(name);
	response.addCookie(zipCode);
	response.addCookie(addressName);
	response.addCookie(shippingDate);

	response.sendRedirect("orderConfirmation.jsp");
%>
