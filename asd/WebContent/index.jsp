<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import='java.security.NoSuchAlgorithmException'%>   
<%@page import='java.text.*'%>       
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@ page import="java.util.Date" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%!
public class Jobs{
	String URL = "jdbc:mysql://localhost:3306/jobportal";
	String USERNAME="root";
	String PASS= "root";
	Connection conn=null;
	PreparedStatement insertjob =null;
	ResultSet rs=null;
	
	public Jobs(){
		try {
			conn =DriverManager.getConnection(URL,USERNAME,PASS);
			insertjob= conn.prepareStatement(
					"INSERT INTO `user`"
					+"(`name`,`password`,`email_id`,`gender`,`dateOfBirth`,userType)"
					+"VALUES(?,?,?,?,?,?)");

		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	public int setJobs(String name, String password, String email_id, String gender, java.sql.Date dob, String userType){
		int result =0;
		String md5 = null;
		try{
			try{
				
				MessageDigest alg = MessageDigest.getInstance("MD5");
				alg.reset();
		        alg.update(password.getBytes());
		        byte[] msgDigest = alg.digest();
		        md5 = new BigInteger(1, msgDigest).toString(16);

		       
		        
			}catch(NoSuchAlgorithmException e){
		        e.printStackTrace();
		    }
			
			System.out.println("VAlue" + userType);
			
			insertjob.setString(1,name);
			insertjob.setString(2,password);
			insertjob.setString(3,email_id);
			insertjob.setString(4,gender);
			insertjob.setDate(5,dob);
			insertjob.setString(6,userType);
			result = insertjob.executeUpdate();
			
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
String name = new String();
String password = new String();
String email_id = new String();
String gender = new String();
String userType = new String();
SimpleDateFormat f= new SimpleDateFormat("dd/MM/yyyy");
java.sql.Date dateofbirth=null;



if (request.getParameter("name")!=null){
	name = request.getParameter("name"); 
}
if (request.getParameter("password")!=null){
	password = request.getParameter("password"); 
}
if (request.getParameter("email_id")!=null){
	email_id = request.getParameter("email_id"); 
}
if (request.getParameter("gender")!=null){
	gender = request.getParameter("gender"); 
}

if (request.getParameter("dateOfBirth")!=null){
	String dob = request.getParameter("dateOfBirth");
	Date parsed = f.parse(dob);
    dateofbirth = new java.sql.Date(parsed.getTime());
}

if (request.getParameter("userType")!=null){
	userType = request.getParameter("userType"); 
	System.out.println("value"+userType);
}

Jobs jobs=new Jobs();

result = jobs.setJobs(name,password,email_id,gender,dateofbirth,userType);

%>
<%
if(request.getParameter("userType").equals("JobSeeker")) {
        %>
        <%@include  file="user.html" %>
        <%
            }
%>
<% 		if(request.getParameter("userType").equals("Recruiter")) {
			%>
        <%@include  file="recruiter.html" %>
        <%
            }
%>
 <%       if(request.getParameter("userType").equals("Admin")) {
        %>
        <%@include  file="admin.html" %>
        <%
            }
         %>
        
</body>
</html>