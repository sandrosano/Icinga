FROM docker.io/jrei/systemd-debian:latest
RUN passwd -d root
COPY ./install.sh /install.sh
COPY ./config.sh /config.sh
# COPY ./ca/ca.key /var/lib/icinga2/ca/ca.key
# COPY ./ca/ca.crt /var/lib/icinga2/ca/ca.crt
# COPY ./ca/ca.crt /var/lib/icinga2/certs/ca.crt
RUN chmod +x /install.sh /config.sh 
RUN /install.sh

# RUN chown -R nagios:nagios /var/lib/icinga2/ca 
# RUN chown -R nagios:nagios /var/lib/icinga2/certs


EXPOSE 5665 80 22 443 6380
USER root
# ENTRYPOINT ["/lib/systemd/systemd"]
# CMD ["/lib/systemd/systemd"]
# CMD ["/bin/bash"]
