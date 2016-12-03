<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%String title = request.getParameter("title");
String dateposted = request.getParameter("dateposted");
String jobdetails = request.getParameter("jobdetails");
String location = request.getParameter("location");

%>


<%=title %>
<%=dateposted %>
<%=jobdetails %>
</body>
</html>