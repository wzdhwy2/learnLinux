#!/bin/bash
#取到MySQL服务器上所有库的库名，输出到本机此~/mysql_sh/目录下

DBname="DBname.txt"
mkdir ~/mysql_sh

mysql -h 10.200.53.2 -P 3306 -u sys_market_test -psys_market_test -e"
show databases ;
exit
" >~/mysql_sh/$DBname

#sed '1d' $DBnme
#sed -n '1p' $DBname
#sed '1d' $DBnme >./$DBname
sed -i '1d' $DBname


