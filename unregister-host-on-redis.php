<?php

$host= gethostname();
$ip = gethostbyname($host);
require "/credis.php";
$redis = new Credis_Client("clusterdata");
$redis->hDel("fb_apache_containers", $ip);
