#/bin/bash/

#测试字符比较运算符
echo $USER
[ $USER != root ] && echo "非root" || echo "是root"



#流程控制语句

#前言，怎么批量创建1000位用户？（先判断是否存在，再执行相应命令）
#思路：1位用户的模式循环1000次

username=test2
cut -d: -f 1 /etc/passwd | grep $username  && echo "$username 已存在" || sudo useradd $username && echo "$username 用户和组创建成功！" || echo "$username 用户和组创建失败！"
#sudo useradd $username  && echo "$username 用户和组创建成功！" || echo "$username 用户和组创建失败！"
#sudo useradd 命令在用户已存在时不会报错也不会执行，但逻辑判断符会认为执行了且成功，所以判断有问题！
#cut -d: -f 1 /etc/passwd | grep $username && echo "$username 用户和组创建成功！" || echo "$username 用户和组创建失败！"
#这样也并没有什么用，依然会已存在又报创建成功



#if以及if单分支，双分支，多分支的用法
#一个判断，双分支
ipadd=10.200.51.53
ping -c 3  $ipadd 
if [ $? -eq 0 ]
then echo " 服务器在线！ "
else echo " 服务器不在线！"
fi


#两个判断，多分支
if [ $1 -ge 85 && $1 -le 100 ] 
	then echo "$1 分 成绩优异！"
elif [$1 -ge 70 && $1 -le 84  ]
	then echo "$1 分 成绩良好！"
elif [ $1 -ge 60 && $1 -le 69 ]
	then echo "$1 分 刚好及格！"
elif []
	then echo ""
else  echo "$1 分 不及格！"

fi






