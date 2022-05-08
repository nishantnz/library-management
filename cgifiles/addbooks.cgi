#!"C:\xampp\perl\bin\perl.exe"
 use DBI;
use CGI ':standard';
$bookname=param("bookname");
$bookid=param("bookid");
$authorname=param("authorname");
$quantityofbooks=param("quantity");

print header

$myConnection = DBI->connect('DBI:mysql:librarymanagement:localhost', 'root') ;
$query= $myConnection->prepare("INSERT INTO addedbookdetails VALUES('$bookname','$bookid','$authorname','$quantityofbooks')");
$result = $query->execute();
if($result){
    print("<script>
            alert('you have succesfully added a new book to database');
            window.location.replace('http://localhost:81/library%20management/admin_addbooks.html');
            </script>");
}else{
     print("<script>
            alert('book already exists');
            window.location.replace('http://localhost:81/library%20management/admin_addbooks.html');
            </script>");
}
$query->finish();
