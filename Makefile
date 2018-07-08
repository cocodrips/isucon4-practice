WORKLOAD = 1
HOSTS=127.0.0.1
.PHONY: main settings nginx bench

main: settings nginx bench
	echo "OK"

settings:
	sudo ln -sf $(PWD)/sysctl.conf /etc/sysctl.conf
	sudo sysctl -a	
	sudo ln -sf $(PWD)/supervisord.conf /etc/supervisord.conf
	sudo supervisorctl reload
	
nginx: 
	sudo ln -sf $(PWD)/nginx /etc/nginx
	sudo rm -f /var/log/nginx/access.log /var/log/nginx/error.log
	sudo touch /var/log/nginx/access.log /var/log/nginx/error.log
	sudo service nginx reload

bench:
	sudo su - isucon -c "/home/isucon/benchmarker bench --hosts=${HOSTS} --workload=${WORKLOAD}"
