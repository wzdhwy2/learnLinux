#/bin/bash/
a=1521
x=1-2.txt
y=telnet.log
z=telnet-if.log

for name in `cat $x`
do
    sleep 5 | telnet $name $a  &>>$y
	echo "————————【 $name $a 】————————"&>>$y
    tail $y | grep Connected
	if [  $? -eq 0 ]
        	then echo "【$name $a 端口通 ！】"&>>$z
        	else echo "【$name $a 端口不通 ！】"&>>$z
        fi
done

