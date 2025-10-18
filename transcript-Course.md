Sorry for strange Transscript, the original Course is in Spanish, and sometimes i get confused in translating his and my thoughts. 
https://www.udemy.com/course/monitorizacion-distribuida-con-icinga2-de-cero-a-experto/learn/lecture/41830972#overview

verifies  system  disponibiklity, notifies about interruption or anomalies, and generates stats
with scaling system,  you can limit resource consumption or create more monitoring-machines, to cope with work
icinga Web,front end for watching system evolution
icinga director for configuring and modifieying via web UI

we need ot garantee stability efficiency and sequirity
we need to identify and abort possible problems, prevenir before they affect standart operations.
we need to provide the tools to optimize the performacne of infrastructure we are monitoring.

we need to know three concepts:
,metrics events and alerts
metrics are quantified data indicating health
events are records of events important to analysis and problemsolving
alerts are automatic notiviation of unexpected or critical events 

e.g. event " CPU 80%" triggers alarm


# Components

icinga2 Core / Master
manages the supervision, manages schedzuling checkups, handle events, sedn notificatino
can have two master nodes or more.
high availability, for failsafety,

Icinga2 NOW uses REDIS for temporal inmemory safe, then goes to MySQL or PG 
Director (additional): config Frontend UIWEB

## 5 vs 2 satellites, and Icinga Client:
satelite: distributed arch, IcingaAgend collects data locally or also to some servers and sends the results to the master
Client: agend is installed on a node, monitors,runs checks locally  and sends results to Master or to the responsable Satelite.

areas / load distribution / horiyontal scaling

## SNMP (1.arch,2.comunity/envir,3.sec): simple net manag prot
for transmitting info about hard and software
works on UDP port 161
send question to SNMP device via OID (object identifier (key)), device responds with info(value). 
simple , light, little network load, flexible

## NSC Client (windows)
API listens to 8403 and answers TCP and facilitates Windows integration


# lab architecture
2 Masters in claster
icinga web communicate with Masters
OP data saved in base data machine
Metrics data saved in Influx machine
Satellite monitores SNMP in Linux and also API NSC Client windows and sends to Masters
Grafama qieroes omföix tp üerformc rendering data graphs
icinga web module represents graphana graphs

# install
create IPS table
master1: 192.168.1.(or whatever router brings) .10 , master2 .11, web .12 , bbdd (mysql) .13 , influx .14, graphana .15, sonda( satellite) .16, windowsClient .17, 

# introduction icinga WEB
- visualisation÷: 
  - Host with search feature
  - service with search feature
  - host groups with search feature, grouping hosts to better visualise them and their cvonnections
- director
  -  host objects we can 
     -  make taemplates to   facilitate creation of hosts
     -  group these hosts to vsiisualize them better
  -     nofiications
  -     users which recieve notifications
  -     program doowntimes
  -     import data source, where we can read only, we can integrate these metrics and syncronise and twe do not create an dedicated host for thes
  -     activity log for changes to director
  -     config commit dates
  -     icinga infrastructure with
        -     endpoints (masters) and sondas
        -     zones with hosts which connect to one or another of these zones
        -     cerate variables to use in service commands
        -     email and schangestate notifications