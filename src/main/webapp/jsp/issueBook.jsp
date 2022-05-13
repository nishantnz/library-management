<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>

<%
Connection connection;
PreparedStatement pstmt;
ResultSet rs;
String query = "";
String dbPass = "";
String jdbcUrl = "jdbc:mysql://localhost:3306/library_management";
String userName = "root";

//DateTime.now()
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
LocalDateTime ldt = LocalDateTime.now();

//getting values
String bookId = request.getParameter("bookId");
String bookName = request.getParameter("bookName");
String authorName = request.getParameter("authorName");
String email = request.getParameter("email");
String user = request.getParameter("user");
String issueDate = dtf.format(ldt);
String returnDate = dtf.format(ldt.plusDays(7));

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection(jdbcUrl, userName, dbPass);
	if (connection != null) {
		query = "select currentAvail from books where bookid = ?";
		pstmt = connection.prepareStatement(query);
		pstmt.setString(1, bookId);
		rs = pstmt.executeQuery();
		rs.next();
		String currentAvail = rs.getString("currentAvail");
		rs.close();
		pstmt.close();
		if (Integer.parseInt(currentAvail) == 0) {
%>
<script>
	alert("Book is not available");
	location.replace("./userPage.jsp");
</script>
<%
} else {
query = "select issuedBy,bookid from issuedBooks where issuedBy = ? and bookid = ?";
pstmt = connection.prepareStatement(query);
pstmt.setString(1, email);
pstmt.setString(2, bookId);
rs = pstmt.executeQuery();

if (rs.next()) {
%>
<script>
	alert("Book is already issued by you");
	location.replace("./userPage.jsp");
</script>
<%
} else {
query = "insert into issuedbooks values(?,?,?,?,?,?,?)";
pstmt = connection.prepareStatement(query);
pstmt.setString(1, bookId);
pstmt.setString(2, bookName);
pstmt.setString(3, authorName);
pstmt.setString(4, email);
pstmt.setString(5, user);
pstmt.setString(6, issueDate);
pstmt.setString(7, returnDate);
pstmt.execute();
pstmt.close();

query = "update books set currentAvail = ? where bookid = ?";
pstmt = connection.prepareStatement(query);
pstmt.setInt(1, Integer.parseInt(currentAvail) - 1);
pstmt.setInt(2, Integer.parseInt(bookId));
pstmt.executeUpdate();
%>
<script>
	alert("Book issued successfully");
	location.replace("./userPage.jsp");
</script>
<%
}

}

}
} catch (SQLException e) {
out.println("Error: \n" + e);
}
%>