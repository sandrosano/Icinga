docker run --rm -d --name web\
	-p 8080:8080 \
	-v icingaweb:/data \
	-e icingaweb.enabledModules=icingadb \
	-e icingaweb.passwords.icingaweb2.icingaadmin=123456 \
	-e icingaweb.authentication.icingaweb2.backend=db \
	-e icingaweb.authentication.icingaweb2.resource=icingaweb_db \
	-e icingaweb.config.global.config_backend=db \
	-e icingaweb.config.global.config_resource=icingaweb_db \
	-e icingaweb.config.logging.log=php \
	-e icingaweb.groups.icingaweb2.backend=db \
	-e icingaweb.groups.icingaweb2.resource=icingaweb_db \
	-e icingaweb.modules.icingadb.config.icingadb.resource=icingadb \
	-e icingaweb.modules.icingadb.redis.redis1.host=2001:db8::192.0.2.18 \
	-e icingaweb.modules.icingadb.redis.redis1.port=6380 \
	-e icingaweb.modules.icingadb.commandtransports.icinga2.transport=api \
	-e icingaweb.modules.icingadb.commandtransports.icinga2.host=2001:db8::192.0.2.9 \
	-e icingaweb.modules.icingadb.commandtransports.icinga2.username=root \
	-e icingaweb.modules.icingadb.commandtransports.icinga2.password=123456 \
	-e icingaweb.resources.icingaweb_db.type=db \
	-e icingaweb.resources.icingaweb_db.db=mysql \
	-e icingaweb.resources.icingaweb_db.host=2001:db8::192.0.2.13 \
	-e icingaweb.resources.icingaweb_db.dbname=icingaweb \
	-e icingaweb.resources.icingaweb_db.username=icingaweb \
	-e icingaweb.resources.icingaweb_db.password=123456 \
	-e icingaweb.resources.icingaweb_db.charset=utf8mb4 \
	-e icingaweb.resources.icingadb.type=db \
	-e icingaweb.resources.icingadb.db=mysql \
	-e icingaweb.resources.icingadb.host=2001:db8::192.0.2.113 \
	-e icingaweb.resources.icingadb.dbname=icingadb \
	-e icingaweb.resources.icingadb.username=icingaweb \
	-e icingaweb.resources.icingadb.password=123456 \
	-e icingaweb.resources.icingadb.charset=utf8mb4 \
	-e icingaweb.roles.Administrators.users=icingaadmin \
	-e icingaweb.roles.Administrators.permissions='*' \
	-e icingaweb.roles.Administrators.groups=Administrators \
	icinga/icingaweb2


docker run --rm -v icingaweb:/data icinga/icingaweb2 icingacli setup token create