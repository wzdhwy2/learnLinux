#!/bin/bash
#

#sh ~/mysql_sh/dBname.sh

#取库名
#——————————————————————————————————————————


DBname="` cat ~/mysql_sh/DBname.txt `"
logdate="` date +%Y%m%d `"
mkdir ~/mysql_sh/$logdate

for DBnameS in $DBname
do
mysql -h 10.200.53.2 -P 3306 -u sys_market_test -psys_market_test -e"
SELECT TABLE_name,TABLE_rows,(DATA_LENGTH+INDEX_LENGTH) AS TOTAL_B 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA='$DBnameS' ;
exit
" >~/mysql_sh/$logdate/$DBnameS
sed -i '1d' ~/mysql_sh/$logdate/$DBnameS
done

#取一天的情况，放到当天的文件夹里，每个库单独输出一个文件
#——————————————————————————————————————————

