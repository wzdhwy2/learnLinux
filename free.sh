#/bin/bash/
#基础监控脚本
#source ~/.bash_profile————没起作用？环境变量导致的问题初现！
source /etc/profile

#ipadd=` ifconfig eth0 | cut -d ":" -f 2 `————不能用 参数eth0？后验证可以用！
ip=` ifconfig eth0 | cut -d ":" -f 2 `
ip=` echo $ip | cut -d " " -f 4 `

free=`free -m | cut -d " " -f 17`
total=`free -m | cut -d " " -f 11`
freeS=$[$total/1]

[ $free -le $freeS ] && echo 服务器IP：$ip ，物理内存共：$total'M' ， 剩余$free'M' ，已不足10%！ |  mail -s  "$ip 服务器 内存预警"  wzdhwy2@163.com && date &>>/usr/michael/learnlinux/free.sh.log
#date &>>`pwd`'/'free.sh.log————不能用 pwd 吗？我觉得是要把路径赋给某个变量就能用了，但这里没必要

size=` df -h | awk '$5=="/" {print$1}' `
used=` df -h | awk '$5=="/" {print$2}' `
avail=` df -h | awk '$5=="/" {print$3}' `
#availS=$[ ` echo $size | cut -d G -f 1 `/10 ]
use=` df -h | awk '$5=="/" {print$4}' `
useS=` echo $use | cut -d % -f 1 `

[ 95 -le $useS ] && echo 服务器IP：$ip ，根磁盘共：$size ，已使用$used ， 剩余$avail ，使用率将超过$use'!' |  mail -s  "$ip 服务器 磁盘预警"  wzdhwy2@163.com && date &>>/usr/michael/learnlinux/df.log

#经验
#awk支持从屏幕输入命令就支持管道符
#awk中 = 是包含 ==是完全匹配 
#awk中 /号要用“”引起来，数字和字母不用
#cut比grep更好提取某些值，但cut很依赖于分隔条件，更容易不同服务器受影响！
