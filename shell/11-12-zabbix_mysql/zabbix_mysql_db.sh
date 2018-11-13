#!/bin/bash
source /etc/profile
stty erase ^H
#用户交互的前提，针对read -p 时不能退格的问题

echo "
请选择对比多少天前的内容：
"
while true
do
	read -p "	清选择天数(1/10/30/0(自定义)：" date
	if [ $date = 0 ]
	then
		read -p "	请输入天数(1=<)：" my_db_date
		echo	"	现在对比天数为：$my_db_date 天前的表情况"
		break
	elif [ $date = 1 ]
	then	
		my_db_date=1
		echo	"       现在对比天数为：$my_db_date 天前的表情况"
		break
	elif [ $date = 10 ]
        then
		my_db_date=10
                echo    "       现在对比天数为：$my_db_date 天前的表情况"
                break
	elif [ $date = 30 ]
        then
		my_db_date=30
                echo    "       现在对比天数为：$my_db_date 天前的表情况"
                break
        else 
		echo	"	指令错误!"
	fi	
done

#简单的交互，让用户选择对比时间
#————————————————————————————————————————————————第一步————————————————————————————————————————————————————————


DBname="` cat ~/mysql_sh/DBname.txt `"
#获取库名清单
logdate="` date +%Y%m%d `"
#当天表的情况的存放的文件夹_的路径
logdateS=` date -d "$my_db_date days ago" +%Y%m%d `
#旧的文件夹的（带S）_的路径

db_log="db_$logdateS-$logdate"
mkdir ~/mysql_sh/$db_log || rm -r ~/mysql_sh/$db_log
mkdir ~/mysql_sh/$db_log
#保证对比文件（db_xxxx）的新鲜，可靠


for DBnameS in $DBname
do

        tbname=` awk '{print$1}' ~/mysql_sh/$logdate/$DBnameS `
	#只以新表名为准！必须要以一项表名才能做对比，不能一次性对比所有表
	
        for tbnameS in $tbname
        do
	
                tbroS=` awk ' $1=="'$tbnameS'"  {print$2} ' ~/mysql_sh/$logdateS/$DBnameS `
                tbro=` awk ' $1=="'$tbnameS'"  {print$2} ' ~/mysql_sh/$logdate/$DBnameS `
		#没有必要单独过滤当前的行（表情况），sed自带过滤匹配功能，匹配当前for到的表名的项，就输出$2
		#你发现了什么？有效快速解决问题——事后发现有一些什么样的规律吗？事前的进度为什么推的这么慢？
		db_tbro=$[tbro-tbroS]
                tbsizeS=` awk ' $1=="'$tbnameS'"  {print$3} ' ~/mysql_sh/$logdateS/$DBnameS `
                tbsize=` awk ' $1=="'$tbnameS'"  {print$3} ' ~/mysql_sh/$logdate/$DBnameS `
                db_tbsize=$[tbsize-tbsizeS]
		touch ~/mysql_sh/$db_log/$DBnameS
		echo "表名：$tbnameS			|   行数： 现有 $tbro   原有 $tbroS   增长 $db_tbro   |   大小(K)： 现有 $tbsize   原有 $tbsizeS   增长 $db_tbsize	">>~/mysql_sh/$db_log/$DBnameS
		
        done

done

#遍历所有库，每个库遍历所有表，基于日期作对比，并输入到~/mysql_sh/对比文件夹/库_表内容对比文件里
#————————————————————————————————————————————————第二步————————————————————————————————————————————————————————

