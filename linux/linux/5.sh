#/bin/bash/
#for循环语句


#批量创建用户
#目的：利用for 循环取值，再内嵌if判断是否已存在，再内嵌if判断是否创建成功!

#for username in `cat 5.sh.txt`
#	do 
#		echo $username
#	done
#for 的基础语法！

#read -p "请输入用户密码：" pssword 

#for username in `cat 5.sh.txt`
#do
#	
#	id $username &>/dev/null
#	if [ $? -eq 0 ]
#	then echo "$username已存在！"
#	else useradd $username &>/dev/null
#	
#		echo "$password" | passwd --stdin $username #&>/dev/null
#		if [ $? -eq 0 ]
#		then echo "$username,创建成功！"
#		else echo "$username,创建失败！"
#		fi
#	
#	fi
#
#done




#用for语句结合，之前的if判断主机是否在线的语句实现自动化从文本中获取主机列表，自动换测试这些主机是否在线。

for name in `cat 5.sh-2.txt`
do
	
	ping -c 3 $name &>>ping结果.log
	if [ $? -eq 0 ]
	then echo "
【$name 主机在线！】
"
	else echo "
【警告，$name 主机不在线！！！】
"
	fi
	
done


#脚本必备
#if for 等等记得要有结束的关键字！
#从键盘|文件|屏幕获取信息，输出信息到屏幕|不能到屏幕

#从键盘
#read -p “请输入你的名字”  name
#"read 读取键盘输入的值，-p参数 提前输出提示信息， name自定义的跟在后面的变量名"
#echo "你的名字是 $name"

#从文件
#`cat 5.sh`
#不是 'cat 5.sh'

#从屏幕
# | grep 【*】>/etc/null
#"重定向+管道符"


#ping -c 3 127.0.0.1 &>ping结果.log
#"命令执行的返回值重定向输出到这里是不留痕迹的消失的。“
#也可输出到日志里，还可以让正确的输出的正确日志，错误的输出到错误日志，> 是标准输出重定向  2> 是错误输出重定向  &> 是全输出皆重定向




