#!/bin/bsah/
#脚本最上面，最左边，顶格。“#”“！”声明。

变量：一个命名的内存空间
	
编程程序语言
	强类型
	弱类型
	
逻辑运算
	与
		1 && 1 =1
		1 && 0 =0
		0&&1 =1
		0&&0 =0
	或
		1||1 =1
		1||0 =1
		0||1 =1
		0||0 =0
	非
		! 1 =0
		! 0 =1
	亦或
		
	短路运算
		与：
			第一个为0.结果必0
			第一个为1，必看第二个
		
#!/bin/bash/
#顶格井号加感叹号
	
	
		grep,egrep,fgrep:最擅长，行过滤
		sed:最擅长，（文本）行编辑工具
		awk:最擅长，文本报告生成器
		
	
	grep
		作用:根据用户指定的模式对目标进行逐行匹配检查：输出匹配的行：
		模式：由正则表达式字符及文本字符所编写的过滤条件：
		元字符：由一类特殊字符及文本字符所编写的模式，其中有些字符不表示字符字面意义，
		而表示控制或通配的功能
		
		分两类 
			基本正则:BRE
			扩展正则:ERE
		
		选项
			--color-auto;对匹配到的文本着色显示
			-v:显示不能够被patterm匹配到的行
			-i:忽略字符大小写
			-o:仅显示匹配到的字符串
			-q:静默模式，不输出任何信息
			-A:after,后#行
			-B:before，前#行
			-C:context,前后各#行
			-E:使用ERE
			
	基本正则表达式元字符：
		字符匹配；
			. 匹配任意单个字符
			[] 范围内的任意单个字符
			[^] 范围外的任意单个字符
			[:digit:]、
			[:lower:]、所有小写字母
			[:upper:]、所有大写字母
			[:alpha:]、所有大小写字母



		匹配次数；
		位置匹配；





