# Accessing my provided Ubuntu Lab Instance behind NAT and Firewall from anywhere

- start instance & make this host system behind NAT accessible: 
  - ssh -R SomePort:localhost:22 name@conncetingServer -p ExposedPort
- access protected system: 
  - ssh name@connectingServer -p exposedPort 
  - ssh protectedHostUser:localhost -p  SomePort

# dependecies
<!-- - install docker (not anymore)
  - if with snap:
    - sudo addgroup --system docker
    - sudo adduser $USER docker
    - newgrp docker
    - sudo snap enable docker
    - docker network create --subnet=172.18.0.0/16 icingaNet -->
- install podman: sudo apt install podman=3.4.4+ds1-1ubuntu1
- install podman-compose (pip)
- git clone https://github.com/sandrosano/Icinga.git
- sh Init.sh

# variations from Course Lab
- no dhcp static ip config as docker is managing IP adresses
- OPTIONAL static ip + name resolution via docker-icingaNet (currently off) :
  - currently no name resolution via /etc/hosts, as managed by docker, but theoretically can be turned on uncommenting icingaNet in docker-compose  and launching containers on this custom subnet with static ips 

# other stuff
- useful command: docker rm $(docker ps -aq)
- 