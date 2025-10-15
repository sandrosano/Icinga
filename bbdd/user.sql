CREATE DATABASE IF NOT EXISTS icingadb;
CREATE USER IF NOT EXISTS 'icingadb'@'%' IDENTIFIED BY 'icing12bns98h4';
GRANT ALL ON icingadb.* TO 'icingadb'@'%';GRANT ROLE_ADMIN on *.* TO 'icingadb'@'%';
GRANT SESSION_VARIABLES_ADMIN on*.* TO 'icingadb'@'%';
GRANT SYSTEM_VARIABLES_ADMIN on*.* TO 'icingadb'@'%';

CREATE DATABASE icingaweb2;
CREATE USER 'icingaweb2'@'%' IDENTIFIED BY 'icingawebPW';
GRANT ALL ON icingaweb2.* TO 'icingaweb2'@'%';

CREATE DATABASE director CHARACTER SET 'utf8';
CREATE USER 'director'@'%' IDENTIFIED BY 'directorPW';
GRANT ALL ON director.* TO 'director'@'%';