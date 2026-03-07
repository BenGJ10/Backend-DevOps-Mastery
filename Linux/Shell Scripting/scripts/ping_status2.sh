#!/bin/bash
# Author: Ben Gregory John
# Date: 2026-03-07
# Description: Script to check the ping status of multiple hosts

hosts=("google.com" "yahoo.com" "bing.com" "github.com" "bengregoryjohn.com")

for host in "${hosts[@]}";
do
    if ping -c1 "$host" &> /dev/null;
    then
        echo "Host $host is reachable."
    else
        echo "Host $host is not reachable."
    fi
    sleep 1
done
