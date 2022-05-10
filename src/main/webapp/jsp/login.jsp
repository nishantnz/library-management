<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
    <%@page import = "java.io.*" %>  
    <%@page import = "java.sql.*"%>

<html>
<head>
<title>Login.jspPage</title>
</head>
<body>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");
String userRole = request.getParameter("desig");

out.println("email: "+email);
out.println("password: "+password);
out.println("userRole: "+userRole);

			//declaring variables
			String query;
			Connection connection;
			PreparedStatement pstmt;
			ResultSet rs;
			String userName = "root";
			String dbPass = "";
			String jdbcUrl = "jdbc:mysql://localhost:3306/library_management";
			
			try{
			//checking if connection to db is successfull or not
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection =  DriverManager.getConnection(jdbcUrl,userName,dbPass);
			/*
				check if connection is successfull or not if connection is success it will check
				if users exists or not if exists it checks if password is matching or not if matching then it will redirect
				the user based on userRole they have.
			*/
			
			if(connection !=null){
			 	//checking if userRole is User or not
				if(userRole.equals("Users")){
			 		query = "SELECT * FROM USERS WHERE EMAIL_ID = ?";
			 		pstmt = connection.prepareStatement(query);
			 		pstmt.setString(1,email);
			 		rs = pstmt.executeQuery();
			 		if(rs.next()){
			 				if(rs.getString("password").equals(password)){
			 					session.setAttribute("firstName",rs.getString("first_name"));
			 					session.setAttribute("lastName",rs.getString("last_name"));
			 					session.setAttribute("email",email);
			 					
			 					response.sendRedirect("userPage.jsp");
			 				}else{
			 						%>
			 						 <script>
			 						 window.location.replace("../login.html")
			 						 alert("Password is incorrect")
			 						</script>
			 						 <%
			 					
			 					
			 					}
			 				}
			 			
			 			
			 			%><script>
						 window.location.replace("../login.html")
						 alert("Please entered right credentials to login"); 
						</script>
						<%
			 			
			 			
			 		
			 	}			 		
			 	else{
			 			query = "SELECT * FROM `ADMIN` WHERE EMAIL_ID = ?";
			 			pstmt = connection.prepareStatement(query);
			 			pstmt.setString(1,email);
			 			rs = pstmt.executeQuery();
			 			if(rs.next()){
			 				if(rs.getString("password").equals(password)){
			 					session.setAttribute("email",email);
			 				response.sendRedirect("adminPage.jsp");
			 				}else{
			 					%>
			 						<script>
			 						window.location.replace("../login.html");
			 						alert("password is wrong");
			 						</script>
			 					<%
			 				}
			 			}else{
			 				
			 				%>
	 					<script>
	 						window.location.replace("../login.html");
	 						alert("Please entered right credentials to login");
	 						</script>
	 						<%
	 					
			 			}
			 			
			 			
			 		}
			 	}
			 	
			}
			
		catch(SQLException e){
			System.out.println("Error: \n"+e);
		}
%>

</body>
</html>
