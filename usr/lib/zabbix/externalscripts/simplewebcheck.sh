#!/usr/bin/env bash
#
# script: simplewebcheck.sh 
# version: 1.3
# author: Marcin Gryszkalis <mg@fork.pl>
# description: https://github.com/marcin-gryszkalis/zabbix-simple-web-check 
# license: GPL2
#
# DETAIL:
# Check if given website returns HTTP 200 OK and if the content matches regexp.
#
# This script is intended for use with Zabbix 2.0 and up
#
# REQUIRES:
#  - bash
#  - curl
#  - grep
#
#
# USAGE:
# % simplewebcheck.sh URL REGEXP 
#


# there need to be exactly 2 arguments, if not, exit 1 (error for console)
if [ $# -ne 2 ]; then
    echo "Invalid number of arguments"
    echo "$0 <url> <regexp>"
 exit 1
fi

LOC="POSIX"
export LC_ALL=$LOC

URL=$1 
REGEXP=$2 

# we'll test for SSL 
CURL_PARAMS=" --insecure --silent --max-filesize 10000000 --retry-connrefused --retry 12 --retry-delay 15 --connect-timeout 30 --max-time 600 "

######
# Determine Check Type (Simple vs. Advanced Value) and perform Service Check!
# echo "curl $CURL_PARAMS '$URL' 2>/dev/null | grep -Eq '$REGEXP'"
curl $CURL_PARAMS "$URL" 2>/dev/null | grep -Eq "$REGEXP"
RET=$?
#echo $RET
    if [ $RET -gt 0 ]; then
      echo 0
      exit 1
    else
    # certificate received (subject_hash) send 1 to zabbix, exit 0
      echo 1
      exit 0
    fi

