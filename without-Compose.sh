#  Without Compose if Docker-compose wont work.
docker stop master1 master2 bbdd web sonda influx grafana
docker container rm master1 master2 bbdd web sonda influx grafana

docker network create --subnet=172.18.0.0/16 icinganet
docker build ./master/. -t sandrosano/icingamaster0-1


docker run -d --name master1 --net icinganet --ip 172.18.0.10 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro sandrosano/icingamaster0-1   
# unpriviledged alternative but i dont care about SEC NOW.
# docker run -d --name master2 --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro jrei/systemd-debian /install.sh
echo "Master1 config"
docker exec master1 /bin/bash -c 'sh /config.sh'


docker run -d --name master2 --net icinganet --ip 172.18.0.11 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro sandrosano/icingamaster0-1  
echo "Master2 config"
docker exec master2 /bin/bash -c 'sh /config.sh'
#
#
#
#pass= $(< ./passwords/passmysql)
docker run --name bbdd  --net icinganet --ip 172.18.0.13 -e MYSQL_ROOT_PASSWORD=myrootpw -d mysql:8
#  for doccker compose:  https://hub.docker.com/_/mysql/
echo "bbdd config"
# docker cp ./bbdd/config.sh bbdd:/config.sh
# docker exec bbdd /bin/bash -c '/config.sh' ALTERNATIVLY UNTIL END_BBDD_CONFIG here the config:
docker container restart bbdd
# pass=$(< ../passwords/passicingadbmysql)
# docker exec -it bbdd /bin/bash -c 'mysql_secure_installation'docke
docker exec -it bbdd /bin/bash -c 'mysql -u root -pmyrootpw "CREATE DATABASE icingadb;
CREATE USER 'icingadb'@'%' IDENTIFIED BY "icing12bns98h4";
GRANT ALL ON icingadb.* TO 'icingadb'@'%';GRANT ROLE_ADMIN on *.* TO 'icingadb'@'%';
GRANT SESSION_VARIABLES_ADMIN on*.* TO 'icingadb'@'%';
GRANT SYSTEM_VARIABLES_ADMIN on*.* TO 'icingadb'@'%';
"'
# END_BBDD_CONFIG
#
#
#
# passicdb=$(< ./passwords/passicingadbmysql)
echo "DB Init"
docker exec -it master1 /bin/bash -c "mysql -u icingadb --password=icing12bns98h4 -172.18.0.13 </usr/share/icingadb/schema/mysql/schema.sql"
docker exec master1 /bin/bash -c 'systemctl enable --now icingadb'
docker exec -it master2 /bin/bash -c 'mysql -u icingadb -p icingadb -h 172.18.0.13 </usr/share/icingadb/schema/mysql/schema.sql'
docker exec master2 /bin/bash -c 'systemctl enable --now icingadb'
#
#
#
echo "Master1 Wizard"
docker exec -it master1 /bin/icinga2 node wizard
echo "Master2 Wiszard"
docker exec -it master2 /bin/icinga2 node wizard


