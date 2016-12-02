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
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","Amma@123"); 
	Statement st= con.createStatement();
	int id=0;
	ResultSet rs=st.executeQuery("select * from user where email_id='" + request.getParameter("email") + "'"); 
	if(rs.next()) 
	{  
		id=rs.getInt("id");
		%>
	<h3> Hi, <%= rs.getString("name") %></h3><br>
		<p> Welcome to JobGrabber <p><br><hr>
	<h5>Your profile details:</h5>
	<table>
	<tr><td>Name: </td> <td><%= rs.getString("name") %></td></tr>
	<tr><td>Email: </td> <td><%= rs.getString("email_id") %></td></tr>
	<tr><td>Gender: </td> <td><%= rs.getString("gender") %></td></tr>
	<tr><td>Date of Birth: </td> <td><%= rs.getString("dateofbirth") %></td></tr>
	
	</table>	
	
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
	<table>
	<tr><td>Phone: </td> <td><%= rs1.getString("phoneNumber") %></td></tr>
	<tr><td>Location: </td> <td><%= rs1.getString("location") %></td></tr>
	</table>
	<%	
	}
	%>
	<form name="jobapp" action="searchJobs.jsp?id=<%=id %>" method="POST">
	<table border=1>
		<tr>
		<td>Search Jobs : </td>
		<td><input type="text" name="searchJobs" /></td>
		<td><input type="submit" name="submit" value="search" /></td>
        </tr>
        </table>
</form>
</body>
</html>