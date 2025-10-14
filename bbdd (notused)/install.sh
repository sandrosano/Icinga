
apt-get update 
apt-get upgrade -y 
apt-get install -y gnupg apt-transport-https wget vim cron



apt install gnupg
wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb
dpkg -i mysql-apt-config_0.8.29-1_all.deb
apt-get update
apt install -y mysql-server
systemctl enable mysql
systemctl start mysql

 

# echo "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';
# DELETE FROM mysql.user WHERE User='';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# DROP DATABASE IF EXISTS test;
# DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# FLUSH PRIVILEGES;" >> mysql_secure_installation.sql

# mysql -sfu root < "mysql_secure_installation.sql"



# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server-8.0 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-8.0 mysql-server/root_password_again password root" | debconf-set-selections
apt-get -y install mysql-server-8.0

