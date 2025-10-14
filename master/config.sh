# API USER root
icinga2 api setup 
systemctl restart icinga2
sed -i '/password = /c\  password = "icing12bns98h4"' /etc/icinga2/conf.d/api-users.conf 
systemctl restart icinga2

systemctl enable --now icingadb-redis-server

sed -i '87c\bind 0.0.0.0' /etc/icingadb-redis/icingadb-redis.conf 
sed -i '/protected-mode /c\protected-mode no' /etc/icingadb-redis/icingadb-redis.conf 
systemctl restart icingadb-redis


icinga2 feature enable icingadb 
systemctl restart icinga2 

# pass=$(< ../passwords/passicingadbmysql)
#line 24
sed -i "12c\  host: 172.18.0.13" /etc/icingadb/config.yml
sed -i "24c\  password: icing12bns98h4" /etc/icingadb/config.yml
systemctl restart icingadb