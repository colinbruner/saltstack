{% set config = bootstrap.master.config %}

include:
  - ./pkgs
  - ./configs

start_salt_master:
  service.running:
    - name: salt-master
      enable: True
    - watch:
      - file: {{ config.dest }} 
