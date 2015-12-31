#!/bin/bash

trap custom_terminate HUP INT QUIT KILL EXIT TERM
function custom_terminate() {
  /usr/local/bin/php /unregister-host-on-redis.php
  killall apache2
  exit 0
}

/usr/local/bin/php /register-host-on-redis.php
rm -f /var/run/apache2/apache2.pid
apache2

while true; do sleep 1; done
