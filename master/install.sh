
apt-get update 
apt-get upgrade -y 
apt-get install -y snmpd apt-transport-https wget vim cron





sed -i "/^127.0.1.1/a\
    172.18.0.10 master1.icinga.com master1  \n
    172.18.0.11 master2.icinga.com master2
    " /etc/hosts

sed -i "/^agentaddress/c\
    agentaddress 0.0.0.0
    " /etc/snmpd/snmpd.conf 

sed -i '/^rocommunity=/a\rocommunity icinga
    ' /etc/snmpd/snmpd.conf 


systemctl enable snmpd 

wget -O icinga-archive-keyring.deb "https://packages.icinga.com/icinga-archive-keyring_latest+debian$(
 . /etc/os-release; echo "$VERSION_ID"
).deb"

apt install -y ./icinga-archive-keyring.deb 

DIST=$(awk -F"[)(]+" '/VERSION=/ {print $2}' /etc/os-release); \
 echo "deb [signed-by=/usr/share/keyrings/icinga-archive-keyring.gpg] https://packages.icinga.com/debian icinga-${DIST} main" > \
 /etc/apt/sources.list.d/${DIST}-icinga.list
 echo "deb-src [signed-by=/usr/share/keyrings/icinga-archive-keyring.gpg] https://packages.icinga.com/debian icinga-${DIST} main" >> \
 /etc/apt/sources.list.d/${DIST}-icinga.list

apt update

apt install -y icinga2

icinga2 daemon 2>&1 | tee -a /var/log/icinga2/configCheck.log

apt install -y monitoring-plugins
apt install -y nagios-snmp-plugins
apt install -y snmp
apt install -y libfile-slurp-unicode-perl
apt install -y perl libsnmp-perl libnet-snmp-perl
apt install -y libxml-libxml-perl libjson-perl libwww-perl libxml-xpath-perl libnet-telnet-perl libnet-ntp-perl libnet-dns-perl libdbi-perl libdbd-mysql-perl libdbd-pg-perl 


apt install -y icingadb-redis
apt install -y icingadb gnupg  default-mysql-client
