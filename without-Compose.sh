#  Without Compose if Docker-compose wont work.
# docker stop master1 master2 bbdd web sonda influx grafana
docker container rm master1 master2 bbdd web sonda influx grafana

docker network create --subnet=172.18.0.0/16 icinganet
docker build ./master/. -t sandrosano/icingamaster0-1
docker build ./web/. -t sandrosano/icingaweb0-1
docker build ./sonda/. -t sandrosano/icingasonda0-1

docker run -d --name master1 --net icinganet --ip 172.18.0.10 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro sandrosano/icingamaster0-1   
echo 'unpriviledged alternative might be avilable but i dont care about sec NOW in dev mode. generally , systemD in unprivileged docker is difficult to get working properly.'
# docker run -d --name master2 --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro jrei/systemd-debian /install.sh
echo "Master1 config"
docker exec master1 /bin/bash -c 'sh /config.sh'


docker run -d --name master2 --net icinganet --ip 172.18.0.11 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro sandrosano/icingamaster0-1  
echo "Master2 config"
docker exec master2 /bin/bash -c 'sh /config.sh'
#
#
read -p "Everything okay? Lets Continue, press enter key.." REPLY
#
#
echo 'secure Password management will be introduced later when everything works.'
docker volume create bbdd-var-lib-mysql
docker run --name bbdd -v bbdd-var-lib-mysql:/var/lib/mysql  --net icinganet --ip 172.18.0.13 -e MYSQL_ROOT_PASSWORD=myrootpw -d mysql:8
echo "bbdd user"
wait 2
docker cp ./bbdd/user.sql bbdd:/user.sql
docker exec -it bbdd /bin/bash -c 'mysql -u root -pmyrootpw  < /user.sql' 
docker exec -it bbdd /bin/bash -c 'mysql -u root -pmyrootpw -e "SET PERSIST require_secure_transport=OFF;"'
docker exec -it bbdd /bin/bash -c 'mysql -u root -pmyrootpw -e "set global log_bin_trust_function_creators=1"' 
#
#
read -p "Everything okay? Lets Continue, press enter key.." REPLY
#
echo "Master-to-DB Init, table schema"
echo 'Dev Mode: NO SSL configuren for DB connection: --skip-ssl'
docker exec -it master1 /bin/bash -c "mysql -u icingadb -p icingadb --password=icing12bns98h4 --host=172.18.0.13 --skip-ssl </usr/share/icingadb/schema/mysql/schema.sql"
docker exec master1 /bin/bash -c 'systemctl enable --now icingadb'
docker exec master2 /bin/bash -c 'systemctl enable --now icingadb'
docker exec master1 /bin/bash -c 'systemctl restart icingadb'
docker exec master2 /bin/bash -c 'systemctl restart icingadb'
#
#
read -p "Everything okay? Lets Continue, press enter.."   REPLY
#
#
echo "Master1 Wizard"
docker exec -it master1 /bin/bash -c "icinga2 node wizard"
docker exec -it master1 /bin/bash -c 'systemctl restart icinga2'

docker exec -it master1 /bin/bash -c "sed -i '6c\object Endpoint \"master1\" {    host = \"172.18.0.10\" } ' /etc/icinga2/zones.conf"
docker exec -it master1 /bin/bash -c "sed -i '7c\object Endpoint \"master2\" {    host = \"172.18.0.11\" } ' /etc/icinga2/zones.conf"
docker exec -it master1 /bin/bash -c "sed -i '10c\        endpoints = [\"master1\",\"master2\"]  ' /etc/icinga2/zones.conf"
docker exec -it master1 /bin/bash -c 'vi /etc/icinga2/zones.conf'
docker exec -it master1 /bin/bash -c 'systemctl restart icinga2'
docker exec -it master1 /bin/bash -c "sed -i \"5c\  accept_config = true\" /etc/icinga2/features-enabled/api.conf"
docker exec -it master1 /bin/bash -c "sed -i \"6c\  accept_commands = true\" /etc/icinga2/features-enabled/api.conf"
docker exec -it master1 /bin/bash -c "sed -i \"7c\  ticket_salt = TicketSalt  }\" /etc/icinga2/features-enabled/api.conf"
docker exec -it master1 /bin/bash -c 'vi /etc/icinga2/features-enabled/api.conf'
docker exec -it master1 /bin/bash -c 'systemctl restart icinga2'
docker exec -it master1 /bin/bash -c 'systemctl restart icinga2.service'

echo "Master2 Wiszard"
docker exec -it master2 /bin/bash -c "icinga2 node wizard"
docker exec -it master2 /bin/bash -c 'systemctl restart icinga2'
docker exec -it master2 /bin/bash -c "sed -i '6c\object Endpoint \"master2\" {    host = \"172.18.0.11\" } ' /etc/icinga2/zones.conf"
docker exec -it master2 /bin/bash -c "sed -i '7c\object Endpoint \"master1\" {    host = \"172.18.0.10\" } ' /etc/icinga2/zones.conf"
docker exec -it master2 /bin/bash -c "sed -i '10c\        endpoints = [\"master2\",\"master1\"]  ' /etc/icinga2/zones.conf"
docker exec -it master2 /bin/bash -c 'systemctl restart icinga2'
docker exec -it master2 /bin/bash -c "sed -i \"5c\  accept_config = true\" /etc/icinga2/features-enabled/api.conf"
docker exec -it master2 /bin/bash -c "sed -i \"6c\  accept_commands = true\" /etc/icinga2/features-enabled/api.conf"
docker exec -it master2 /bin/bash -c "sed -i \"7c\  ticket_salt = TicketSalt  }\" /etc/icinga2/features-enabled/api.conf"
docker exec -it master2 /bin/bash -c 'systemctl restart icinga2'
docker exec -it master2 /bin/bash -c 'vi /etc/icinga2/constants.conf'
docker exec -it master2 /bin/bash -c 'systemctl restart icinga2.service'
#
#
read -p "Everything okay? Lets Continue, press enter key.."  REPLY
#
#
echo "Web config"
docker run -d --name web --net icinganet --ip 172.18.0.12 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro sandrosano/icingaweb0-1   


docker exec -it web /bin/bash -c 'icingacli setup token create' | tee ./web/token.txt
docker exec -it web /bin/bash -c 'systemctl restart icinga-director'
#
#
#
read -p "Everything okay? Lets Continue, press enter key.."  REPLY
#
#
#
echo -p "lets compare config across masters.." REPLY
docker exec -it master1 /bin/bash -c 'icinga2 daemon -C'
docker exec -it master2 /bin/bash -c 'icinga2 daemon -C'
#
#
#
echo -p " lets config the sonde like the following" REPLY
cat ./sonda/tutorial-Node-Wizard.txt
docker exec master1 /bin/bash -c "icinga2 pki ticket --cn 'sonda1'" | tee ./sonda/sonda1.token
echo "token for sonda1"
cat ./sonda/sonda1.token
echo -p " using for sonda1 upper token ( for other sondas please generate new )" REPLY
docker run -d --name sonda1 --net icinganet --ip 172.18.0.16 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro sandrosano/icingasonda0-1   
docker exec sonda1 /bin/bash -c 'sh /config.sh' # evtl to merge with install.sh
docker exec -it sonda1 /bin/bash -c 'systemctl restart icinga2'
docker exec -it sonda1 /bin/bash -c "icinga2 node wizard"
docker exec -it sonda1 /bin/bash -c 'systemctl restart icinga2'

echo -p "if you want to backup web and bbdd and mysql data as state is nonconsistent after UI manual input.. EXECUTE Manually FOLLOWING: sudo tar -cvf ./images/bbdd-var-lib-mysql_setted-L114 /var/lib/docker/volumes/bbdd-var-lib-mysql/_data && docker export bbdd > ./images/bbdd_setted-L114.tar && docker export web > web_setted-L114.tar   " REPLY


echo -p "Now lets check thecentreon plugins" REPLY
docker exec -it sonda1 /bin/bash -c '/usr/lib/nagios/plugins/centreon-plugins/src/centreon_plugins.pl --plugin=os::linux::snmp::plugin --list-mode'