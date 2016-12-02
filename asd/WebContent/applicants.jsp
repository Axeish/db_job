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
	id = Integer.parseInt(request.getParameter("id"));	
    
	String email_id = new String();
    email_id = request.getParameter("email"); 


    PreparedStatement dispall =null;
    java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","root"); 

    	
    	
    	
    	
   %> 	<%
   dispall= con.prepareStatement(
    			"select * from jobs where postedBy= ?");
    	System.out.println(id);
    	dispall.setInt(1,id);
    	ResultSet rsap=dispall.executeQuery(); 
    	%>
    	<table border="1">
    	
    	<%
    	while(rsap.next()) 
    	{ 

    	%>
    	<tr>
    		<td><%= rsap.getInt("id") %></td>
    		<td><%= rsap.getString("title") %></td>
    		<td><%= rsap.getString("datePosted") %></td>
    		    	
    	</tr>
    	
    	
    	<%
    	} 
    	
    	
   

%>

<br>


<a href="recruiter.jsp?email=<%=email_id%>">GoBackHome</a>
</body>
</html>