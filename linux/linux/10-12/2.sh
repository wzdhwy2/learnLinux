#/bin/bash/
#目的：结合使用多分支的if条件测试语句与while条件循环语句，编写一个用来猜测数值大小的脚本。
#该脚本使用$RANDOM变量来调取出一个随机的数值（范围为0～32767），
#将这个随机数对1000进行取余操作，并使用expr命令取得其结果，
#再用这个数值与用户通过read命令输入的数值进行比较判断。
#       这个判断语句分为三种情况，分别是判断用户输入的数值是等于、大于还是小于使用expr命令取得的数值。


B=$RANDOM
A=$( expr $B % 1000  )
C=0
E=$A

echo "幸运值为0~999之间，猜猜看是多少？"

while true
do

        read -p "请输入你猜测的值：" D
        let C++
        if [ $D -eq $A ]
        then
                echo "你猜对了！你很幸运！"
                echo "你一共猜了$C 次。"
                exit 0
        elif [ $E -eq 1 ]
        then
                echo "很不幸！你的运气已耗尽。你出局了。"
                exit 0
        elif [ $D -gt $A ]
        then
                let E--
                echo "不好意思！请再猜猜看！你还有$E 次机会"
                echo "友情提示！太多了！"
        else let E--
                echo "不好意思！请再猜猜看！你还有$E 次机会"
                echo "友情提示！太少了！"
        fi
done
