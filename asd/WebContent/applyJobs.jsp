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
   

<br><br>

<h2>JOB DESCRIPTION</h2>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","root"); 

	Statement st= con.createStatement();
	int id=0;
	String email= new String();
	email = request.getParameter("email");
	ResultSet rs=st.executeQuery("select * from jobs where id ='" + request.getParameter("Jobid") + "'"); 
	if(rs.next()) 
	{ 

	%>
	<div>
	<table>
	<tr><td>JobID</td><td><%= request.getParameter("Jobid") %></td></tr>
	<tr><td align="top">Job Description</td><td height="400px" width="70%">
	<%
        StringBuffer text = new StringBuffer(rs.getString("jobDetail"));
  
        int loc = (new String(text)).indexOf('\n');
        while(loc > 0){
        	
            text.replace(loc, loc+1, "<BR>");
            loc = (new String(text)).indexOf('\n');
       }
       out.println(text); 
	}
	%>
	</td></tr></table>
	</div>
	
	<br><br>
	<a href="jobApplied.jsp?id=<%=request.getParameter("id")%>&jobid=<%=request.getParameter("Jobid") %>&postedBy=<%=request.getParameter("postedBy")%>&email=<%=email%>">
	APPLY
	</a>
	
	

</body>
</html>

</body>
</html>