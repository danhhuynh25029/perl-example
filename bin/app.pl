use Dancer2;
use DBI;
sub connect_database{
    my $driver = "mysql"; 
    my $database = "test";
    my $dsn = "DBI:$driver:database=$database";
    my $userid = "root";
    my $password = "admin12345";

    my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;
    return $dbh;
}
hook before_template_render => sub{
    my $tokens = shift;
    $tokens->{"css_url"} = request->base."css/style.css";
    $tokens->{"bootstrap_url"} = request->base."css/bootstrap.min.css";
};
get "/insert" => sub{
    template "form";
};
post "/insert" => sub{
    my $db = connect_database();
    my $name = body_parameters->get("name");
    my $age = body_parameters->get("age");
    my $query = $db->prepare("INSERT INTO emp(name,age) VALUES (?,?)");
    $query->execute($name,$age);
    $query->finish();
    $db->commit;
    redirect "/";
};
get "/delete" => sub {
    my $db = connect_database();
    my $id = query_parameters->get("id");
    print "iddd==========".$id;
    my $query = $db->prepare("DELETE FROM emp WHERE id=?");
    $query->execute($id);
    redirect "/";
};
get "/" => sub{
    my $db = connect_database();
    my $query = $db->prepare("SELECT * FROM emp");
    $query->execute();
    template "index" => {
        emp => $query->fetchall_hashref('id')
    };
};
 
start;