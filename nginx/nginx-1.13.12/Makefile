
default:	build

clean:
	rm -rf Makefile objs

build:
	$(MAKE) -f objs/Makefile

install:
	$(MAKE) -f objs/Makefile install

modules:
	$(MAKE) -f objs/Makefile modules

upgrade:
	/usr/michael/learnlinux/nginx/nginx/sbin/nginx -t

	kill -USR2 `cat /usr/michael/learnlinux/nginx/nginx/logs/nginx.pid`
	sleep 1
	test -f /usr/michael/learnlinux/nginx/nginx/logs/nginx.pid.oldbin

	kill -QUIT `cat /usr/michael/learnlinux/nginx/nginx/logs/nginx.pid.oldbin`
