
system:
  firewall:
    zones: 
      - name: public 
        ports: 
          - 5900-6000/tcp # qemu vnc
          - 4505/tcp      # salt
          - 4506/tcp      # salt
          - 8080/tcp      # haproxy - homepage
          - 8443/tcp      # haproxy - homepage
