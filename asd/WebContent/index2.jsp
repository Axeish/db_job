<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import='java.security.NoSuchAlgorithmException'%>   
    
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
<h1>Job Applications</h1>

<%!
public class Jobs{
	String URL = "jdbc:mysql://localhost:3306/jona";
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
					+"(`name`,`password`,`email_id`,`gender`)"
					+"VALUES(?,?,?,?)");

		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	public int setJobs(String name, String password, String email_id, String gender){
		int result =0;
		String md5 = null;
		try{
			/*try{
				
				MessageDigest alg = MessageDigest.getInstance("MD5");
				alg.reset();
		        alg.update(dateposted.getBytes());
		        byte[] msgDigest = alg.digest();
		        md5 = new BigInteger(1, msgDigest).toString(16);

		       
		        
			}catch(NoSuchAlgorithmException e){
		        e.printStackTrace();
		    }*/
			
			insertjob.setString(1,name);
			insertjob.setString(2,password);
			insertjob.setString(3,email_id);
			insertjob.setString(4,gender);
			result = insertjob.executeUpdate();
			
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		
		return result;
	}
}
%><%
int result =0;
String name = new String();
String password = new String();
String email_id = new String();
String gender = new String();

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

Jobs jobs=new Jobs();

result = jobs.setJobs(name,password,email_id,gender);
%>

<form name="jobapp" action="index.jsp" method="POST">
name: <input type="text" value="name" name="name" >
Date Posted:<input type="text" value="" name= "password" >
job Details:<input type="text" value="" name="email_id" >
Location:<input type="text" value=""  name="gender">
<input type="reset" value="clear" name="clear">
<input type="submit" value="submit" name="submit">

</form>
</body>
</html>