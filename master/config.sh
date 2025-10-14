# crontab -l > crontab_new
# echo "@reboot icinga2 api setup && systemctl restart icinga2" > crontab_new
# crontab crontab_new

icinga2 api setup
systemctl restart icinga2
sed -i '/password = /c\  password = "icing12bns98h4"' /etc/icinga2/conf.d/api-users.conf 
systemctl restart icinga2

systemctl enable --now icingadb-redis-server

sed -i '1s/^/bind 0.0.0.0 /' /etc/icingadb-redis/icingadb-redis.conf 
sed -i '/protected-mode /c\protected-mode no' /etc/icingadb-redis/icingadb-redis.conf 
systemctl restart icingadb-redis


icinga2 feature enable icingadb 
systemctl restart icinga2 

# pass=$(< ../passwords/passicingadbmysql)
pass=icing12bns98h4
sed -i "/password: /c\ password: $pass" /etc/icingadb/config.yml
systemctl restart icingadb