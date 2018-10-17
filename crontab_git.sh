#/bin/bash/

#定时任务中，用来拉新git仓库的脚本
cd /usr/michael/learnlinux/  
git pull

#sh /usr/michael/learnlinux/crontab_git_commit_am_date.sh &>> crontab_git_commit_am_date.log————把shell执行输出的结果追加到日志
#定时任务中，用来提交至git仓库和推新git仓库的脚本
git commit -am  "`date`"  
echo '———————————— 上 git commit -am ———— 下 git psuh ———————————————'
git push
date &>>crontab_git.log
cd -

