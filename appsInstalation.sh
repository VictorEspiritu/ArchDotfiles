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

