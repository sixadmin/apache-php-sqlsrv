# apache-php-sqlsrv

![sqlsrv](https://raw.githubusercontent.com/sixadmin/apache-php-sqlsrv/master/sqlsrv.png)
![sqlsrv2](https://raw.githubusercontent.com/sixadmin/apache-php-sqlsrv/master/sqlsrv2.png)

How to use this image
----

Create a www directory and copy your php files in this folder

```bash
docker run -p "80:80" -v ${PWD}/www:/var/www/html 6admin/apache-php-sqlsrv
```

Then, you can access to your container on http://localhost

You can access to the database management tool adminer on http://localhost/adminer.php

There is no mssql database on this container.