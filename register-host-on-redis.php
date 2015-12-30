<?php

$host= gethostname();
$ip = gethostbyname($host);
require "/credis.php";
$redis = new Credis_Client("redis-clusterdata");
$redis->hSet("fb_apache_containers", $ip, 1);
