<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "java.sql.*"%>  
<%@page import="java.time.*"%>  
<%@page import="java.time.format.DateTimeFormatter"%>

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
//DateTime.now()
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
LocalDateTime ldt = LocalDateTime.now();
String issueDate = dtf.format(ldt);
String returnDate = dtf.format(ldt.plusDays(7));

try{
	connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
	if(connection !=null){
		query = "update issuedBooks set issueDate =?,returnDate=? where bookId=? and issuedBy=?";
		pstmt = connection.prepareStatement(query);
		pstmt.setString(1,issueDate);
		pstmt.setString(2,returnDate);
		pstmt.setString(3,bookId);
		pstmt.setString(4,email);
		pstmt.executeUpdate();
			%>
		<script>
			alert("Book renew successfully");
			location.replace("./userPage.jsp");
		</script>
		<%
	}
}catch(SQLException e){
	System.out.println("Error: \n"+e);
}

%>