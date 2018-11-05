#!/bin/bash/
#if双分支

#ipadd="10.200.51.53"
ping -c 3 $ipadd &>/ping.txt

if [ $? -eq 0  ]
	then echo "ping通"
	else echo "未ping通"
fi
