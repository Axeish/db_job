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
<h2>Adding new jobs</h2>
<h4>Please fill the details of the new job</h4><hr>
<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%@ page import="java.util.*"%>
	<%@page import='java.text.*'%>   
	<%
	Class.forName("com.mysql.jdbc.Driver"); %>
	<%@ page import="java.util.Date" %>  


<%!
public class NewJob{

	String URL = "jdbc:mysql://localhost:3306/jobportal";

	String USERNAME="root";
	String PASS= "root";
	Connection conn=null;
	PreparedStatement insertnjob =null;
	ResultSet rs=null;
	
	public NewJob(){
		try {
			conn =DriverManager.getConnection(URL,USERNAME,PASS);
			insertnjob= conn.prepareStatement(
			"INSERT INTO `jobportal`.`jobs`(`id`,`postedBy`,`title`,`datePosted`,`jobDetail`,`jobLocation`)"
			+"VALUES(?,?,?,?,?,?)");


		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	public int setJobs(int id, int postedby, String title, java.sql.Date datePosted, String jobDetail, String jobLocation){
		int result =0;
	
		try{	
			insertnjob.setInt(1,id);
			insertnjob.setInt(2,postedby);
			insertnjob.setString(3,title);
			insertnjob.setDate(4,datePosted);
			insertnjob.setString(5,jobDetail);
			insertnjob.setString(6,jobLocation);
			result = insertnjob.executeUpdate();
			
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		
		return result;
	}
}
	%>
	<%
	int result =0;
	int jid =0;
	
int postedby = Integer.parseInt(request.getParameter("id"));
String title = new String();
String jobDetail = new String();
String email_id = new String();
email_id = request.getParameter("email");
String jobLocation = new String();
SimpleDateFormat f= new SimpleDateFormat("dd/MM/yyyy");
java.sql.Date datePosted=null;

if (request.getParameter("jid")!=null){
	jid = Integer.parseInt(request.getParameter("jid")); 
}

if (request.getParameter("title")!=null){
	title = request.getParameter("title"); 
}
if (request.getParameter("jobDetails")!=null){
	jobDetail = request.getParameter("jobDetails"); 
}
if (request.getParameter("jobLocations")!=null){
	jobLocation = request.getParameter("jobLocations"); 
}
if (request.getParameter("datePosted")!=null){
	String dp = request.getParameter("datePosted");
	Date parsed = f.parse(dp);
	datePosted = new java.sql.Date(parsed.getTime());

 
}
if (request.getParameter("title")!=null){
NewJob jobs=new NewJob();

result = jobs.setJobs(jid, postedby,title, datePosted,jobDetail,jobLocation);
if (result==1){
	
%>	<h2> Successfully added new job </h2> <%
}
}
%>




     <form name="jobs" action="jobs.jsp?id=<%=postedby%>&email=<%=email_id %>" method="POST">
     
     <table><tr><td width="30%">JobId</td><td width="70%"><input type="number"  name="jid" ></td></tr>
     <tr><td >Title</td><td width="70%"><input type="text"  name= "title" ></td></tr>
     <tr><td ">DatePosted</td><td width="70%"><input type="text" value="" name="datePosted" ></td></tr>
     <tr><td >JobDetail</td><td width="70%" height="200px"><textarea rows="9" cols="30" name="jobDetails"></textarea></td></tr>
     <tr><td >Location</td><td width="70%"><input type="text" value="" name="jobLocations" ><br><br></td></tr>
    	
	</table>
		<input type="reset" value="clear" name="clear">
	<input type="submit" value="submit" name="submit1">

</form><br><br>
	<a href="recruiter.jsp?email=<%=email_id%>">GoBackHome</a><br><br>
	   <a href="applicants.jsp?id=<%=postedby%>&email=<%=email_id%>">View all Applicants of jobs posted by me </a>
	    
</body>
</html>