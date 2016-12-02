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
		System.out.println(id);
		System.out.println(postedby);
		System.out.println(title);
		System.out.println(datePosted);
		System.out.println(jobDetail);
		System.out.println(jobLocation);
		System.out.println("id");
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
}
%>




     <form name="jobs" action="jobs.jsp?id=<%=postedby%>&email=<%=email_id %>" method="POST">
    JobId:     <input type="text"  name="jid" ><br><br>
	Title: <input type="text"  name= "title" ><br><br>
	DatePosted:    <input type="text" value="" name="datePosted" ><br><br>
	JobDetail: <textarea name="jobDetails">Enter text here...</textarea><br><br>
	Location:    <input type="text" value="" name="jobLocations" ><br><br>
		<input type="reset" value="clear" name="clear">
	<input type="submit" value="submit" name="submit1">

</form>
	<a href="recruiter.jsp?email=<%=email_id%>">GoBackHome</a><br>
	   <a href="applicants.jsp?id=<%=postedby%>&email=<%=email_id%>">View all Applicants of jobs posted by me </a>
</body>
</html>