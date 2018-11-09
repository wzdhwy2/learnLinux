#!/bin/bash
#

DBname="` cat DBname.txt `"
logdate="` date +%Y%m%d `"

logdateS=` date -d "1 days ago" +%Y%m%d `
#旧文件夹的带S
db_log="db_$logdateS-$logdate"
mkdir $db_log


for DBnameS in $DBname
do

	#tbnameS=` awk '{print$1}' ./$logdateS/$DBnameS `
	#只以新表名为准！必须要以一项表名才能做对比，不能一次性对比所有表
        tbname=` awk '{print$1}' ./$logdate/$DBnameS `
	#tbname_nr=` awk '{print$1,$2,$3}' ./$logdate/$DBnameS ` 
	#没有意义，库情况文件已经包含了要的内容

        cp -R ./$logdate/$DBnameS ./$db_log/$DBnameS
	#echo $tbname >./$db_log/$DBnameS

	#export DBnameS
	#你可以做到更好的，遇到这个问题1.是传值的问题吗？加一个试一下。2.检查变量名，发现写错了。0.直接百度，for内变量是否是全局变量吗？怎么解决？像修电脑一样，要明确每一层检查对了再进行下一步，不要搞了半天是变量名写错了！！！

        for tbnameS in $tbname
        do
	
		#dq_tbnameS="` grep $tbnameS `"
		#没有必要单独过滤当前的行（表情况），sed自带过滤匹配功能，匹配当前for到的表名的项，就输出$2
                tbroS=` grep -w "$tbnameS" ./$logdateS/$DBnameS | awk '{print$2}' `
                tbro=` grep -w "$tbnameS" ./$logdate/$DBnameS | awk '{print$2}' `
                #awk ' 模式  {动作} '  ：awk模式中，用单引号时模式中的变量被屏蔽的情况，首次攻克花了1个小时以上，别人只花了10分钟。
		#你发现了什么？有效快速解决问题——事后发现有一些什么样的规律吗？事前的进度为什么推的这么慢？
		#你有什么做的比编上个程序做的好的地方？做的不足的地方？
		db_tbro=$[tbro-tbroS]
                tbsizeS=` grep -w "$tbnameS" ./$logdateS/$DBnameS | awk '{print$3}' `
                tbsize=` grep -w "$tbnameS" ./$logdate/$DBnameS | awk '{print$3}' `
                db_tbsize=$[tbsize-tbsizeS]
                sed -i ' s/'$tbnameS'/'$tbnameS'       '$db_tbro'——'$tbro'        '$db_tbsize'——'$tbsize'	/g' ./$db_log/$DBnameS
		
		
        done

done


