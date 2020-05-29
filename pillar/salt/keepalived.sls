
keepalived:
  config:
    state: MASTER
    interface: br0
    priority: 200
    virtual_ipaddress: 192.168.1.10


