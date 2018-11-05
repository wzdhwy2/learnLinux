#!/bin/bash/
#if多分支自己编
read -p "请输入你的成绩：" 1
if [ -z $1 ] && [ $1 -le 100 ] && [ $1 -ge 0 ] ;
	then echo "成绩不能为空！并且>=0和<=100!"
elif [ $1 -ge 85 ] ;
	then echo "合格"  #"成绩优秀！"
else #[ $1 -le 84 && $1 -ge 70 ]
	then echo "不合格"  #"成绩良好！"
fi

#if [ $1 -le 69 ]
#then echo "成绩不合格"
#fi


#read -p "输入你的成绩（0-100）：" GRADE
#if [ $GRADE -ge 85 ] && [ $GRADE -le 100 ] ; then
#echo "$GRADE is 优秀"
#elif [ $GRADE -ge 70 ] && [ $GRADE -le 84 ] ; then
#echo "$GRADE is 良好"
#else
#echo "$GRADE is 不合格" 
#fi

