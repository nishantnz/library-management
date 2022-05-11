<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "java.sql.*" %>
<%
Connection connection = null;
PreparedStatement pstmt;
String query ="";
String dbPass = "";
String userName = "root";
String jdbcUrl = "jdbc:mysql://localhost:3306/library_management";
String value = request.getParameter("deleteBtn");

try{
Class.forName("com.mysql.cj.jdbc.Driver");
connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
if(connection !=null){
	query = "delete from books where bookid = "+value;
	pstmt = connection.prepareStatement(query);
	pstmt.execute();
	%>
	<script>
		alert("Book deleted Successfully");
		location.replace("./adminPage.jsp");
	</script>
	<%
}
}catch(SQLException e){
	out.println("Error: \n"+e);
}
%>