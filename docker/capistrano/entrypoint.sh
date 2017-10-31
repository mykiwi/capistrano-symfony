#!/bin/sh
set -e

uid=$(stat -c %u /srv)
gid=$(stat -c %g /srv)

if [ $uid == 0 ] && [ $gid == 0 ]; then
	if [ $# -eq 0 ]; then
	    sh
	else
	    exec "$@"
	fi
fi

sed -i -r "s/foo:x:\d+:\d+:/foo:x:$uid:$gid:/g" /etc/passwd
sed -i -r "s/bar:x:\d+:/bar:x:$gid:/g" /etc/group

user=$(grep ":x:$uid:" /etc/passwd | cut -d: -f1)

chown $uid:$gid /home

if [ $# -eq 0 ]; then
    exec su-exec $user "sh"
else
    exec su-exec $user "$@"
fi
