<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %> 
<%@ page import="javax.swing.*"%> 
<%
    String btnval=request.getParameter("b1");
	if(btnval.equalsIgnoreCase("login"))
	{
	 try {
		    String t1 = request.getParameter("t1");
            String t2 = request.getParameter("t2"); 
            int f=0;
            Class.forName("oracle.jdbc.driver.OracleDriver");
		    Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hotel", "hotel");
            Statement smt = conn.createStatement();
            ResultSet rs = smt.executeQuery("select * from login");
            while(rs.next())
            {
            if(rs.getString(1).equals(t1) && rs.getString(2).equals(t2))
            	{
            	f=1;
            break;
            	}
            }
            if(f==1)
            {
            	out.println("<script>window.open('menu.html')</script>");
            }
            else
            	JOptionPane.showMessageDialog(null,"Invalid Login");
	        }
            
            catch(Exception e)
            {
            	 out.println(e.toString());
            }
	 }
 %>        
</body>
</html>