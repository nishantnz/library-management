#!"C:\xampp\perl\bin\perl.exe"
 use DBI;
use CGI ':standard';
$firstname=param("first_name");
$lastname=param("last_name");
$emailid=param("email_id");
$phonenumber=param("mobile_no");
$passofuser=param("password");

print header

$myConnection = DBI->connect('DBI:mysql:librarymanagement:localhost', 'root') ;
if($myConnection){
    $query= $myConnection->prepare("INSERT INTO registeredusers VALUES('$firstname','$lastname','$emailid','$phonenumber','$passofuser')");
    $result = $query->execute();
     if ($result) 
        {
            print("<script>
            window.location.replace('http://localhost:81/library%20management/login.html');
            alert('your have been sucessefully registered');
            </script>");
     }else{
     print("<script>alert('user already exists')
     window.location.replace('http://localhost:81/library%20management/login.html');
     </script>");
        }
    }else{
     print "failed to connect to MySQL database DBI->errstr()";
}

  
# my $ver = $query->fetch();
# print @$ver;
$query->finish();
