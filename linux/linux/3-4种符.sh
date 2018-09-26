#/bin/bash/
#shell脚本语言编程基础

#abcdefg hijklnm opqrst uvwxyz
#abcdefg hijklnm opqrst uvwxyz
#abcdefg hijklnm opqrst uvwxyz
#练打字，使用金山打字

#echo 'll -h'
#echo "ll -h"
#ll -h
#echo 'ls -alh'
ls -alh
echo “查看当前目录详细情况！“



#3.文件比较符
[ -e ./shell.txt ]
echo $?
#[apps@test5153 linux]$ 0
[ -e ./shell.txt ] && echo "shell.txt 文件存在！ "
#shell.txt 文件存在！ 
ls -alh shell.txt
[ $? -eq 0 ] && echo "shell.txt 验证了文件确实存在！" || echo "shell.txt 文件不存在！ "


#4.字符比较运算符
echo $USER
#apps
[ $USER = root  ] && echo "当前用户为root" || echo "当前用户为$USER"
#当前用户为apps
echo $USER
[ $USER != root ] && echo "非root" || echo "是root"
#非root

