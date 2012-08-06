server {
	listen [::]:80;
	server_name nx06.doesnthaveone.com;

	root /home/chris/public_html/nx06.doesnthaveone.com/public;

	access_log /home/chris/public_html/nx06.doesnthaveone.com/logs/access.log;
	error_log /home/chris/public_html/nx06.doesnthaveone.com/logs/error.log;

	include fastcgi_params;

	location / {
		try_files $uri $uri/ /index.php;
	}

	location /status {
		fastcgi_pass php;
	}

	location /ping {
		fastcgi_pass php;
	}

	location ~ \.php$ {
		fastcgi_pass php;
	}
}