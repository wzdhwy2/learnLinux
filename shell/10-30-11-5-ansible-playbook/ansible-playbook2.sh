#!/bin/bash/
#辅助发版程序

content="`sh name2.txt `"
wc=`echo "$content" | wc -l`
wcs="$wc"
#实际要执行的内容的列表（是执行上面的shell的结果）

command="ansible-playbook"
constant="-vv"
#要执行的命令和常用的参数，参数可为空
$1
$2
#临时参数，可为空，使用脚本传参

log="log/` echo $command $constant $1 $2 `_` date +%Y%m%d `_` date +%T `.log"
#定义日志文件的目录和格式。

stty erase ^H
#用户交互的前提，针对read -p 时不能退格的问题

serial="` cat $content | grep serial | awk '!a[$0]++' `"
#补充。这是要用sed替换文本，而你把grep过滤出的文本赋给了一个变量，sed替换就是对变量进行了，简单测试后不行。



echo "
当前登录用户为：` whoami `"
echo "
—————————【提示：最后检查10分钟，免了两小时排查！】——————————"
echo "
$content 
共 $wc 个内容"
echo "
————————————————————【^执行的内容列表】——————————————————————"
#提示用户名，再次检查执行列表


echo "
内容列表的执行方式为：$serial
"
while true
do
        read -p "	是否需要修改执行方式？(y/n)：" ifss
        if [ $ifss = y ]
        then
		if [[ $serial == *'-serial'* ]]
		then
			sed -i '3c serial: 1' $content
                        #$serial取到的是行，匹配的字符是列，所以只能是判断是否包含
			#if能判断，但无法区分#serial和serial，只当serial处理,所以只能整行替换
			serial="` cat $content | grep serial | awk '!a[$0]++' `"
			echo    "	现在的执行方式为：$serial"
		else
			sed -i '3c #-serial: 1' $content
			serial="` cat $content | grep serial | awk '!a[$0]++' `"
			echo    "	现在的执行方式为：$serial"
		fi
		
        elif [ $ifss = n ]
        then
                echo	"	不做修改。"
                break
        else
                echo 	"	指令错误!"
        fi
done
echo "
—————————————————————【^执行的方式】—————————————————————————"
#简单的交互，告知信息再取用户输入的指令，决定是否需要修改执行方式


echo "
>>$command 单个内容 $constant $1 $2 "
echo "
—————————————————————【^执行的命令】—————————————————————————
"
while true
do
	read -p 	"	确认执行？(y/n)：" if
	if [ $if = y  ] 
	then
		echo	"	确认执行。
		"
		
		for name in `echo $content`
		do
			let wcs--
			$command $name $constant $1 $2 &&  echo "$name $constant $1 $2 执行成功 `date +%T`">>$log || echo "$name $constant $1 $2 执行失败 `date +%T`">>$log | sleep 3 | echo "
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $name $constant $1 $2 ----共: $wc 个,剩余: $wcs 个 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
		done
		#for特性:一次性读取所有值，每个循环一遍。中间只要不break，Ctrl+C也会继续执行下一行，没有就开始下个循环

		
		echo "共 $wc 个内容">>$log
		cat "$log"
		echo "————————————————————————————【执行结果|日志路径:$log】——————————————————————————————" 
		#for循环完毕了，查看执行结果
		break
	elif [ $if = n ] 
	then 
		echo	"	取消执行。
		"
		break
	else
		echo 	"	指令错误！"
	fi
done
#简单的交互，告知信息再取用户输入的指令，判断是否开始for循环

