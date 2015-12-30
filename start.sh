#!/bin/bash

trap "echo TRAPed signal" HUP INT QUIT KILL TERM

#register to cluster
/usr/local/bin/apache2-foreground

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

# unregister from cluster
