<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Welcome to user Page</h1>
<h1>Email: <%=(String)session.getAttribute("email")%></h1>
<h1>FirstName: <%=(String)session.getAttribute("firstName")%></h1>
<h1>LastName: <%=(String)session.getAttribute("lastName")%></h1>
</body>
</html>