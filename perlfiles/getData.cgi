#!"C:\xampp\perl\bin\perl.exe"
use DBI;
use CGI ':standard';
print header();
$firstName = param("first_name");
$lastName = param("last_name");
$email = param("email_id");
$mobileNo = param("mobile_no");
$password = param("password");
$db = DBI->connect("DBI:mysql:library_management:localhost", "root","")or die print("<h1>Can't Connect to DB</h1>");
if($db){
    print("Database Connection Successful");
    $query = $db->prepare("INSERT INTO `USERS` VALUES(?,?,?,?,?)");
    $query->execute($firstName,$lastName,$email,$mobileNo,$password) or die print("<script>
            window.location.replace('http://localhost:8080/library-management_project/signup.html');
            alert('User already exists');
            </script>");
    if($query){
        print("
            <script>
            window.location.replace('http://localhost:8080/library-management_project/signup.html');
            alert('Data inserted successfully');
            </script>
                ");
    }
}

