<?php

$host= gethostname();
$ip = gethostbyname($host);
require "/credis.php";
$redis = new Credis_Client("redis", 6379, null, null, 15);
$redis->hSet("fb_apache_containers", $ip, 1);
