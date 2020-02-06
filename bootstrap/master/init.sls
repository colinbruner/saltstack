{% from "bootstrap/map.jinja" import bootstrap with context %}

{% set config = bootstrap.master.config %}

include:
  - .pkgs
  - .configs

manage_public_zone:
  firewalld.present:
    - name: public
    - services:
      - cockpit
      - dhcpv6-client
      - ssh
    - ports:
      - 4505/tcp
      - 4506/tcp

start_salt_master:
  service.running:
    - name: salt-master
      enable: True
    - watch:
      - file: {{ config.dest }} 
