#!/bin/sh
set -e

OVERRIDE=${OVERRIDE:-}
SKIP_REFRESH=${SKIP_REFRESH:-}

if [ -z "${OVERRIDE}" ]
then
	if [ -z "${SKIP_REFRESH}" ]
	then
    pip install --upgrade git+https://github.com/zenhack/simp_le
	fi
	mkdir -p /var/www/html
	darkhttpd /var/www/html --port 80 --daemon
	/usr/bin/simp_le --default_root /var/www/html "$@"
else
	"$@"
fi
