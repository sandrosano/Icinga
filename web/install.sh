apt-get update
apt-get -y install apt-transport-https wget gnupg
wget -O - https://packages.icinga.com/icinga.key | apt-key add -
DIST=$(awk -F"[)(]+" '/VERSION=/ {print $2}' /etc/os-release); \ echo "deb
https://packages.icinga.com/debian icinga-${DIST} main" > \
/etc/apt/sources.list.d/${DIST}-icinga.list echo "deb-src
https://packages.icinga.com/debian icinga-${DIST} main" >> \
/etc/apt/sources.list.d/${DIST}-icinga.list
apt-get update
apt-get install -y icingaweb2 icingacli

apt update
apt -y install apt-transport-https wget

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
apt install -y icingadb-web
apt install -y icinga-director