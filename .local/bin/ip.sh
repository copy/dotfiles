#!/bin/sh
X=$(curl -s https://duckduckgo.com/?q=ip)
echo "$X"|grep -oe 'Your IP address is [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\} in <[^>]*>[^<]*'|sed 's/<.*>//'
