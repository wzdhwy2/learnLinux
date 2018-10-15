#/bin/bash/
#sh /usr/michael/learnlinux/crontab_git_commit_am_date.sh 
#&>> crontab_git_commit_am_date.log
#定时任务中，用来提交git仓库的脚本

cd /usr/michael/learnlinux/
git commit -am  "`date`"  
echo '———————————— 上 git commit -am ———— 下 git psuh ———————————————'
git push
date &>> crontab_git_commit_am_date.log
cd -

