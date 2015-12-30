#!/bin/bash
set -e

terminate () {
  echo "terminating"
  /usr/local/bin/php /unregister-host-on-redis.php
  killall apache2
  exit 0
}

trap terminate HUP INT QUIT KILL TERM
/usr/local/bin/php /register-host-on-redis.php
rm -f /var/run/apache2/apache2.pid
exec apache2 -DFOREGROUND
