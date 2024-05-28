FROM internetsystemsconsortium/bind9:9.18

COPY ./data/named.conf /etc/bind/named.conf
COPY ./data/l1-3.ephec-ti.be.zone /etc/bind/l1-3.ephec-ti.be.zone

RUN chown -R bind:bind /etc/bind/

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]

