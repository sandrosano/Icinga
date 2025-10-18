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
- "icingacli module enable setup"   for redoing web setup: [http://172.18.0.12/icingaweb2/setup](http://172.18.0.12/icingaweb2/setup)
- best practice & background for troublesshooting [link](https://www.neteye-blog.com/2022/03/hosts-zones-and-broken-icinga-2-configurations/)
  - "Also, the configuration broke because the functionalities and configurations related to the concept of monitoring are bound together with settings related to the concept of distributivity. So decoupling them can be an effective solution. To implement this kind of scenario, we must make use of multiple inheritance: in short, we have to relegate all settings related do Cluster Zones to a dedicated set of Host Templates, which creates another Host Template Tree."
  
# Manual config steps
- example Centreon command: /usr/lib/nagios/plugins/centreon-plugins/src/centreon_plugins.pl --plugin=os::linux::snmp::plugin --mode cpu --hostname 172.18.0.13 --snmp-version 2 --snmp-community icinga.com --verbose --warning-average 25 --critical-average 50


- commands - arguments
  - define the program path, set arguments leaving everything empty but the namme & value field. However, in this tutorial for  $cnt_critical$, $cnt_warning$  no name was set, why?...
  - add these ARGS to fields
  - for windows, check external commands, nscp_api.

- service templates:
  - create a template for Agend or No-agent hosts, defining check intervals ecc.
  - create a template and import upper template, and use as check-command the command you previously created ("eg. cnt (centreon)") which imports other presets like the arguments of hte specific commands
  - ad args like snmp_community in the "fields" tab, if you dont see them in the service template
  - you can add  values like $host.vars.snmp_community$ to the new field
    - in linux-no-agend-host-template  in tab fields add args, eg snmpt comuntiy
  - now this field "snmpt community" appears in all hosts, so you can define the value for the host you would like to
  - make new copy of cnt_general template and add field interrface name and set in service tab values: (and therefore adapt the command to monitor interfaces)
      - add plugin [](os:linux:snmp:plugin)
      - add mode interfaces
      - add verbose yes 
  - change data field interface_name value type string to arrayy, so you can save more and monitor multiple interfaces in one host