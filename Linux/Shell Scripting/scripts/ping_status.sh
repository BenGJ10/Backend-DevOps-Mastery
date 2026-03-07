#!/bin/bash
# Author: Ben Gregory John
# Date: 2026-03-07
# Description: This script pings a specified host and reports the status.

host="google.com"
ping -c1 $host
echo
if [ $? -eq 0 ]; then
    echo "$host is reachable."
else
    echo "$host is unreachable."
fi
