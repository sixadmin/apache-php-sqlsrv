# apache-php-sqlsrv

![docker_logo](https://raw.githubusercontent.com/sixadmin/apache-php-sqlsrv/master/sqlsrv.png)

How to use this image
----

Create a www directory and copy your php files in this folder

```bash
docker run -p "80:80" -v ${PWD}/www:/var/www/html 6admin/apache-php-sqlsrv
```

Then, you can access to your container on http://localhost

There is no mssql database on this container.