<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>JobGrabber</title>
</head>
<body>
<h1>hi Admin </h1><br>
<h2>YOu can view all the jobs and users below.</h2>

	<%
	Class.forName("com.mysql.jdbc.Driver"); 
	 PreparedStatement admin2 =null;
    PreparedStatement admin1 =null;
    java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","root"); 
    admin1= con.prepareStatement(
			"select * from jobs ");
	admin2=  con.prepareStatement(
			"select * from user where userType <> 'Admin' ");
    	
	ResultSet res1=admin1.executeQuery(); 
   %>
   <form>
   <input type="text" name="Jobid" placeholder="Enter Job ID"/>
   <input type="submit" name="submitJob"/>
   </form>
   
   <form>
    <table id="applicants" >
    	<tr><th>Job ID</th><th>Title</th><th>Date Posted</th></tr>
    	<%
    	String userType="";
    	while(res1.next()) 
    	{ 
    	 int jid = res1.getInt("id");
    	  %>
         <tr>
    		<td><%= res1.getInt("id") %></td>
    		<td><%= res1.getString("title") %></td>
    		<td><%= res1.getString("datePosted") %></td>
    		<td><input type="submit" name="Jobsubmit" value="search" /></td>
    	</tr><%} %>
    	</table>
    	</form>
    	
    <br><br>
    <%ResultSet res2=admin2.executeQuery(); 
   %>
<%
int jobId=0;
int userId=0;
int jresult=0,uresult=0;
String email=request.getParameter("email");

if(request.getParameter("Jobid")!=null){
jobId=Integer.parseInt(request.getParameter("Jobid"));
System.out.println(jobId);
PreparedStatement admin3= con.prepareStatement("delete from jobs where id=?");
admin3.setInt(1,jobId);
jresult =admin3.executeUpdate();
response.sendRedirect("admin.jsp") ;
}

%>


</body>
</html>