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
	Class.forName("com.mysql.jdbc.Driver"); 
	int id =0;
	PreparedStatement disprec =null;
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","root"); 
	Statement st= con.createStatement(); 
	ResultSet rs=st.executeQuery("select * from user where email_id='" + request.getParameter("email") + "'"); 
	
	
	if(rs.next()) 
	{  
		id = rs.getInt("id");
		%>
	<h3> Hi, <%= rs.getString("name") %></h3><br>
		<p> Welcome to JobGrabber <p><br><hr>
	<h5>Your profile details:</h5>
	<table>
	<tr><td>Name: </td> <td><%= rs.getString("name") %></td></tr>
	<tr><td>Email: </td> <td><%= rs.getString("email_id") %></td></tr>
	<tr><td>Gender: </td> <td><%= rs.getString("gender") %></td></tr>
	<tr><td>Date of Birth: </td> <td><%= rs.getString("dateofbirth") %></td></tr>
	
		
	

	<%	
	}
	
	disprec= con.prepareStatement(
			"select * from recruiter where id= ?");
	System.out.println(id);
	disprec.setInt(1,id);
	ResultSet rs1=disprec.executeQuery(); 
	if(rs1.next()) 
	{ 

	%>
	<tr><td>Company: </td> <td><%= rs1.getString("company") %></td></tr>
	
	
	<%
	} %>
	</table>
	<form name="jobs" action="jobs.jsp?id="+<%=id %>  method="POST">
	
		<input type="submit" value="Add Jobs" name="submit"><br>
	</form>
	<a href="jobs.jsp?id=<%=id%>>Go!</a>

<form name="applicants" action="applicants.jsp" method="POST">
<input type="submit" value="View Applicants" name="onsubmit">
</form>
</body>
</html>