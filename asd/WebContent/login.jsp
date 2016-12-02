<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%@ page import="java.util.*"%>
	<%
String email=request.getParameter("email"); 
session.putValue("email",email); 
String password=request.getParameter("password"); 
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","root"); 
Statement st= con.createStatement(); 
ResultSet rs=st.executeQuery("select * from user where email_id='" + email + "'"); 
if(rs.next()) 
{
%>
<% if(rs.getString(3).equals(password) && rs.getString(7).equals("JobSeeker")) { 
	
	response.sendRedirect("user.jsp?email="+email) ;
	
    }
	else if(rs.getString(3).equals(password) && rs.getString(7).equals("Recruiter")){
		response.sendRedirect("recruiter.jsp?email="+email) ;
	}
	else if(rs.getString(3).equals(password) && rs.getString(7).equals("Admin"))
    {
		response.sendRedirect("admin.jsp?email="+email) ;
    }
    %>
    <%
    }
    else out.println("INVALID EMAIL and PASSWORD");
     %>

<a href="index.html">Home</a>
</body>
</html>