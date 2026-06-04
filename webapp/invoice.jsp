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
	if(btnval.equalsIgnoreCase("save"))
	{
		String t1=request.getParameter("t1");
		String t2=request.getParameter("t2");
		String t3=request.getParameter("t3");
		String t4=request.getParameter("t4");
		String t5=request.getParameter("t5");
		String t6=request.getParameter("t6");
		String t7=request.getParameter("t7");
		try
		{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hotel", "hotel");
				Statement smt=conn.createStatement();
			    ResultSet rs=smt.executeQuery("select customer_id from customer"); // rs is the buffer
			    //Customer ID as foreign key
			    int cidfk=0;
			    while(rs.next())
				{
					if(rs.getString(1).equals(t2))
					{
						cidfk=1;
						break;
					}
				}
			    //Booking ID as foreign key
			    rs=smt.executeQuery("select booking_id from booking"); // rs is the buffer
			    int bkidfk=0;
			    while(rs.next())
				{
					if(rs.getString(1).equals(t3))
					{
						bkidfk=1;
						break;
					}
				}
				if(cidfk==0)
					JOptionPane.showMessageDialog(null,"Customer ID not found");
				else if(bkidfk==0)
					JOptionPane.showMessageDialog(null,"Booking ID not found");
				else
				{
			      PreparedStatement psmt=conn.prepareStatement("insert into invoice values(?,?,?,?,?,?,?)");
			      psmt.setString(1,t1);
			      psmt.setString(2,t2);
			      psmt.setString(3,t3);
			      psmt.setString(4,t4);
			      psmt.setString(5,t5);
			      psmt.setString(6,t6);
			      psmt.setString(7,t7);
			      psmt.executeQuery();
			      JOptionPane.showMessageDialog(null,"Record Saved.....");
		       }
	}
		catch(Exception e)
		{
			JOptionPane.showMessageDialog(null,e.toString());
		}
	}
	//End of save
    //Delete the particular record
	if(btnval.equalsIgnoreCase("delete"))
	{
		String t1=request.getParameter("t1");
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hotel", "hotel");
			PreparedStatement psmt=conn.prepareStatement("delete from invoice where invoice_id=?");
			psmt.setString(1,t1);
			psmt.executeQuery();
			JOptionPane.showMessageDialog(null,"Record Deleted.....");
		}
		catch(Exception e)
		{
			JOptionPane.showMessageDialog(null,e.toString());
		}
	}//End of delete
	//Update particular record
		if(btnval.equalsIgnoreCase("update"))
			{
			String t1 = request.getParameter("t1");
	        String t2 = request.getParameter("t2");
	        String t3 = request.getParameter("t3");
	        String t4 = request.getParameter("t4");
	        String t5 = request.getParameter("t5");
	        String t6 = request.getParameter("t6");
	        String t7 = request.getParameter("t7");
				try
				{
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hotel", "hotel");
					PreparedStatement psmt=conn.prepareStatement("update invoice set customer_id=?,booking_id=?,discount=?,gst=?,created_date=?,created_by=? where invoice_id=?");
					psmt.setString(1,t2);
					psmt.setString(2,t3);
					psmt.setString(3,t4);
					psmt.setString(4,t5);
					psmt.setString(5,t6);
					psmt.setString(6,t7);
					psmt.setString(7,t1);
					psmt.executeQuery();
					JOptionPane.showMessageDialog(null,"Record Updated.....");
				}
				catch(Exception e)
				{
					JOptionPane.showMessageDialog(null,e.toString());
				}
			}//End of update
			//Start of allsearch
			if(btnval.equalsIgnoreCase("allsearch"))  
			{
				 try
				  {
					  Class.forName("oracle.jdbc.driver.OracleDriver");
					  Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hotel","hotel");
					  
					  Statement smt=conn.createStatement();
					  ResultSet rs=smt.executeQuery("select * from invoice"); // rs is the buffer
					  %>
					  <center>
					  <table border=2>
					  <tr>
					     <th>Invoice ID</th>
					     <th>Customer ID</th>
					     <th>Booking ID</th>
					     <th>Discount</th>
					     <th>GST</th>
					     <th>Created Date</th>
					     <th>Created By</th>
					  </tr>
					  <% // open jsp
					  while(rs.next()) // To read the column
					  {
					  %>  <!--close jsp-->
					   <tr>
					     <th><%=rs.getString(1)%></th> <!--1=1st column--->
					     <th><%=rs.getString(2)%></th> <!--2=2nd column--->
					     <th><%=rs.getString(3)%></th> <!--3=3rd column--->
					     <th><%=rs.getString(4)%></th> <!--4=4th column--->
					     <th><%=rs.getString(5)%></th> <!--5=5th column--->
					     <th><%=rs.getString(6)%></th> <!--6=6th column--->
					     <th><%=rs.getString(7)%></th> <!--7=7th column--->
					    </tr>
					  <%
					  }
					  %>   <!-- close jsp (java server page)--->
					   <input type=button value="print" onclick="window.print()">
					  </table>
					  <%
				}
				  catch(Exception e)
				  { 
					  out.println(e.toString());
				  }
					 
			}   // End of allsearch
			//Start of Psearch
			if(btnval.equalsIgnoreCase("psearch"))  
			{
				 try
				  {
					  String t1=request.getParameter("t1");
					  Class.forName("oracle.jdbc.driver.OracleDriver");
					  Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hotel","hotel");
					  
					  Statement smt=conn.createStatement();
					  ResultSet rs=smt.executeQuery("select * from invoice where invoice_id='"+t1+"'"); // rs is the buffer
					  %>
					  <center>
					  <table border=2>
					  <tr>
					    <th>Invoice ID</th>
					     <th>Customer ID</th>
					     <th>Booking ID</th>
					     <th>Discount</th>
					     <th>GST</th>
					     <th>Created Date</th>
					     <th>Created By</th>
					  </tr>
					  <% // open jsp
					  while(rs.next()) // To read the column
					  {
					  %>  <!--close jsp-->
					   <tr>
					     <th><%=rs.getString(1)%></th> <!--1=1st column--->
					     <th><%=rs.getString(2)%></th> <!--2=2nd column--->
					     <th><%=rs.getString(3)%></th> <!--3=3rd column--->
					     <th><%=rs.getString(4)%></th> <!--4=4th column--->
					     <th><%=rs.getString(5)%></th> <!--5=5th column--->
					     <th><%=rs.getString(6)%></th> <!--6=6th column--->
					     <th><%=rs.getString(7)%></th> <!--7=7th column--->
					    </tr>
					  <%
					  }
					  %>   <!-- close jsp (java server page)--->
					   <input type=button value="print" onclick="window.print()">
					  </table>
					  <%
				}
				  catch(Exception e)
				  { 
					  out.println(e.toString());
				  }
					 
			} // End of Psearch
			//Start of Spsearch
			if(btnval.equalsIgnoreCase("find"))  
			{
				 try
				  {
					  Class.forName("oracle.jdbc.driver.OracleDriver");
					  Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hotel","hotel");
					  String t1=request.getParameter("t1");
					  String col=request.getParameter("s");
					  Statement smt=conn.createStatement();
					  ResultSet rs=null;
					  if(col.equalsIgnoreCase("all"))
					  	  rs=smt.executeQuery("select * from invoice");
					  else
						  rs=smt.executeQuery("select * from invoice where "+col+ "=" +"'"+t1+"'");	 
					%>
					<center>
					  <table border=2>
					  <tr>
					    <th>Invoice ID</th>
					     <th>Customer ID</th>
					     <th>Booking ID</th>
					     <th>Discount</th>
					     <th>GST</th>
					     <th>Created Date</th>
					     <th>Created By</th>
					  </tr>
					  <% // open jsp
					  while(rs.next()) // To read the column
					  {
					  %>  <!--close jsp-->
					   <tr>
					     <th><%=rs.getString(1)%></th> <!--1=1st column--->
					     <th><%=rs.getString(2)%></th> <!--2=2nd column--->
					     <th><%=rs.getString(3)%></th> <!--3=3rd column--->
					     <th><%=rs.getString(4)%></th> <!--4=4th column--->
					     <th><%=rs.getString(5)%></th> <!--5=5th column--->
					     <th><%=rs.getString(6)%></th> <!--6=6th column--->
					     <th><%=rs.getString(7)%></th> <!--7=7th column--->
					    </tr>
					  <%
					  }
					  %>   <!-- close jsp (java server page)--->
					   <input type=button value="print" onclick="window.print()">
					  </table>
					  <%
				}
				  catch(Exception e)
				  { 
					  out.println(e.toString());
				  }
					 
			} // End of spsearch
					
%>
</body>
</html>