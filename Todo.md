# Additional to Lab:
- c
- Dockerfiles to containerize each lab- instance
- highly-available, replicated databases
- routing Masters to DB when fail-over, Network Bonding ( type depends on DB-cluster, if to configure externally , or internally (with or without broker) - and if you want independent fail save replicas of which internally nodes are load balanced, or let the DB cluster  manage replication and loadbalancing  ) 
- seperate network between metrics and config/meintanace data streams

# Optional:
- Kubernetes to Orchestrate the Containers
- Ansible to Automate Deployment on future Instances or for future updates
- Terraform to automate instance definition