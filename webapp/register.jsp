<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<body>
<%@ page import="java.sql.*" %> 
<%@ page import="javax.swing.*"%> 
<% 
String btnval=request.getParameter("b1");
if(btnval.equalsIgnoreCase("Register"))  
{
	try
	{
		  String t1=request.getParameter("t1");
		  String t2=request.getParameter("t2");
	      int k=0;  
		  Class.forName("oracle.jdbc.driver.OracleDriver");
		  Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hotel","hotel");
		  Statement smt=conn.createStatement();
		  ResultSet rs=smt.executeQuery("select * from login");
		   while(rs.next()) //To read the column
		   {
			   
			   if(rs.getString(1).equals(t1))
			   {
				   k=1;
				   break;
			   }
		   }
		   if(k==1)
		   	   JOptionPane.showMessageDialog(null,"Id already exist");
		    else
		    {
		    	PreparedStatement psmt=conn.prepareStatement("insert into login values(?,?)");
				psmt.setString(1,t1);
				psmt.setString(2,t2);
				psmt.executeQuery();
				JOptionPane.showMessageDialog(null,"Record Saved.....");
			  }
	}
	catch(Exception e)
	{ 
					out.println(e.toString());
	}
}
	
%>
</body>
</html>