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
	int postedBy=0;
	ResultSet rs=st.executeQuery("select * from jobs where title ='" + request.getParameter("searchJobs") + "'"); 
	while(rs.next()) 
	{ 
		id= rs.getInt("id");
		postedBy= rs.getInt("postedBy");

	%>
	<table>
	<tr><td>TITLE: </td> <td>  <%= rs.getString("title") %></td></tr>
	<tr><td>Date Posted: </td> <td><%= rs.getString("datePosted") %></td></tr>
	<tr><td>Location: </td> <td><%= rs.getString("jobLocation") %></td></tr>
	<tr><td><a href="applyJobs.jsp?id=<%=request.getParameter("id")%>&Jobid=<%=id%>&postedBy=<%=postedBy%>&searchJobs=<%=request.getParameter("searchJobs")%>">
	Apply job</a></td></tr>
	</table>
	<%	
	}
	%>

</body>
</html>