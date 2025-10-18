# Additional to Lab:
- automate node wizard [](https://icinga.com/docs/icinga-2/latest/doc/06-distributed-monitoring/#distributed-monitoring-automation)
- SSL
- sec: substitute passwords in scripts with CLI arg injection, to point passwords in ARG to key-files, 
  - decide how tomanage and transfer keys
- full high-availability
  - highly-available, replicated database instancess
  - routing Masters to DB when fail-over, Network Bonding ( type depends on DB-cluster, if to configure externally , or internally (with or without broker) - and if you want independent fail save replicas of which internally nodes are load balanced, or let the DB cluster  manage replication and loadbalancing  ) 
- seperate network between metrics and config/meintanace(WEB) data streams
  - bind - options of all servers to point just to the locally interesting network, or settup firewalls
- Sshd with key for all (just from config network)
  

# Optional:
- docker compose to substitute without-compose.sh
- Kubernetes to Orchestrate the Containers
- Ansible to Automate Deployment on future Instances or for future updates, instead of .Install script
- Terraform to automate instance definition
