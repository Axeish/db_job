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
	int id =0;
	id = Integer.parseInt(request.getParameter("id"));	
    
	String email_id = new String();
    email_id = request.getParameter("email"); 


    PreparedStatement dispall =null;
    java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","root"); 

    	
    	
    	
    	
   %> 	<%
   dispall= con.prepareStatement(
    			"select j.id,j.title,j.datePosted,u.name,js.resume_url,js.location from jobs j, user u,jobSeeker js,jobApplication ja where postedBy= ? and j.postedBy =ja.accessedBy and j.id=ja.applies and js.id=ja.appliedBy and u.id=js.id order by ja.applies" );
    	System.out.println(id);
    	dispall.setInt(1,id);
    	ResultSet rsap=dispall.executeQuery(); 
    	%>
    	<table id="applicants" >
    	<tr><th>Job ID</th><th>Title</th><th>Date Posted</th><th>Applicant Name</th><th>Location</th><th>Resume</th></tr>
    	<%
    	while(rsap.next()) 
    	{ 
    	 String resume_url = rsap.getString("resume_url");
    	 
         %>
         
    	<tr>
    		<td><%= rsap.getInt("id") %></td>
    		<td><%= rsap.getString("title") %></td>
    		<td><%= rsap.getString("datePosted") %></td>
    		<td><%= rsap.getString("name") %></td>
       		<td><%= rsap.getString("location") %></td>
    		<td><%=resume_url %></td>
    		    	
    	</tr>
    	
    	
    	<%
    	} 
    	
    	
   

%>
</table>
<br>


<a href="recruiter.jsp?email=<%=email_id%>">GoBackHome</a>
</body>
</html>