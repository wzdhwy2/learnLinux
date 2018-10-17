#/bin/bash/
#定时任务中，用来更新git仓库的脚本

cd /usr/michael/learnlinux/  
git push
date &>>/usr/michael/learnlinux/crontab_git_push.log  
cd -

