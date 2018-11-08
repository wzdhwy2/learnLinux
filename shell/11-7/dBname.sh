#!/bin/bash
#
DBname="DBname.txt"

mysql -h 10.200.53.2 -P 3306 -u sys_market_test -psys_market_test -e"
show databases ;
exit
" >./$DBname

#sed '1d' $DBnme
#sed -n '1p' $DBname
#sed '1d' $DBnme >./$DBname
sed -i '1d' $DBname


