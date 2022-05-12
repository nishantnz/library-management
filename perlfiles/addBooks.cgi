#!"C:\xampp\perl\bin\perl.exe"
use DBI;
use CGI ':standard';
print header();
$bookName = param("bookname");
$authorName = param("authorname");
$quantity= param("quantity");

$db = DBI->connect("DBI:mysql:library_management:localhost", "root","")or die print("<h1>Can't Connect to DB</h1>");

if($db){
    print("Database Connection Successful");
    $query = $db->prepare("INSERT INTO `BOOKS`(`bookName`,`authorName`,`quantity`) VALUES(?,?,?)");
    $query->execute($bookName,$authorName,$quantity) or die print($DBI::errstr);
    if($query){
        print("
            <script>
            window.location.replace('http://localhost:8080/library-management_project/jsp/adminPage.jsp');
            alert('Book inserted successfully');
            </script>
                ");
    }
}