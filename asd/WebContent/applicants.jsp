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
<%@ page 	import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream"%>
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
    			"select j.id,j.title,j.datePosted,u.name,js.resume,js.location from jobs j, user u,jobSeeker js,jobApplication ja where postedBy= ? and j.postedBy =ja.accessedBy and j.id=ja.applies and js.id=ja.appliedBy and u.id=js.id order by ja.applies" );
    	System.out.println(id);
    	dispall.setInt(1,id);
    	ResultSet rsap=dispall.executeQuery(); 
    	%>
    	<table border="1">
    	
    	<%
    	while(rsap.next()) 
    	{ 
    	 String fileName = rsap.getString("resume");
         Blob blob = rsap.getBlob("resume");
         byte barr[]=blob.getBytes(1,(int)blob.length());
         FileOutputStream fout=new FileOutputStream("d:\\FILE_NAME.jpg");
         fout.write(barr);

         fout.close();
         }//end of if
         System.out.println("ok");

         con.close();
         catch(Exception e)
         {
        	 e.printStackTrace();
         }
         %>
    	<tr>
    		<td><%= rsap.getInt("id") %></td>
    		<td><%= rsap.getString("title") %></td>
    		<td><%= rsap.getString("datePosted") %></td>
    		<td><%= rsap.getString("name") %></td>
    		<td><%= rsap.getBlob("resume") %></td>
    		<td><%= rsap.getString("location") %></td>
    		    	
    	</tr>
    	
    	
    	<%
    	} 
    	
    	
   

%>

<br>


<a href="recruiter.jsp?email=<%=email_id%>">GoBackHome</a>
</body>
</html>