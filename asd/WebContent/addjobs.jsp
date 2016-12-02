<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
    
<%@page import='java.text.*'%>       
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@ page import="java.util.Date" %>    

<% String id = request.getParameter("id");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

public class newJob{
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
	
</body>
</html>