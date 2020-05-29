
keepalived:
  config:
    state: BACKUP
    interface: eno1
    priority: 100
    virtual_ipaddress: 192.168.1.10

