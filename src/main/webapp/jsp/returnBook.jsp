<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "java.sql.*"%>

<%
Connection connection = null;
PreparedStatement pstmt = null;
String query = "";
ResultSet rs;
String userName = "root";
String jdbcUrl = "jdbc:mysql://localhost:3306/library_management";
String dbPass = "";
String bookId = request.getParameter("bookId");
String email = request.getParameter("email");
try{
	connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
	if(connection !=null){
		query ="delete from issuedbooks where bookid=? and issuedBy=?";
		pstmt = connection.prepareStatement(query);
		pstmt.setString(1,bookId);
		pstmt.setString(2,email);
		pstmt.executeUpdate();
		pstmt.close();
		query ="update books set currentAvail=currentAvail+1 where bookid=?";
		pstmt = connection.prepareStatement(query);
		pstmt.setString(1,bookId);
		pstmt.executeUpdate();
		%>
		<script>
			alert("Book returned successfully");
			location.replace("./userPage.jsp");
		</script>
		<%
		}
}catch(SQLException e){
	System.out.println("Error: \n"+e);
}

%>