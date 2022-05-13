<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Page</title>
<link rel="stylesheet" href="../css/styles.css">
</head>
<body>
<%
    	response.setHeader("Cache-Control","no-cache");
    	response.setHeader("Cache-Control","no-store");
    	response.setHeader("Pragma","no-cache");
    	response.setDateHeader ("Expires", 0);
    	
    	String firstName = (String) session.getAttribute("firstName");
        String lastName = (String) session.getAttribute("lastName");
        String email = (String) session.getAttribute("email");
        
        if(email == null){
        	session.invalidate();
        	response.sendRedirect("../login.html");
    		
    	}        
        Connection connection = null;
        PreparedStatement pstmt = null;
        String query = "";
        ResultSet rs;
        String userName = "root";
        String dbPass = "";
        String jdbcUrl = "jdbc:mysql://localhost:3306/library_management";


    	%>
	<header
		class="header d-flex justify-content-center align-items-center g-3 p-3">
		<img src="img/bookStack.jpg" width="90px" alt="">
		<h1 class="title">Library Management</h1>
	</header>
	<nav class="d-flex">
		<button type="button" id="dash-btn"
			class="d-block p-2 links text-center text-deco-none capitalize active-shadow">User
			Dashboard</button>
		<button type="button" id="issue-btn"
			class="d-block p-2 links text-center text-deco-none capitalize link-shadow">Issue
			books</button>
		<button type="button" id="issued-btn"
			class="d-block p-2 links text-center text-deco-none capitalize link-shadow">Issued
			Books</button>
		<button type="button" id="return-btn"
			class="d-block p-2 links text-center text-deco-none capitalize link-shadow">Return
			Books</button>
		<button type="button" id="renew-btn"
			class="d-block p-2 links text-center text-deco-none capitalize link-shadow">Renew
			Books</button>
		<form class="d-block p-2 links text-center text-deco-none capitalize link-shadow">
        <button type="submit" id="btn" class="links" name ="logoutbtn" value = "Logout">Logout</button>
    	</form>
    	<%
    	
    	String logoutBtn = request.getParameter("logoutbtn");
		if(logoutBtn == null)System.out.println("Logout btn is not clicked");
		else if(logoutBtn.equalsIgnoreCase("Logout")){
			%>
			<script>
			 alert("Logout successfully");
				location.replace("../login.html");
				</script>
			<%
			session.invalidate();
			
		}
    	%>
	</nav>
	<div id="user-dash" class="d-block">
		<h1>Welcome to user Page</h1>
		<h1>
			Email:
			<%=email%></h1>
		<h1>
			FirstName:
			<%=firstName%></h1>
		<h1>
			LastName:
			<%=lastName%></h1>
	</div>
	<div id="issue-books" class="d-none">
		<h1 class="title text-center mt-3 mb-2 uppercase letter-space">Search
			books to Issue</h1>
		<div class="container-sm mt-3 mb-5">
			<form action="">
				<div class="d-flex justify-content-center flex-wrap">
					<input type="text" name="input-type" class="input-style fb-60"
						id="search"> <select name="select-type" id=""
						class="input-style">
						<option value="none">Select type</option>
						<option value="book_id">Book ID</option>
						<option value="book_name">Book Name</option>
						<option value="author">Author</option>
					</select>
					<button class="btn btn-semi-dark large mt-2" type="submit"
						name="search-btn" value="Search">Search</button>
				</div>
			</form>
		</div>
		<div class="d-flex justify-content-center mt-3 mb-5">
			<table>
				<tr>
					<th>Book ID :</th>
					<th>Book Name :</th>
					<th>Author :</th>
					<th>Available :</th>
					<th>Issue :</th>
				</tr>

				<%
				String inputText = request.getParameter("input-type");
				String searchBtn = request.getParameter("search-btn");
				String selectType = request.getParameter("select-type");

				try {
					connection = DriverManager.getConnection(jdbcUrl, userName, dbPass);
					if (connection != null) {
						if (searchBtn == null)
					System.out.println("Search btn is null");
						else if (searchBtn.equalsIgnoreCase("Search")) {
					switch (selectType) {
					case "book_id":
						query = "select * from books where bookid = " + Integer.parseInt(inputText) + "";
						break;
					case "book_name":
						query = "select * from books where bookName like '%" + inputText + "%'";
						break;

					case "author":
						query = "select * from books where authorName like '%" + inputText + "%'";
						break;

					default:
						query = "select * from books";
						break;
					}
					pstmt = connection.prepareStatement(query);
					rs = pstmt.executeQuery();

					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("bookid")%></td>
					<td><%=rs.getString("bookName")%></td>
					<td><%=rs.getString("authorName")%></td>
					<td><%=rs.getString("currentAvail")%></td>
					<td><a
						href="./issueBook.jsp?bookId=<%=rs.getString("bookid")%>&bookName=<%=rs.getString("bookName")%>&authorName=<%=rs.getString("authorName")%>&user=<%=firstName%>&email=<%=email%>"
						class="d-block medium  btn-user capitalize text-deco-none text-center">Issue</a></td>
				</tr>
				<%
				}
				}
				}
				} catch (SQLException e) {
				out.println("Error: \n" + e);
				out.println("query: \n" + query);
				}
				%>

			</table>
		</div>
	</div>
	<div id="issued-books" class="d-none">
		<h1 class="title text-center mt-3 mb-2 uppercase letter-space">Books
			that are Issued by you</h1>
		<div class="d-flex justify-content-center mt-3 mb-5">
			<table>
                <tr>
                    <th>Book ID :</th>
                    <th>Book Name :</th>
                    <th>Author :</th>
                    <th>Issue Date :</th>
                    <th>Return Date : </th>
                </tr>
			<%
				try{
					connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
					if(connection != null){
						query = "select * from issuedbooks where issuedBy = ?";
						pstmt = connection.prepareStatement(query);
						pstmt.setString(1,email);
						rs= pstmt.executeQuery();
						while(rs.next()){
						%>
						<tr>
						<td><%=rs.getString("bookid")%></td>
						<td><%=rs.getString("bookName")%></td>
						<td><%=rs.getString("authorName")%></td>
						<td><%=rs.getString("issueDate")%></td>
						<td><%=rs.getString("returnDate")%></td>	
						</tr>
						<%
						
						}
					}
				}catch(SQLException e){
					System.out.println("Error: \n "+e);
				}
				%>
			</table>
		</div>
	</div>
	<div id="return-books" class="d-none">
		<h1 class="title text-center mt-3 mb-2 uppercase letter-space">Books
			left to Return</h1>
		<div class="d-flex justify-content-center mt-3 mb-5">
			<table>
				<tr>
					<th>Book ID :</th>
					<th>Book Name :</th>
					<th>Author :</th>
					<th>Return :</th>
				</tr>
				<%
				try{
					connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
					if(connection !=null){
						query = "select bookid,bookName,authorName from issuedbooks where issuedBy = ?";
						pstmt = connection.prepareStatement(query);
						pstmt.setString(1,email);
						rs = pstmt.executeQuery();
						while(rs.next()){
							%>
							<tr>
							<td><%=rs.getString("bookid")%></td>
							<td><%=rs.getString("bookName")%></td>
							<td><%=rs.getString("authorName")%></td>
							<td><a href="./returnBook.jsp?bookId=<%=rs.getString("bookid")%>&email=<%=email	%>"
								class="d-block medium btn-user capitalize text-deco-none text-center">Return</a></td>
						</tr>
						<%	
						}
						
					}
				}catch(SQLException e){
					
				}
				%>
			</table>
		</div>
	</div>
	<div id="renew-books" class="d-none">
		<h1 class="title text-center mt-3 mb-2 uppercase letter-space">Books
			you want to renew</h1>
		<div class="d-flex justify-content-center mt-3 mb-5">
			<table>
				<tr>
					<th>Book ID :</th>
					<th>Book Name :</th>
					<th>Author :</th>
					<th>Renew :</th>
				</tr>
				<%
					try{
						connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
						if(connection != null){
							query = "select bookid,bookName,authorName from issuedBooks where issuedBy=?";
							pstmt = connection.prepareStatement(query);
							pstmt.setString(1,email);
							rs = pstmt.executeQuery();
							while(rs.next()){
								 %><tr>
									<td><%=rs.getString("bookid")%></td>
									<td><%=rs.getString("bookName")%></td>
									<td><%=rs.getString("authorName")%></td>
									<td><a href="./renewBook.jsp?bookId=<%=rs.getString("bookid")%>&email=<%=email%>"
										class="d-block medium btn-user capitalize text-deco-none text-center">Renew</a></td>
								</tr>
								<%	
							}
						}
					}catch(SQLException e){
						System.out.println("Error: \n"+e);
					}
				%>
			</table>
		</div>
	</div>
	<script src="../js/tabFormatUser.js"></script>

</body>
</html>


</body>
</html>