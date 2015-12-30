#!/bin/bash

trap "echo TRAPed signal" HUP INT QUIT KILL TERM

/usr/local/bin/php /register-host-on-redis.php
/usr/local/bin/apache2-foreground

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

/usr/local/bin/php /unregister-host-on-redis.php
