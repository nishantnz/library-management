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
$query->finish();
