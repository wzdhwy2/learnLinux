#/bin/bash/
#基础监控脚本
#source ~/.bash_profile————没起作用？环境问题初现！
source /etc/profile

#ipadd=` ifconfig eth0 | cut -d ":" -f 2 `————不能用 参数eth0？后验证可以用！
ip=` ifconfig eth0 | cut -d ":" -f 2 `
ip=` echo $ip | cut -d " " -f 4 `

free=`free -m | cut -d " " -f 17`
total=`free -m | cut -d " " -f 11`
freeS=$[$total/1]

[ $free -le $freeS ] && echo 服务器IP：$ip ，物理内存共：$total'M' ， 剩余$free'M' ，已不足10%！ |  mail -s  "$ip 服务器 内存预警"  wzdhwy2@163.com && date &>>/usr/michael/learnlinux/free.sh.log
#date &>>`pwd`'/'free.sh.log————不能用 pwd 吗？我觉得是要把路径赋给某个变量就能用了

