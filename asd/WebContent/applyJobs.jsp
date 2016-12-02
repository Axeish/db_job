<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h5>JobId </h5>      
<%= request.getParameter("Jobid") %>
<br><br>

<h6>JOB DESCRIPTION</h6>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal","root","Amma@123"); 

	Statement st= con.createStatement();
	int id=0;
	ResultSet rs=st.executeQuery("select * from jobs where id ='" + request.getParameter("Jobid") + "'"); 
	if(rs.next()) 
	{ 

	%>
	<div>
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
	</div>
	
	<br><br>
	<a href="jobApplied.jsp?id=<%=request.getParameter("id")%>&jobid=<%=request.getParameter("Jobid") %>&postedBy=<%=request.getParameter("postedBy")%>&searchJobs=<%=request.getParameter("searchJobs")%>">
	APPLY
	</a>
	
	

</body>
</html>

</body>
</html>