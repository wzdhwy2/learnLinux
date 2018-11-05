#!/bin/bash/
#调试哪些原本的编程行为（习惯和流程）可以节约时间？
#编程先理清，现有情况下：需求是什么？命令逻辑是什么？选用什么？步骤是什么？来实现什么？
#不要一开始就求完美，必然会在细枝末节上浪费过多时间。不是不要花时间，是要提醒如何分配时间

content="`sh name.txt `"
wc=`echo "$content" | wc -l`
wcs="$wc"
#实际要执行的内容的列表（是执行上面的shell的结果）
#所有的引用文件用硬链接方式做共用和同步，包括脚本本身

id="` cat $content | grep V | awk '$3="V" {print$5}' | awk '!a[$0]++' `"
#id从哪些内容列表那里取，取什么，取出来是什么样的？答：不能基于$id扩展,没有每个项目单独对应自己的版本，所以只能起警示作用，其实也差不多了
#其实我只执行某些特定tags时，存在人为临时让版本号和实际版本不同的可能性。


command="ansible-playbook"
constant="-vv"
#要执行的命令和常用的参数，参数可为空
$1
$2
#临时参数，可为空，使用脚本传参

log="log/` echo $command $constant $1 $2 `_` echo $id `_` date +%Y%m%d `_` date +%T `.log"
#定义日志文件的目录和格式。
#怎么让日志方便看又方便找，确实不如自己用一用就知道。(空格好看不好打出来)

stty erase ^H
#用户交互的前提，针对read -p 时不能退格的问题

serial="` cat $content | grep serial | awk '!a[$0]++' `"
#serials="` cat $content | grep serial `"
#修改发布方式的前提，去除重复行的做展示，也能警示有的串行有的并行的情况。不去除重复项的作为sed输入项先存着
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
内容列表内的id号包含：$id
"
while true
do
	read -p "	是否需要修改(全部)id号？(y/n)：" ifs
	if [ $ifs = y ]
	then
		read -p "	请输入id号(Vx.x.x)：" ids
		sh /etc/ansible/change_version.sh $ids >>/dev/null
		#使用source 替换 sh ，针对sh是新建一个另外的shell进程，执行完造成的改变就没了，source或 . (点) 命令则不是新建。
		#补充：事实上sh执行也实际改变了id号的，问题根本就不是变量作用域的问题，而是没有让log重新取一遍值的问题！
		id="` cat $content | grep V | awk '$3="V" {print$5}' | awk '!a[$0]++' `"
		echo	"	现在id号为：$id"
		log="log/` echo $command $constant $1 $2 `_` echo $id `_` date +%Y%m%d `_` date +%T `.log"
		#针对修改版本号后，日志文件名上的版本不对导致bug的问题，让log紧接着重新取值。因为下面就要调用了
	elif [ $ifs = n ]
	then	
		echo	"	不做修改。"
		break
        else 
		echo	"	指令错误!"
	fi	
done
echo "
—————————————————————【^执行的id号】—————————————————————————"
#简单的交互，告知信息再取用户输入的指令,决定是否需要修改id号


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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $name $constant $1 $2 $id ----共: $wc 个,剩余: $wcs 个 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
		done
		#for逻辑:如果【$命令 $参数 $选项..】执行成功，就输出成功，否则输出失败。无论成败都输出:提示分割线并停3s
		#for特性:一次性读取所有值，每个循环一遍。中间只要不break，Ctrl+C也会继续执行下一行，没有就开始下个循环

		
		echo "共 $wc 个内容，内容的id号包含：$id">>$log
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


#"共 `echo "$content" | wc -l` 个内容"
#为了统计项目个数？最开始的思路是grep取反内容表，再cat -n。后来想没必要这么复杂的吧。对命令还是要熟悉！或者说有一种提出需求，来找实现方式的思路
#从这个小需求上就可以学到，先理清，现有情况下：选用什么？步骤是什么？来实现什么？再动手。
#大逻辑没问题了，删改细节调试效果时也要注意。
#被有无""坑的经验，在这也用上了。有引号有多少输出多少行，空格也输出。没有就只输出一行，中文会乱码。

