icinga2 api setup
systemctl restart icinga2
sed -i '/password = /c\  password = "icing12bns98h4"' /etc/icinga2/conf.d/api-users.conf 
systemctl restart icinga2