# Prototype-Development Script TODO sustitute with Orchestration Tool like docker-compose or kubernetes (see below)
sh without-compose.sh

# TODO Fix Docker-Compoose error "ContainerConfig" and uncomeent this section compose

# docker build ./master/. -t sandrosano/icingamaster0-1 --remove-orphans
# docker build ./master/. -t sandrosano/icingamaster0-1
# docker build ./web/. -t sandrosano/icingaweb0-1
# docker build ./sonda/. -t sandrosano/icingasonda0-1
# docker-compose up --remove-orphans