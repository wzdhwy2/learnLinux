#!/bin/bash
source /etc/profile
#解决定时任务时环境变量导致的问题


DBname="DBname.txt"
mkdir ~/mysql_sh

mysql -h 10.200.53.2 -P 3306 -u sys_market_test -psys_market_test -e"
show databases ;
exit
" >~/mysql_sh/$DBname

sed -i '1d' ~/mysql_sh/$DBname && jg=1:OK || jg=1:NO
#sed -i 参数才会对文件起作用，删掉库名存放列表里说明性的第一行

#取到MySQL服务器上所有库的库名列表，输出到本机此~/mysql_sh/目录下文件里
#———————————————————————第一步———————————————————————————


DBname="` cat ~/mysql_sh/DBname.txt `"
logdate="` date +%Y%m%d `"
mkdir ~/mysql_sh/$logdate || rm -r ~/mysql_sh/$logdate
mkdir ~/mysql_sh/$logdate
#保证文件（$logdate）的新鲜，可靠
#没有必要，反正是覆盖，又不是追加。

for DBnameS in $DBname
do

mysql -h 10.200.53.2 -P 3306 -u sys_market_test -psys_market_test -e"
SELECT TABLE_name,TABLE_rows,(DATA_LENGTH+INDEX_LENGTH) AS TOTAL_B 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA='$DBnameS' ;
exit
" >~/mysql_sh/$logdate/$DBnameS
sed -i '1d' ~/mysql_sh/$logdate/$DBnameS  &&  jg_s=2:OK || jg_s=2:NO
#删掉这个库里所有表的情况存放列表里说明性的第一行

done

#取当天所有表的情况，放到当天的文件夹里，每个库单独输出一个文件
#———————————————————————第二步———————————————————————————


echo "$logdate	$jg | $jg_s	" >>~/mysql_sh/zabbix_mysql.log
#使用定时任务时的简单日志

