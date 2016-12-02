<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>

<% Class.forName("com.mysql.jdbc.Driver"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%!
public class JobApplied{
	String URL = "jdbc:mysql://localhost:3306/jobportal";
	String USERNAME="root";
	String PASS= "root";
	Connection conn=null;
	PreparedStatement insertjobs =null;
	ResultSet rs=null;
	
	public JobApplied(){
		try {
			conn =DriverManager.getConnection(URL,USERNAME,PASS);
			
			insertjobs= conn.prepareStatement(
					"INSERT INTO `jobApplication`"
					+"(`appliedBy`,`applies`,`accessedBy`)"
					+"VALUES(?,?,?)");

		}
		
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	
	
	
	public int setjobs(int seekerId,int jobid,int postedById)
	{
		int result1=0;
			try{
						
			insertjobs.setInt(1,seekerId);
			insertjobs.setInt(2,jobid);
			insertjobs.setInt(3,postedById);
			System.out.println(seekerId);
			System.out.println(jobid);
			System.out.println(postedById);
;			result1 = insertjobs.executeUpdate();
		}
		catch(SQLException e){
			e.printStackTrace();
		}
			return result1;
			
	}	
}
%>

<%

int result =0;
int id = 0;
int postedBy = 0;
int jobid = 0;

String email= new String();
email = request.getParameter("email");

if (request.getParameter("id")!=null){
	id = Integer.parseInt(request.getParameter("id")); 
}
if (request.getParameter("jobid")!=null){
	jobid = Integer.parseInt(request.getParameter("jobid")); 
}
if (request.getParameter("postedBy")!=null){
	postedBy = Integer.parseInt(request.getParameter("postedBy")); 
}


JobApplied jobs=new JobApplied();

result= jobs.setjobs(id,jobid,postedBy);

%>
<h1>YOU HAVE SUCCESSFULLY APPLIED!!</h1>
<a href="searchJobs.jsp?id=<%=id%>&email=<%=email%>">Search more jobs</a>
<a href="user.jsp?email=<%=email%>">GoBackHome</a><br>

</body>
</html>


