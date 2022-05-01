#!"C:\xampp\perl\bin\perl.exe"
 use DBI;
use CGI ':standard';
#  use CGI::Session;
# use CGI::Session::Plugin::Redirect;
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
    #  if ($result) 
    #     {
    #     my $session = new CGI::Session();
    #     print $session->redirect('login.html');
    #  }else{
    # print "user already exists please login";
    #     }
    }else{
     print "failed to connect to MySQL database DBI->errstr()";
}

  
# my $ver = $query->fetch();
# print @$ver;
$query->finish();
