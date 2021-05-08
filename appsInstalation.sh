# ---- Mysql
#1- Instalation Mysql Server: 
 sudo apt-get install mysql-server
#2- Instalation Mysql Client: 
 sudo apt-get install mysql-client
#3- Create User 
 CREATE USER 'backend'@'%' IDENTIFIED BY 'rootrootroot3';
 GRANT ALL PRIVILEGES ON *.* TO 'backend'@'%';
 GRANT CREATE, SELECT, UPDATE, DELETE, INSERT, ALTER ON *.* TO 'backend'@'%';
#4- Open port for remote connection
 sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
 # bind-address          = 127.0.0.1
#5- Connect remote and load database
 mysql -u backend -p -h 10.0.1.252
 mysql -u backend -p -h 10.0.1.252 < aws-workshop/backend/dump/db.sql

  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
   sudo apt-get install -y nodejs

#Show columns from tables;
show columns from Posts;

#Pm2
pm2 start npm --name app  -- run start:pro --

 apt-get update 
 apt-get install apache2 libapache2-mod-php php php-mcrypt php-mysql mysql-client-core-5.7 -y 
 cd /var/www/html 
 mv index.html index.html.bk 
 wget https://wordpress.org/latest.tar.gz 
 tar -xzf latest.tar.gz 
 cp -r wordpress/* /var/www/html/ 
 rm -rf wordpress latest.tar.gz 
 chown -R www-data:www-data /var/www/html 
 chmod -R 755 /var/www/html/wp-content 
 service apache2 restart
rm-4xoo079g5lt472498.mysql.germany.rds.aliyuncs.com
