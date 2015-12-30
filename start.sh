#!/bin/bash

terminate () {
  echo "ciaociao"
  /usr/local/bin/php /unregister-host-on-redis.php
  killall apache2
  exit 0
}

trap terminate HUP INT QUIT KILL TERM

/usr/local/bin/php /register-host-on-redis.php
/usr/local/bin/apache2-foreground

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

terminate()
