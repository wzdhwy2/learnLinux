#/bin/bash/
#基础监控脚本
#source ~/.bash_profile————没起作用？环境变量导致的问题初现！
source /etc/profile


#ipadd=` ifconfig eth0 | cut -d ":" -f 2 `————不能用 参数eth0？后验证可以用！
ip=` ifconfig eth0 | cut -d ":" -f 2 `
ip=` echo $ip | cut -d " " -f 4 `

#free=`free -m | cut -d " " -f 17`
#total=`free -m | cut -d " " -f 11`————某些服务器上cut参数有细微变化！grep+awk才是王道，一个筛选出符合条件的行，一个筛选出符合条件的某列
free=` free -m | awk '$1=="-/+"{print$4}' `
total=` free -m | awk '$1=="Mem:"{print$2}' `
freeS=$[$total/1]
# 总内存/1 是为了测试，/10是才是正常

[ $free -le $freeS ] && echo " 服务器IP:" $ip " ，物理内存共：" $total " M ， 剩余" $free " M ，已不足10%！" |  mail -s  "$ip 服务器 [内
存]预警"  wzdhwy2@163.com && date &>>/home/apps/free.log
#date &>>`pwd`'/'free.sh.log————不能用 pwd 吗？我觉得是要把路径赋给某个变量就能用了，但这里没必要
#echo   "服务器IP："  $ip  "，物理内存共："     因为cut提取包含换行符的原因，为了邮件好看，脚本又好调试。不然直接一个“”引起来
#echo   " 服务器IP："  $ip  " ，物理内存共："   而且必须空一格？？？不然调试脚本时中文又乱码。

size=` df -h | awk '$6=="/" {print$2}' `
used=` df -h | awk '$6=="/" {print$3}' `
avail=` df -h | awk '$6=="/" {print$4}' `
#availS=$[ ` echo $size | cut -d G -f 1 `/10 ]
#以G为单位时，不方便进行浮点比较。所以用使用率做判断。
use=` df -h | awk '$6=="/" {print$5}' `
useS=` echo $use | cut -d % -f 1 `
#awk支持从屏幕输入命令就支持管道符
#awk中 = 是包含 ==是完全匹配 
#awk中 /号要用“”引起来，数字和字母不用
#cut比grep更好提取某些值，但cut很依赖于分隔条件，更容易受不同服务器影响！

[ 0 -le $useS ] && echo "服务器IP：$ip ，根磁盘共：$size ，已使用$used ， 剩余$avail ，使用率将超过$use! " |  mail -s  "$ip 服务器 [磁盘
]预警"  wzdhwy2@163.com && date &>>/home/apps/df.log
# 比0小 是为了测试，95才是正常

