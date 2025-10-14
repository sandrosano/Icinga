
# Run the MySQL Secure Installation wizard
mysql_secure_installation

sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
mysql -u root -p -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

service mysql restart

# pass=$(< ../passwords/passicingadbmysql)
pass=icing12bns98h4

# % = is for connecting to master 1 &2
mysql -u root -p "CREATE DATABASE icingadb;
CREATE USER 'icingadb'@'%' IDENTIFIED BY "$pass";
GRANT ALL ON icingadb.* TO 'icingadb'@'%';GRANT ROLE_ADMIN on *.* TO 'icingadb'@'%';
GRANT SESSION_VARIABLES_ADMIN on*.* TO 'icingadb'@'%';
GRANT SYSTEM_VARIABLES_ADMIN on*.* TO 'icingadb'@'%';
"