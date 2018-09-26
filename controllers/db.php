<?php
function getDB() {
	$dbhost="127.0.0.1";
	$dbuser="root";
	$dbpass="root";
	$dbname="db_school";
	$pdo = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass,array(1002=> 'SET NAMES utf8'));
	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $pdo;
}
?>
<?php
       define("__DATE__", "");
       define("__TIME__", "");
	 //  define("__COUNTRIES__", file_get_contents("js/countries.json"));
	 getDB();

?>
