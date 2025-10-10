# Accessing my provided Ubuntu Lab Instance behind NAT and Firewall from anywhere

- start instance & make this host system behind NAT accessible: 
  - ssh -R SomePort:localhost:22 name@conncetingServer -p ExposedPort
- access protected system: 
  - ssh name@connectingServer -p exposedPort 
  - ssh protectedHostUser:localhost -p  SomePort

# dependecies
- install docker
  - if with snap:
    - sudo addgroup --system docker
    - sudo adduser $USER docker
    - newgrp docker
    - sudo snap enable docker
    - docker network create --subnet=172.18.0.0/16 icingaNet
- git clone https://github.com/sandrosano/Icinga.git
- sh Init.sh

# variations from Course Lab
- no dhcp config as docker is managing IP adresses
