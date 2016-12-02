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
	PreparedStatement insertuser =null;
	PreparedStatement insertjobSeeker =null;
	PreparedStatement insertrecruiter =null;
	PreparedStatement selectUser =null;
	ResultSet rs=null;
	
	public Jobs(){
		try {
			conn =DriverManager.getConnection(URL,USERNAME,PASS);
			
			insertuser= conn.prepareStatement(
					"INSERT INTO `user`"
					+"(`name`,`password`,`email_id`,`gender`,`dateOfBirth`,userType)"
					+"VALUES(?,?,?,?,?,?)");

		}
		
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	
	
	public int setrecruiter(String company,String email)
	{
		int result1=0;
		int id=0;

			try{
//				Statement st= con.createStatement(); 
			selectUser= conn.prepareStatement(
						"Select id from `user` where email_id=?");
			selectUser.setString(1,email);
			ResultSet rs=selectUser.executeQuery(); 
			if(rs.next()) 
				id= rs.getInt("id");

			
			insertrecruiter= conn.prepareStatement(
					"INSERT INTO `recruiter`"
					+"(id,company)"
					+"VALUES(?,?)");
			
			insertrecruiter.setInt(1,id);
			insertrecruiter.setString(2,company);
			result1 = insertrecruiter.executeUpdate();
		//}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
			return result1;
			
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
			
			System.out.println("Value" + userType);		

			insertuser.setString(1,name);
			insertuser.setString(2,password);
			insertuser.setString(3,email_id);
			insertuser.setString(4,gender);
			insertuser.setDate(5,dob);
			insertuser.setString(6,userType);
			result = insertuser.executeUpdate();
						
		}
		
		catch(SQLException e){
			e.printStackTrace();
		}
		
		return result;
	}
}
%>
<%
int result =0,result1=0;
String name = new String();
String password = new String();
String email_id = new String();
String gender = new String();
String userType = new String();
SimpleDateFormat f= new SimpleDateFormat("dd/MM/yyyy");
java.sql.Date dateofbirth=null;
String phoneNumber="";
String location="";
String company="";


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

if (request.getParameter("Location")!=null){
	location = request.getParameter("Location");
}

if (request.getParameter("company")!=null){
	company = request.getParameter("company");
}

if (request.getParameter("Phone")!=null){
	phoneNumber = request.getParameter("Phone");
}

Jobs jobs=new Jobs();

result= jobs.setJobs(name,password,email_id,gender,dateofbirth,userType);

if(userType.equals("Recruiter"))
{
	result1= jobs.setrecruiter(company,email_id);

}

%>
<%
/*		if(userType.equals("JobSeeker"))
{
	insertjobSeeker= conn.prepareStatement(
			"INSERT INTO `jobSeeker`"
			+"(resume,phoneNumber,location)"
			+"VALUES(?,?)");

	//insertjobSeeker.setBlob(1,resume);
	insertjobSeeker.setString(2,phoneNumber);
	insertjobSeeker.setString(3,location);

}

else
{
	*/
%>
<% if(request.getParameter("userType").equals("JobSeeker")) { 
	
	response.sendRedirect("user.jsp?email="+email_id) ;
	
    }
	else if(request.getParameter("userType").equals("Recruiter")) {
		response.sendRedirect("recruiter.jsp?email="+email_id) ;
	}
	else if(request.getParameter("userType").equals("Admin"))
    {
		response.sendRedirect("admin.jsp?email="+email_id) ;
    }
    %>
    

 
      
        
</body>
</html>


