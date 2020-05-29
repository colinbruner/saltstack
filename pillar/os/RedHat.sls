---

system:
  firewall:
    zones:
      - name: public
        services:
          - cockpit
          - dhcpv6-client
          - ssh
