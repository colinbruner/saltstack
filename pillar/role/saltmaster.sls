
haproxy:
  config:
    http_port: 8080
    https_port: 8443
    virtual_ip: 192.168.1.10
    backend:
      - name: ip-0
        address: kube1.home:30443
      - name: ip-1
        address: node1.home:30443
      - name: ip-2
        address: node2.home:30443
      - name: ip-3
        address: node3.home:30443
      - name: ip-4
        address: node4.home:30443

system:
  firewall:
    zones: 
      - name: public 
        ports: 
          - 5900-6000/tcp # qemu vnc
          - 4505/tcp      # salt
          - 4506/tcp      # salt
          - 8443/tcp      # haproxy - homepage
          - 9000/tcp      # haproxy - stats
