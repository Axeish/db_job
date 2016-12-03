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
<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%@ page import="java.util.*"%>
	<%
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","root"); 
	Statement st= con.createStatement();
	int id=0;
	String email = new String();
	
	ResultSet rs=st.executeQuery("select * from user where email_id='" + request.getParameter("email") + "'"); 
	if(rs.next()) 
	{  
		id=rs.getInt("id");
		email = rs.getString("email_id");
		%>
	<h3> Hi, <%= rs.getString("name") %></h3><br>
		<h2> Welcome to JobGrabber <h2><br><hr>
	<h2>Your profile details:</h2>
	<table>
	<tr><td width="30%" class="tith">Name</td> <td width="70%"><%= rs.getString("name") %></td></tr>
	<tr><td class="tith">Email </td> <td><%= email %></td></tr>
	<tr><td class="tith">Gender </td> <td><%= rs.getString("gender") %></td></tr>
	<tr><td class="tith">Date of Birth </td> <td><%= rs.getString("dateofbirth") %></td></tr>
	
		
	
	<%	
	}

	%>
<%	
PreparedStatement selectUser= con.prepareStatement(
		"Select * from `jobseeker` where id=?");
selectUser.setInt(1,id);
ResultSet rs1=selectUser.executeQuery(); 
if(rs1.next()) 
	{ 

	%>
	
	<tr><td class="tith">Phone </td> <td><%= rs1.getString("phoneNumber") %></td></tr>
	<tr><td class="tith">Location </td> <td><%= rs1.getString("location") %></td></tr>
	<tr><td class="tith">Profile url </td> <td><%= rs1.getString("resume_url") %></td></tr>
	</table>
	<%	
	}
	%>
	<a href="searchJobs.jsp?id=<%=id%>&email=<%=email%>">Search job</a><br><br>
	<a href="index.html">Logout</a>
	
</body>
</html>