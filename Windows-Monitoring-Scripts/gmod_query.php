<?php
include 'query.php';

//Replace 0.0.0.0:27015 with your servers IP and port.
$query = query_source("0.0.0.0:27015");

if ($query['status'] == 1)
{

	echo "Alive";
}
else
{
	echo "Down";
}
?>
