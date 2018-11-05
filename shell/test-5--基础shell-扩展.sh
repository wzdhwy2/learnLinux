#!/bin/bash/
#2="$一个未定义的变量"

#if ping -c 10 -w 3 
#then $2=0
#else $2=1
#fi

ping -c 3 -i 0.2 -W 3 $1  &>/user/123.txt

if [ $1 -eq 0  ]
then echo "$1 ping通"
else echo "$1 未ping通"
fi 







