<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
    <%@page import = "java.util.*" %>  
    <%@page import = "java.sql.*"%>
  
    <%
   	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
    String email = (String)session.getAttribute("email");
    if(email == null){
    	session.invalidate();
    	response.sendRedirect("../login.html");
		
	}
    Connection connection = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String query ="";
    String dbPass = "";
    String userName = "root";
    String jdbcUrl = "jdbc:mysql://localhost:3306/library_management";
    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <header class="header d-flex justify-content-center align-items-center g-3 p-3">
        <img src="img/bookStack.jpg" width="90px" alt="">
        <h1 class="title">Library Management</h1>
    </header>
    <nav class="d-flex">
        <button type="button" id="dash-btn" class="d-block p-2 links text-center text-deco-none capitalize active-shadow">Admin Dashboard</button>
        <button type="button" id="add-btn" class="d-block p-2 links text-center text-deco-none capitalize link-shadow">Add books</button>
        <button type="button" id="update-btn" class="d-block p-2 links text-center text-deco-none capitalize link-shadow">Update Books</button>
        <button type="button" id="issued-btn" class="d-block p-2 links text-center text-deco-none capitalize link-shadow">Issued Books</button>
        <button type="button" id="view-btn" class="d-block p-2 links text-center text-deco-none capitalize link-shadow">View Books</button>
        <form  class="d-block p-2 links text-center text-deco-none capitalize link-shadow">
        <button type="submit" class="links" id="btn" name ="logoutbtn" value = "Logout">Logout</button>
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
    <%
    	try{
    		connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
    		if(connection !=null){
    			// count of users
    			query = "select count(email_id) from users";
    			pstmt = connection.prepareStatement(query);
    			rs = pstmt.executeQuery();
    			rs.next();
    			int userCount = rs.getInt(1);
    			rs.close();
    			
    			//count of distinct authors
    			query ="select count(distinct(authorName)) from books";
    			pstmt = connection.prepareStatement(query);
    			rs = pstmt.executeQuery();
    			rs.next();
    			int authorCount = rs.getInt(1);
    			rs.close();
    			
    			//count of books
    			query = "select count(bookName) from books";
    			rs = pstmt.executeQuery();
    			rs.next();
    			int booksCount = rs.getInt(1);
    			rs.close();
    			
    			//bookIssued and returned
    			query ="select count(bookid) from issuedbooks";
    			pstmt = connection.prepareStatement(query);
    			rs = pstmt.executeQuery();
    			rs.next();
    			int bookIssuedCount = rs.getInt(1);
    			rs.close();
    	
    %>
    <div id="admin-dash" class="d-block">
        <h1 class="title text-center mt-3 mb-2 uppercase letter-space">Admin Dashboard</h1>
        <div class="container-md">
            <div class="d-flex g-4 justify-content-center flex-wrap">
                <div class="fb-30 p-3 d-flex dir-col justify-content-center align-items-center box-shadow b-radius">
                    <i class="fas fa-users larger"></i>
                    <h3 class="title">Total Users : <%=userCount%></h3>
                </div>
                <div class="fb-30 p-3 d-flex dir-col justify-content-center align-items-center box-shadow b-radius">
                    <i class="fas fa-layer-group larger"></i>
                    <h3 class="title">Total Books :<%=booksCount%></h3>
                </div>
                <div class="fb-30 p-3 d-flex dir-col justify-content-center align-items-center box-shadow b-radius">
                    <i class="fas fa-user-tie larger"></i>
                    <h3 class="title">Total Authors : <%=authorCount%></h3>
                </div>
                <div class="fb-30 p-3 d-flex dir-col justify-content-center align-items-center box-shadow b-radius pos-rel complete">
                    <i class="fas fa-layer-group larger"></i>
                    <h3 class="title">Books Issued : <%=bookIssuedCount%></h3>
                </div>
                <div class="fb-30 p-3 d-flex dir-col justify-content-center align-items-center box-shadow b-radius pos-rel incomplete">
                    <i class="fas fa-layer-group larger"></i>
                    <h3 class="title text-center">Books Not Returned : <%=bookIssuedCount%></h3>
                </div>                
            </div>
        </div>
        <%
        	}
    	}catch(SQLException e){
    		System.out.println("Error: \n"+e);
    	} 
    %>
    </div>
    <div id="add-books" class="d-none">
        <div class="d-flex dir-col justify-content-center align-items-center">
            <h1 class="title text-center mt-3 mb-2 uppercase letter-space">ADD BOOKS</h1>
            <div class="login-template">            
                <form action="http://localhost/perl/addBooks.cgi" method = "post">
                    <div class="d-flex dir-col">
                        <label for="bookname" class="input-label">
                            Book Name:
                        </label>
                        <input type="text" name="bookname" id="bookname" class="fb-100 input-style">
                    </div>
                    <div class="d-flex dir-col">
                        <label for="bookid" class="input-label">
                            Book ID:
                        </label>
                        <input type="text" disabled name="bookid" id="bookid" class="fb-100 input-style">
                    </div>
                    <div class="d-flex dir-col">
                        <label for="authorname" class="input-label">
                            Author Name:
                        </label>
                        <input type="text" name="authorname" id="authorname" class="fb-100 input-style">
                    </div>
                    <div class="d-flex dir-col">
                        <label for="quantity" class="input-label">
                            Quantity:
                        </label>
                        <input type="number" min="1" name="quantity" id="quantity" class="fb-100 input-style">
                    </div> 
                    <div class="d-flex justify-content-center">
                        <button type="submit" id="login-submit" class="large btn btn-semi-dark px-2 mb-4 mt-2">Add To Database</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="update-books" class="d-none">

        <h1 class="title text-center mt-3 mb-2 uppercase letter-space">Search books to update</h1>
        <div class="container-sm mt-3 mb-5">
                <div class="d-flex justify-content-center flex-wrap">
                    <form>
                    <input type="text" name="input-text"  class="input-style fb-60" id="search">
                    <select name="select-type" id="" class="input-style">
                    	<option value = "none">Select type</option>
                        <option value="book_id">Book ID</option>
                        <option value="book_name">Book Name</option>
                        <option value="author">Author</option>
                    </select>
                   
                    <button class="btn btn-semi-dark large mt-2" name = "search" value = "Search">Search</button>
                	</form>
                </div>
                				<table>
             									<th>BookId</th>
             									<th>BookName</th>
             									<th>AuthorName</th>
             									<th>Quantity</th>
             									<th>Edit</th>
             									<th>Delete</th>
             									
             				<%
             				String search = request.getParameter("search");
     						String selectType = request.getParameter("select-type");
     						String inputText = request.getParameter("input-text");
             				try{
             					Class.forName("com.mysql.cj.jdbc.Driver");
             				connection = DriverManager.getConnection (jdbcUrl,userName,dbPass);
             					if(connection != null){
             						System.out.println("Connection is successfull");
             						if(search == null){
             							out.println("Data not found");
             						}
             						else if(search.equalsIgnoreCase("search")){
             							System.out.println("Selected Search");
             							switch(selectType){
             							case "book_id":
             								query ="select * from books where bookid = "+Integer.parseInt(inputText)+"";
             								break;
             							case "book_name":
             								query = "select * from books where bookName like '"+inputText+"%'";
             								break;
             									
             							case "author":
             								query = "select * from books where authorName like '"+inputText+"%'";
             								break;
             								
              							default: query = "select * from books";
             										break; 
             							}
             							pstmt = connection.prepareStatement(query);
             							rs = pstmt.executeQuery();
             							while(rs.next()){
             								%>
             						
             									<tr>
             									<td name = "bookId"><%=rs.getInt("bookid")%></td>
             									<td><%=rs.getString("bookName")%></td>
             									<td><%=rs.getString("authorName")%></td>
             									<td><%= rs.getInt("quantity")%></td>
             								
             									<td>
             									<button class="edit medium btn btn-edit">Edit</button>
             									</td>
             									<td>
             									<form action ="./deleteBook.jsp">
             									<button class="del medium btn btn-del" name = "deleteBtn" value = <%=rs.getInt("bookid")%>>Delete</button>	
             									</form>
             									</td>
             									</tr>
             								<%
             							}
             							pstmt.close();
             							%>
             							</table>
             							<%
             						}
             					}
             				}catch(SQLException e){
             					out.println("Error: \n"+e);
             				}
             				%>	
             						
             				        </div>
          <div class="d-none" id="cover-screen">
            <!-- Empty. as this will only cover the screen for the modal -->
        </div>
        <form action = "" id="modal" class="d-none b-radius">
            <div class="d-flex dir-col justify-content-center p-4">
                <label for="bookidmod" class="input-label-m">Book ID :</label>
                <input type="text" id="bookidmod" readonly name="bookid" class="input-style-m mb-2">
                <label for="booknamemod" class="input-label-m p-0 m-0">Book Name :</label>
                <input type="text" id="booknamemod" name="bookname" class="input-style-m mb-2">
                <label for="authornamemod" class="input-label-m">Author Name : </label>
                <input type="text" id="authornamemod" name="authorname" class="input-style-m mb-2">
                <label for="quantitymod" class="input-label-m">Quantity : </label>
                <input type="number" min="1" id="quantitymod" name="quantity" class="input-style-m mb-3">
                <button type="submit" class="btn btn-edit medium" name = "update-btn" value = "Update">Update</button>
            </div>
        </form>
        
        <% 
        	String updateBtn = request.getParameter("update-btn");
        	String bookName = request.getParameter("bookname");
        	String author = request.getParameter("authorname");
        	String quantity =request.getParameter("quantity");
        	String id =request.getParameter("bookid");
        	
        	if(updateBtn == null)System.out.println("null");        	
        	else if(updateBtn.equalsIgnoreCase("Update")){
        		try{
            		Class.forName("com.mysql.cj.jdbc.Driver");
            	connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
            	if(connection != null){
            		query = "UPDATE `BOOKS` SET bookName =?, authorName=?, quantity=? where bookid=?";
            		pstmt = connection.prepareStatement(query);
            		pstmt.setString(1,bookName);
            		pstmt.setString(2,author);
            		pstmt.setString(3,quantity);
            		pstmt.setString(4, id);
            		pstmt.executeUpdate();
            		%>
            		
            		<script>
            			alert("Data updated successfully");
            		</script>
            		<%
            		
            	}
        		}catch(SQLException e){
            		out.println("Error: \n"+e);
            		}
        	}
        %>

    </div>
    
    <div id="issued-books" style ="margin-top:70px" class="d-none">
        <table style ="margin:auto">
        <tr>
        <th>BookId</th>
        <th>BookName</th>
        <th>AuthorName</th>
        <th>IssuedBy</th>
        <th>IssueDate</th>
        <th>ReturnDate</th>
        </tr>
        <%
        	try{
        		connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
        		if(connection !=null){
        			query = "select * from issuedbooks";
        			pstmt = connection.prepareStatement(query);
        			rs = pstmt.executeQuery();
        			while(rs.next()){
        				 %>
        					<tr>
        						<td><%=rs.getString("bookid")%></td>
        						<td><%=rs.getString("bookName")%></td>
        						<td><%=rs.getString("authorName")%></td>
        						<td><%=rs.getString("issuedBy")%></td>
        						<td><%=rs.getString("issueDate")%></td>
        						<td><%=rs.getString("returnDate")%></td>
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
    <div id="view-books" style = "margin-top:90px" class="d-none">
    	<table style = "margin:auto">
    	<th>BookId</th>
    	<th>BookName</th>
    	<th>AuthorName</th>
    	<th>Quantity</th>
        
        <%
        	connection = DriverManager.getConnection(jdbcUrl,userName,dbPass);
        	if(connection !=null){
        		query = "select * from books";
        		pstmt = connection.prepareStatement(query);
        		rs = pstmt.executeQuery();
        		while(rs.next()){
        			%>
        			<tr>
        			<td><%=rs.getString("bookid")%></td>
        			<td><%=rs.getString("bookName")%></td>
        			<td><%=rs.getString("authorName")%></td>
        			<td><%=rs.getString("quantity")%></td>
        			</tr>	
        		<%
        		}
        	}
        %>
        </table>
    </div>
    
<script src="../js/tabFormatAdmin.js"></script>
<script src="../js/updatebooks.js"></script>

</body>
</html>